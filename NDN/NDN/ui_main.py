import sys
import os
import re
import time
from PyQt5.QtWidgets import (
    QApplication, QMainWindow, QWidget, QListWidget, QGraphicsView,
    QGraphicsScene, QGraphicsPixmapItem, QMessageBox, QVBoxLayout,
    QHBoxLayout, QLabel, QPushButton, QInputDialog, QGraphicsLineItem,
    QDialog, QTableWidget, QTableWidgetItem, QTabWidget, QHeaderView
)
from PyQt5.QtGui import QPixmap, QPen, QBrush, QColor, QPainterPath
from PyQt5.QtCore import Qt, QPointF, QTimer

from core.dilithium_hw import generate_keys,verify
from core.dilithium_hw import sign
from core.network import Network
from core.dilithium_hw import generate_keys  # Import the generate_keys function
from PyQt5.QtCore import Qt, QPointF, QTimer, QRectF, QSizeF
from PyQt5.QtGui import QTextCursor, QTextCharFormat, QBrush, QColor



ICON_PATH = {
    "Consumer": "assets/consumer.jpeg",
    "Producer": "assets/producer.png",
    "Router": "assets/router.jpeg",
    "CA": "assets/ca.png",
    "Link": "assets/line.png"
}

items = [
    ("Consumer", "icons/consumer.png"),
    ("Producer", "icons/producer.png"),
    ("Router", "icons/router.png"),
    ("CA", "icons/ca.png"),
    ("Link", "icons/link.png"),
]

class RouterTablesDialog(QDialog):
    def __init__(self, router, parent=None):
        super().__init__(parent)
        self.router = router
        self.setWindowTitle(f"Router {router.name} Tables")
        self.setGeometry(200, 200, 800, 600)
        self.init_ui()        

    def init_ui(self):
        layout = QVBoxLayout()
        
        # Create tab widget for different tables
        tabs = QTabWidget()
        
        # Content Store Table
        cs_table = QTableWidget()
        cs_table.setColumnCount(2)
        cs_table.setHorizontalHeaderLabels(["Name", "Data"])
        cs_table.horizontalHeader().setSectionResizeMode(QHeaderView.Stretch)
        
        # PIT Table
        pit_table = QTableWidget()
        pit_table.setColumnCount(2)
        pit_table.setHorizontalHeaderLabels(["Name", "Incoming Interface"])
        pit_table.horizontalHeader().setSectionResizeMode(QHeaderView.Stretch)
        
        # FIB Table
        fib_table = QTableWidget()
        fib_table.setColumnCount(2)
        fib_table.setHorizontalHeaderLabels(["Name", "Outgoing Interface"])
        fib_table.horizontalHeader().setSectionResizeMode(QHeaderView.Stretch)
        
        # Add tables to tabs
        tabs.addTab(cs_table, "Content Store")
        tabs.addTab(pit_table, "Pending Interest Table")
        tabs.addTab(fib_table, "Forwarding Information Base")
        
        # Update tables with current data
        self.update_tables(cs_table, pit_table, fib_table)
        
        # Add refresh button
        refresh_btn = QPushButton("Refresh Tables")
        refresh_btn.clicked.connect(lambda: self.update_tables(cs_table, pit_table, fib_table))
        
        layout.addWidget(tabs)
        layout.addWidget(refresh_btn)
        self.setLayout(layout)

    def update_tables(self, cs_table, pit_table, fib_table):
        # Update CS Table
        cs_table.setRowCount(len(self.router.cs))
        for i, (name, data) in enumerate(self.router.cs.items()):
            cs_table.setItem(i, 0, QTableWidgetItem(name))
            cs_table.setItem(i, 1, QTableWidgetItem(str(data)))
        
        # Update PIT Table
        pit_table.setRowCount(len(self.router.pit))
        for i, (name, interfaces) in enumerate(self.router.pit.items()):
            pit_table.setItem(i, 0, QTableWidgetItem(name))
            pit_table.setItem(i, 1, QTableWidgetItem(", ".join(str(iface.name) for iface in interfaces)))
        
        # Update FIB Table
        fib_table.setRowCount(len(self.router.fib))
        for i, (name, entry) in enumerate(self.router.fib.items()):
            fib_table.setItem(i, 0, QTableWidgetItem(name))
            fib_table.setItem(i, 1, QTableWidgetItem(entry.next_hop.name))

class NodeItem(QGraphicsPixmapItem):
    def __init__(self, name, pixmap, pos, node_type, window_ref):
        super().__init__(pixmap)
        self.setPos(pos)
        self.setFlag(QGraphicsPixmapItem.ItemIsMovable)
        self.setFlag(QGraphicsPixmapItem.ItemIsSelectable)
        self.setFlag(QGraphicsPixmapItem.ItemSendsGeometryChanges)
        self.name = name
        self.type = node_type
        self.window_ref = window_ref

        self.text_label = self.window_ref.canvas.addText(name)
        self.text_label.setDefaultTextColor(Qt.black)
        self.update_label_position()

    def update_label_position(self):
        self.text_label.setPos(self.x(), self.y() + 65)

    def itemChange(self, change, value):
        if change == QGraphicsPixmapItem.ItemPositionChange:
            new_pos = value
            self.text_label.setPos(new_pos.x(), new_pos.y() + 65)
            self.update_links()
        return super().itemChange(change, value)

    def update_links(self):
        for link in self.window_ref.links:
            if self in link['nodes']:
                node1, node2 = link['nodes']
                p1 = node1.pos() + QPointF(30, 30)
                p2 = node2.pos() + QPointF(30, 30)
                link['line'].setLine(p1.x(), p1.y(), p2.x(), p2.y())

    def mousePressEvent(self, event):
        super().mousePressEvent(event)
        if event.button() == Qt.LeftButton:
            if self.window_ref.link_mode:
                self.window_ref.handle_link_click(self)
            elif self.window_ref.delete_mode:
                confirm = QMessageBox.question(
                    self.window_ref, "Confirm Delete",
                    f"Delete '{self.name}' and all its links?",
                    QMessageBox.Yes | QMessageBox.No)
                if confirm == QMessageBox.Yes:
                    self.window_ref.delete_node(self)
                    self.window_ref.delete_mode = False

    def mouseDoubleClickEvent(self, event):
        if self.type == "Router":
            router = next((r for r in self.window_ref.network.routers if r.name == self.name), None)
            if router:
                dialog = RouterTablesDialog(router, self.window_ref)
                dialog.exec_()
        super().mouseDoubleClickEvent(event)

class NDNMainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Athestia NDN GUI")
        self.setGeometry(100, 100, 1200, 700)
        self.network = Network()
        self.node_items = {}
        self.selected_nodes_for_link = []
        self.links = []
        self.link_mode = False
        self.delete_mode = False
        self.router_count = 0  # To keep track of routers
        self.key_generation_in_progress = False  # Flag to track key generation
        self.init_ui()
        


    def mousePressEvent(self, event):
        if self.snip_mode and event.button() == Qt.LeftButton:
            self.snip_start = self.canvas_view.mapToScene(event.pos())
            start = self.canvas_view.mapToScene(event.pos())
            end = self.canvas_view.mapToScene(event.pos())

            rect = QRectF(start, end).normalized()
            self.snip_rect_item = self.canvas.addRect(rect, QPen(Qt.red, 2, Qt.DashLine))

    def mouseMoveEvent(self, event):
        if self.snip_mode and hasattr(self, 'snip_rect_item'):
            current_pos = self.canvas_view.mapToScene(event.pos())
            rect = QRectF(self.snip_start, current_pos).normalized()
            self.snip_rect_item.setRect(rect)

    def mouseReleaseEvent(self, event):
        if self.snip_mode and hasattr(self, 'snip_rect_item'):
            self.snip_mode = False
            QMessageBox.information(self, "Snip Complete", "You have selected an area.")
            # Optionally: do something with self.snip_rect_item.rect()


    def toggle_animation(self):
        self.playing = not self.playing
        if self.playing:
            self.pause_play_btn.setText("Pause")
            if hasattr(self, 'animation_timer') and self.animation_timer.isActive() is False:
                self.animation_timer.start()
        else:
            self.pause_play_btn.setText("Play")
            if hasattr(self, 'animation_timer') and self.animation_timer.isActive():
                self.animation_timer.stop() 

    def enable_snip_mode(self):
        self.snip_mode = True
        QMessageBox.information(self, "Snip Mode", "Click and drag to select an area on the canvas.")
       
    def eventFilter(self, obj, event):
        if self.snip_mode and obj == self.canvas_view.viewport():
            if event.type() == event.MouseButtonPress and event.button() == Qt.LeftButton:
                self.snip_start = self.canvas_view.mapToScene(event.pos())
                self.snip_rect_item = self.canvas.addRect(QRectF(self.snip_start, self.snip_start), QPen(Qt.red, 2, Qt.DashLine))
                return True

            elif event.type() == event.MouseMove and hasattr(self, 'snip_rect_item'):
                current_pos = self.canvas_view.mapToScene(event.pos())
                self.snip_rect_item.setRect(QRectF(self.snip_start, current_pos).normalized())
                return True

            elif event.type() == event.MouseButtonRelease and hasattr(self, 'snip_rect_item'):
                self.snip_mode = False

                snip_rect = self.snip_rect_item.rect()

                # Delete all items inside the snipped area (except the rect itself)
                for item in self.canvas.items(snip_rect):
                    if item is not self.snip_rect_item:
                        self.canvas.removeItem(item)

                # Remove the snip rectangle itself
                self.canvas.removeItem(self.snip_rect_item)
                del self.snip_rect_item

                QMessageBox.information(self, "Snip Complete", "Selected area deleted.")
                return True

        return super().eventFilter(obj, event)

    def init_ui(self):
        central_widget = QWidget()
        layout = QHBoxLayout()
        central_widget.setLayout(layout)

        self.component_list = QListWidget()
        self.component_list.addItems(["Consumer", "Producer", "Router", "CA", "Link"])
        self.component_list.setFixedWidth(150)
        self.component_list.itemDoubleClicked.connect(self.add_node)

        self.canvas = QGraphicsScene()
        self.canvas.setSceneRect(0, 0, 1000, 700)
        self.canvas_view = QGraphicsView(self.canvas)

        button_panel = QVBoxLayout()
        self.playing = True  # Animation state
        self.pause_play_btn = QPushButton("Pause")
        self.pause_play_btn.clicked.connect(self.toggle_animation)
        # self.simulate_btn = QPushButton("Simulate Interest Flow")
        # self.simulate_btn.clicked.connect(self.simulate)
        self.request_btn = QPushButton("Request Content")
        self.request_btn.clicked.connect(self.request_content)
        self.delete_btn = QPushButton("Delete Component")
        self.delete_btn.clicked.connect(self.enable_delete_mode)
        self.complete_topology_btn = QPushButton("Complete Topology (Generate Keys)")
        self.complete_topology_btn.clicked.connect(self.complete_topology)
        self.snip_mode = False
        self.snip_button = QPushButton("Snip Area")
        self.snip_button.clicked.connect(self.enable_snip_mode)
        button_panel.addWidget(self.snip_button)
        self.canvas_view.viewport().installEventFilter(self)


        button_panel.addStretch()
        button_panel.addWidget(self.pause_play_btn)     
        # button_panel.addWidget(self.simulate_btn)
        button_panel.addWidget(self.request_btn)
        button_panel.addWidget(self.delete_btn)
        button_panel.addWidget(self.complete_topology_btn)  # Add new button

        layout.addWidget(self.component_list)
        layout.addWidget(self.canvas_view)
        layout.addLayout(button_panel)
        self.setCentralWidget(central_widget)

    def get_next_hop_router(self, from_node_item):
        """
        Returns the first directly connected Router node from the given node.
        """
        for link in self.links:
            if from_node_item in link["nodes"]:
                other = link["nodes"][0] if link["nodes"][1] == from_node_item else link["nodes"][1]
                if other.type == "Router":
                    return other
        return None


    def add_node(self, item):
        name = item.text()

        if name == "Link":
            self.link_mode = True
            self.selected_nodes_for_link.clear()
            QMessageBox.information(self, "Link Mode", "Link mode activated. Click on two nodes to connect them.")
            return

        if name == "CA":
            label = "Certificate Authority"
        elif name == "Producer":
            valid_producers = ["youtube", "netflix", "blog", "food", "scholar"]
            label, ok = QInputDialog.getItem(
                self, "Select Producer", "Choose a Producer category:",
                valid_producers, editable=False)
            if not ok or not label:
                return
        else:
            label, ok = QInputDialog.getText(self, "Node Name", f"Enter name for {name}:")
            if not ok or not label:
                return

            if label in self.node_items:
                QMessageBox.warning(self, "Duplicate Name", f"A node named '{label}' already exists.")
                return

            if name == "Consumer" and not re.match(r'^[a-zA-Z]+[0-9]+$', label):
                QMessageBox.warning(self, "Invalid Name", "Consumer name must be letters followed by digits.")
                return

            if name == "Router":
                # Automatically assign router number if it's the first router
                if self.router_count == 0:
                    if label != "1":
                        QMessageBox.warning(self, "Invalid Name", "The first router must be named '1'.")
                        return
                else:
                    # Ensure the router number is sequential
                    if not label.isdigit():
                        QMessageBox.warning(self, "Invalid Name", "Router name must be digits only.")
                        return
                    if int(label) != self.router_count + 1:
                        QMessageBox.warning(self, "Invalid Name", f"Router names must be in sequential order starting from 1.")
                        return
                self.router_count += 1

            if name == "Router" and not label.isdigit():
                QMessageBox.warning(self, "Invalid Name", "Router name must be digits only.")
                return

        if label in self.node_items:
            QMessageBox.warning(self, "Duplicate Name", f"A node named '{label}' already exists.")
            return

        pos = QPointF(100 + len(self.node_items) * 120, 100 + (len(self.node_items) % 3) * 100)

        pixmap_path = ICON_PATH.get(name, "")
        if not os.path.exists(pixmap_path):
            QMessageBox.warning(self, "Missing Icon", f"Icon for {name} not found at {pixmap_path}.")
            return
        pixmap = QPixmap(pixmap_path)
        if pixmap.isNull():
            QMessageBox.warning(self, "Invalid Pixmap", f"Failed to load pixmap for {name}.")
            return
        pixmap = pixmap.scaled(60, 60)

        # Create the node in the network
        if name == "Consumer":
            node = self.network.add_consumer(label)
        elif name == "Producer":
            node = self.network.add_producer(label)
        elif name == "Router":
            node = self.network.add_router(label)
        elif name == "CA":
            node = self.network.ca

        node_item = NodeItem(label, pixmap, pos, name, self)
        self.canvas.addItem(node_item)
        self.node_items[label] = node_item
        print(f"Added {name} '{label}' at position {pos}.")

    def handle_link_click(self, node_item):
        self.selected_nodes_for_link.append(node_item)
        node_item.setSelected(True)

        if len(self.selected_nodes_for_link) == 2:
            node1, node2 = self.selected_nodes_for_link
            type1, type2 = node1.type.lower(), node2.type.lower()

            if ('producer' in type1 and 'consumer' in type2) or ('consumer' in type1 and 'producer' in type2):
                QMessageBox.warning(self, "Invalid Link", "Producer cannot connect directly to Consumer.")
            elif ('ca' in type1 and 'router' in type2) or ('router' in type1 and 'ca' in type2):
                QMessageBox.warning(self, "Invalid Link", "CA can only connect to Producer or Consumer.")
            else:
                self.create_link(node1, node2)

            self.selected_nodes_for_link.clear()
            self.link_mode = False
            self.delete_mode = False

    def create_link(self, node1, node2):
        p1 = node1.pos() + QPointF(30, 30)
        p2 = node2.pos() + QPointF(30, 30)
        line = QGraphicsLineItem(p1.x(), p1.y(), p2.x(), p2.y())
        line.setPen(QPen(Qt.black, 2))
        self.canvas.addItem(line)
        self.links.append({'line': line, 'nodes': (node1, node2)})
        
        # Create the link in the network
        network_node1 = self.network.get_node_by_name(node1.name)
        network_node2 = self.network.get_node_by_name(node2.name)
        if network_node1 and network_node2:
            self.network.add_link(network_node1, network_node2)
            # Update FIB entries after adding link
            # self.network.setup_fib()

    def delete_node(self, node_item):
        to_remove = [link for link in self.links if node_item in link["nodes"]]
        for link in to_remove:
            self.canvas.removeItem(link["line"])
            self.links.remove(link)

        if node_item.text_label:
            self.canvas.removeItem(node_item.text_label)
        self.canvas.removeItem(node_item)
        self.node_items.pop(node_item.name, None)
        print(f"Deleted node {node_item.name}")

    def enable_delete_mode(self):
        self.delete_mode = True
        QMessageBox.information(self, "Delete Mode", "Click a node to delete.")
 
    def complete_topology(self):
        if self.key_generation_in_progress:
            QMessageBox.warning(self, "Wait", "Key generation already in progress.")
            return

        self.key_generation_in_progress = True
        QMessageBox.information(self, "Key Generation", "Generating Dilithium keys for CA...")

        # Generate keys
        public_key, secret_key = generate_keys()

        # Store CA keys in a dict
        if not hasattr(self, 'content_key_map'):
            self.content_key_map = {}  # initialize if not exists
        self.content_key_map["CA"] = {
            "ca_pk": public_key,
            "ca_sk": secret_key
        }

        # Trigger key installation after a short delay
        QTimer.singleShot(3000, lambda: self.on_key_generation_complete(public_key))

    def on_key_generation_complete(self, ca_public_key):
        # Find the CA node and display the public key
        for node_item in self.node_items.values():
            if node_item.type == "CA":
                truncated_key = ca_public_key[:6] + "..."
                node_item.text_label.setPlainText(f"{node_item.name}\n{truncated_key}")
                self.display_key_on_consumers(ca_public_key)

        # Enable further actions
        self.key_generation_in_progress = False
        QMessageBox.information(self, "Key Generation Complete", "CA's Dilithium keys have been generated.")

    def display_key_on_consumers(self, ca_public_key):
        consumers = [node for node in self.node_items.values() if node.type == "Consumer"]
        ca_node = next((n for n in self.node_items.values() if n.type == "CA"), None)

        if not ca_node:
            return

        for consumer in consumers:
            start = ca_node.pos() + QPointF(30, 30)
            end = consumer.pos() + QPointF(30, 30)
            
            # Replace the ellipse with an email icon pixmap for animation
            email_icon_path = "assets/email_icon.png"  # Make sure this icon exists
            if os.path.exists(email_icon_path):
                email_pixmap = QPixmap(email_icon_path).scaled(20, 20, Qt.KeepAspectRatio)
                packet = QGraphicsPixmapItem(email_pixmap)
            else:
                # fallback to ellipse if icon missing
                packet = self.canvas.addEllipse(0, 0, 20, 20, QPen(Qt.blue), QBrush(Qt.blue))

            packet.setZValue(10)  # Ensure it's above lines
            self.canvas.addItem(packet)

            path = QPainterPath()
            path.moveTo(start)
            path.lineTo(end)
            self.animate_packet(packet, path)

            
            # Delay actual key installation text slightly for visual sync
            QTimer.singleShot(1000, lambda c=consumer: self.canvas.addText("CA Key Installed").setPos(c.x(), c.y() + 100))

    def simulate(self):
        # Check if at least one producer, consumer, router, and CA are present
        required_types = ["Producer", "Consumer", "Router", "CA"]
        node_types = [node.type for node in self.node_items.values()]
        
        if not all(req in node_types for req in required_types):
            QMessageBox.warning(self, "Incomplete Topology", 
                                "Please add at least one Producer, one Consumer, one Router, and one Certificate Authority to complete the topology.")
            return

        # Continue with the rest of the simulation if topology is complete
        if len(self.node_items) < 2:
            QMessageBox.warning(self, "Not Enough Nodes", "Add at least 2 nodes.")
            return

        names = list(self.node_items.keys())
        path = QPainterPath()
        start = self.node_items[names[0]].pos()
        path.moveTo(start.x() + 30, start.y() + 30)

        for name in names[1:]:
            pos = self.node_items[name].pos()
            path.lineTo(pos.x() + 30, pos.y() + 30)

        packet = self.canvas.addEllipse(0, 0, 20, 20, QPen(Qt.red), QBrush(Qt.red))
        self.animate_packet(packet, path)

    def update_fib_entry_dynamic(self, router_obj, from_node, content_name):
        content_prefix = "/" + content_name.split('/')[0]  # e.g., "/youtube"

        if content_prefix not in router_obj.fib:
            # If the interest came from a consumer → store producer as next hop
            if from_node.type == "Consumer":
                next_hop = self.get_next_hop_router(from_node)
            # If the data came from a producer → store consumer as next hop
            elif from_node.type == "Producer":
                # Find consumer via PIT
                consumers = router_obj.pit.get(content_name, [])
                next_hop = consumers[0] if consumers else None
            else:
                next_hop = None

            if next_hop:
                router_obj.add_fib_entry(content_prefix, next_hop)
                print(f"📡 FIB updated at Router {router_obj.name}: {content_prefix} → {next_hop.name}")



    def request_content(self):
        if self.key_generation_in_progress:
            QMessageBox.warning(self, "Key Generation in Progress", "Please wait until key installation is completed.")
            return

        # Check if at least one producer, consumer, router, and CA are present
        required_types = ["Producer", "Consumer", "Router", "CA"]
        node_types = [node.type for node in self.node_items.values()]
        
        if not all(req in node_types for req in required_types):
            QMessageBox.warning(self, "Incomplete Topology", 
                                "Please add at least one Producer, one Consumer, one Router, and one Certificate Authority to complete the topology.")
            return

        selected = [item for item in self.node_items.values() if item.isSelected()]
        if len(selected) != 1 or selected[0].type != "Consumer":
            QMessageBox.warning(self, "Invalid", "Select one Consumer to request content.")
            return

        consumer = selected[0]
        valid_producers = []
        for link in self.links:
            n1, n2 = link["nodes"]
            if consumer in (n1, n2):
                other = n2 if n1 == consumer else n1
                if other.type == "Router":
                    for l2 in self.links:
                        if other in l2["nodes"]:
                            other2 = l2["nodes"][0] if l2["nodes"][1] == other else l2["nodes"][1]
                            if other2.type == "Producer" and other2 not in valid_producers:
                                valid_producers.append(other2)

        if not valid_producers:
            QMessageBox.warning(self, "No Producers", "No producer connected via a router.")
            return

        producer = valid_producers[0]  # Assume one producer for now
        content_paths = {
            "youtube": ["/youtube/video/2025/1", "/youtube/video/ai/intro"],
            "netflix": ["/netflix/movie/action", "/netflix/show/space"],
            "blog": ["/blog/tech/2025", "/blog/life/motivation"],
            "food": ["/food/recipe/pasta", "/food/recipe/sweets"],
            "scholar": ["/scholar/research/ai", "/scholar/thesis/security"]
        }

        # Display dropdown with specific content paths based on producer
        content_options = content_paths.get(producer.name, [])
        content_path, ok = QInputDialog.getItem(
            self, "Select Content", f"Choose content to request from {producer.name}:",
            content_options, editable=False
        )

        if not ok or not content_path:
            return
        QMessageBox.information(self, "Request Sent", f"{consumer.name} is requesting:\n{content_path}")

        # Step 1: Find connected Router
        connected_router = None
        for link in self.links:
            n1, n2 = link["nodes"]
            if consumer in (n1, n2):
                other = n2 if n1 == consumer else n1
                if other.type == "Router":
                    connected_router = other
                    break

        if not connected_router:
            QMessageBox.warning(self, "No Router", "No router connected to the selected consumer.")
            return

        # Step 2: Create path from Consumer to Router
        start_pos = consumer.pos() + QPointF(30, 30)
        end_pos = connected_router.pos() + QPointF(30, 30)
        path = QPainterPath()
        path.moveTo(start_pos)
        path.lineTo(end_pos)

        router_obj = self.network.get_node_by_name(connected_router.name)
        producer_obj = self.network.get_node_by_name(producer.name)
        content_name = content_path

        if router_obj:
            # 🧠 Update PIT
            if content_name not in router_obj.pit:
                router_obj.pit[content_name] = [self.network.get_node_by_name(consumer.name)]
            else:
                if self.network.get_node_by_name(consumer.name) not in router_obj.pit[content_name]:
                    router_obj.pit[content_name].append(self.network.get_node_by_name(consumer.name))
            print(f"📥 Router {router_obj.name} updated PIT with: {content_name} from {consumer.name}")

            # 🧠 Update FIB
            content_prefix = "/" + content_name  # e.g. "/youtube"
            router_obj.add_fib_entry(content_prefix, producer_obj)
            print(f"📦 Router {router_obj.name} FIB set: {content_prefix} → {producer_obj}")


        # Step 3: Create and animate the Interest Packet
        # Step 4: Build multi-hop QPainterPath: Consumer → Router → Producer
            consumer_pos = consumer.pos() + QPointF(30, 30)
            router_pos = connected_router.pos() + QPointF(30, 30)
            producer_item = self.node_items.get(producer.name)
            if not producer_item:
                QMessageBox.warning(self, "Error", f"Producer node '{producer.name}' not found.")
                return
            producer_pos = producer_item.pos() + QPointF(30, 30)

            path = QPainterPath()
            path.moveTo(consumer_pos)
            path.lineTo(router_pos)
            path.lineTo(producer_pos)

            packet = self.canvas.addEllipse(0, 0, 20, 20, QPen(Qt.blue), QBrush(Qt.blue))
            packet.setZValue(10)

            # Optional label for content name near consumer
            label = self.canvas.addText(f"{content_name}")
            label.setPos(consumer_pos.x(), consumer_pos.y() + 25)
            label.setDefaultTextColor(Qt.black)

            def on_packet_arrival():
                producer_center = producer_pos + QPointF(0, -30)

                # Step 1: Show "Generating Keys..."
                self.show_temporary_message("🔐 Generating Keys...", producer_center, duration=2000, background=QColor("orange"))

                # Step 2: Generate keys
                pub_key, sec_key = generate_keys()

                # Store keys with respect to content name
                if not hasattr(self, 'content_key_map'):
                    self.content_key_map = {}  # initialize if doesn't exist
                self.content_key_map[content_name] = {
                    "producer_pk": pub_key,
                    "producer_sk": sec_key
                }

                # Attach keys to producer node (optional)
                producer_item.dilithium_keys = (pub_key, sec_key)

                # Step 3: Show PK
                pub_display = pub_key[:12] + "..."
                self.show_temporary_message(f"PK: {pub_display}", producer_center + QPointF(0, 20), duration=2000, background=QColor("lightgreen"))

                # Step 4: After delay, simulate loading and proceed to CA
                QTimer.singleShot(2100, lambda: self.simulate_loading_and_sign(producer_center + QPointF(0, 40), content_name, sec_key))


            self.animate_packet(packet, path, on_complete=on_packet_arrival)

    def get_content_icon_path(self, content_path):
        if content_path.startswith("/youtube/"):
            return "assets/youtube.png"
        elif content_path.startswith("/netflix/"):
            return "assets/netflix.png"
        elif content_path.startswith("/blog/"):
            return "assets/blog.png"
        elif content_path.startswith("/food/"):
            return "assets/food.png"
        elif content_path.startswith("/scholar/"):
            return "assets/scholar.png"
        else:
            return None


    def simulate_loading_and_sign(self, pos, content, secret_key):
        label = self.canvas.addText("✍️ Signing Content...")
        label.setDefaultTextColor(Qt.black)
        label.setZValue(20)
        label.setPos(pos)

        bar_width = 100
        bar_height = 10
        bg_rect = self.canvas.addRect(QRectF(pos + QPointF(0, 20), QSizeF(bar_width, bar_height)), QPen(Qt.black), QBrush(Qt.white))
        fill_rect = self.canvas.addRect(QRectF(pos + QPointF(0, 20), QSizeF(0, bar_height)), QPen(Qt.NoPen), QBrush(Qt.blue))
        fill_rect.setZValue(21)
        bg_rect.setZValue(20)

        progress = {'val': 0}


        def update_bar():
            if progress['val'] >= bar_width:
                self.canvas.removeItem(label)
                self.canvas.removeItem(bg_rect)
                self.canvas.removeItem(fill_rect)
                timer.stop()

                # Step 5: Sign content
                signature = sign(content, secret_key)
                sig_display = signature[:16] + "..."  # full is long

                # Show permanent signature label
                sig_label = self.canvas.addText(f"Signature: {sig_display}")
                sig_label.setDefaultTextColor(Qt.darkBlue)
                sig_label.setZValue(20)
                sig_label.setPos(pos + QPointF(0, 40))

                # Set background color
                cursor = QTextCursor(sig_label.document())
                cursor.select(QTextCursor.Document)
                fmt = QTextCharFormat()
                fmt.setBackground(QBrush(QColor("lightyellow")))  # Choose your desired background color
                cursor.mergeCharFormat(fmt)

                # Show content icon based on content path
                icon_path = self.get_content_icon_path(content)
                if icon_path and os.path.exists(icon_path):
                    icon_pixmap = QPixmap(icon_path).scaled(40, 40, Qt.KeepAspectRatio, Qt.SmoothTransformation)
                    icon_item = QGraphicsPixmapItem(icon_pixmap)
                    icon_item.setPos(pos + QPointF(160, 35))
                    icon_item.setZValue(19)
                    self.canvas.addItem(icon_item)

                return

            progress['val'] += 5
            fill_rect.setRect(QRectF(pos + QPointF(0, 20), QSizeF(progress['val'], bar_height)))

        timer = QTimer()
        timer.timeout.connect(update_bar)
        timer.start(100)

        QTimer.singleShot(2100, lambda: self.sign_with_ca(pos + QPointF(0, 30), content))

                    
    def sign_with_ca(self, pos, content_name):
        # Step 1: Ensure CA keys are initialized
        if not hasattr(self, 'ca_keys'):
            self.ca_keys = generate_keys()
        ca_pk, ca_sk = self.ca_keys

        # Step 2: Fetch Producer's PK
        producer_pk = self.content_key_map[content_name]["producer_pk"]

        # Step 3: Find Producer and CA nodes
        producer_node = None
        ca_node = None
        for node in self.node_items.values():
            if hasattr(node, "dilithium_keys") and node.dilithium_keys[0] == producer_pk:
                producer_node = node
            if node.type == "CA":
                ca_node = node

        if not producer_node or not ca_node:
            QMessageBox.warning(self, "Missing Nodes", "Could not locate Producer or CA node.")
            return

        # Step 4: Build path from Producer to CA
        start = producer_node.pos() + QPointF(30, 30)
        end = ca_node.pos() + QPointF(30, 30)

        path = QPainterPath()
        path.moveTo(start)
        path.lineTo(end)

        # Step 5: Create and animate packet (can use a key icon or simple ellipse)
        packet = self.canvas.addEllipse(0, 0, 20, 20, QPen(Qt.darkCyan), QBrush(Qt.cyan))
        packet.setZValue(15)

        def after_arrival():
            self.canvas.removeItem(packet)
            self._finish_ca_signing(end, content_name, producer_pk, ca_sk, None)

        self.animate_packet(packet, path, on_complete=after_arrival)

    def print_all_ndn_state(self):
        print("\n🧾 === NDN NETWORK STATE ===\n")

        if hasattr(self, "content_key_map"):
            print("🔐 Content Key Map (Producer → Keys):")
            for content, data in self.content_key_map.items():
                pk = data.get("producer_pk", "")[:10] + "..."
                sk = data.get("producer_sk", "")[:10] + "..."
                cert = data.get("certificate", "")[:10] + "..."
                print(f"  - {content}")
                print(f"    → PK: {pk}")
                print(f"    → SK: {sk}")
                print(f"    → Certificate: {cert}")

        print("\n📦 Stored Content in Routers (CS):")
        for router in self.network.routers:
            if router.cs:
                print(f"  📡 Router {router.name}:")
                for name, data in router.cs.items():
                    sig = data.get("signature", "")
                    cert = data.get("certificate", "")
                    print(f"    - {name}")
                    print(f"      → Signature: {sig}")
                    print(f"      → Cert: {cert}")

        print("\n📭 Remaining PIT Entries:")
        for router in self.network.routers:
            if router.pit:
                print(f"  📡 Router {router.name}:")
                for name, faces in router.pit.items():
                    face_names = [f.name for f in faces]
                    print(f"    - {name} → {face_names}")

        print("\n📡 Current FIB Entries:")
        for router in self.network.routers:
            if router.fib:
                print(f"  📡 Router {router.name}:")
                for name, entry in router.fib.items():
                    print(f"    - {name} → {entry.next_hop.name}")

        print("\n✅ End of NDN State\n")



    def animate_certificate_to_router(self, producer_node, router_node):
        if not producer_node or not router_node:
            QMessageBox.warning(self, "Missing Nodes", "Producer or Router not found.")
            return

        # 1. Create the 📜 packet (you can use an icon or styled ellipse)
        packet = self.canvas.addText("📜")
        packet.setZValue(15)

        # 2. Define start and end positions
        start_pos = producer_node.pos() + QPointF(30, 30)
        end_pos = router_node.pos() + QPointF(30, 30)

        path = QPainterPath()
        path.moveTo(start_pos)
        path.lineTo(end_pos)

        # 3. Animate the movement
        def on_arrival():
            self.canvas.removeItem(packet)
            msg = self.canvas.addText(f"📦 Data Packet Received at {router_node.name}")
            msg.setDefaultTextColor(Qt.darkMagenta)
            msg.setZValue(20)
            msg.setPos(end_pos + QPointF(0, -30))

            QTimer.singleShot(3000, lambda: self.canvas.removeItem(msg))

        self.animate_packet(packet, path, on_complete=on_arrival)


    def traverse_data_to_consumer(self, from_node, to_node, content_name):
        packet = self.canvas.addText("📦")
        packet.setZValue(15)

        start = from_node.pos() + QPointF(30, 30)
        end = to_node.pos() + QPointF(30, 30)

        path = QPainterPath()
        path.moveTo(start)
        path.lineTo(end)

        # Setup the animation
        animation_steps = 30
        delay = 30
        dx = (end.x() - start.x()) / animation_steps
        dy = (end.y() - start.y()) / animation_steps
        current_step = 0

        def animate():
            nonlocal current_step
            if current_step < animation_steps:
                packet.setPos(start + QPointF(dx * current_step, dy * current_step))
                current_step += 1
                QTimer.singleShot(delay, animate)
            else:
                on_arrival()

        def on_arrival():
            self.canvas.removeItem(packet)

            # ✅ Show delivery message
            msg = self.canvas.addText(f"📦 Data Delivered to {to_node.name}")
            msg.setDefaultTextColor(Qt.darkGreen)
            msg.setZValue(20)
            msg.setPos(end + QPointF(0, -25))
            QTimer.singleShot(4000, lambda: self.canvas.removeItem(msg))

            # Attempt to find router and remove FIB entry
            content_prefix = content_name if '/' in content_name else content_name

            router_obj = self.network.get_node_by_name(from_node.name)
            consumer_obj = self.network.get_node_by_name(to_node.name)

            if router_obj and hasattr(router_obj, "fib") and content_prefix in router_obj.fib:
                del router_obj.fib[content_prefix]
                print(f"🧹 Removed FIB entry {content_prefix} → {consumer_obj.name} after delivery.")

        animate()
            

                            
            # ✅ Then show CA verification message at consumer
            # self.show_temporary_message(
            #     "🔍 NOW, Verifying CA Certificate (Producer PK)...",
            #     end + QPointF(0, -50),
            #     duration=3000,
            #     background=QColor("lightcyan")
            # )
            # QTimer.singleShot(3000, lambda: self.perform_ca_verification(content_name, end))

        self.animate_packet(packet, path, on_complete=on_arrival)
        self.print_all_ndn_state()
        

    def perform_ca_verification(self, content_name, display_position):
        try:
            # Get keys from content_key_map
            ca_keys = self.content_key_map.get("CA", {})
            producer_keys = self.content_key_map.get(content_name, {})

            ca_pk = ca_keys.get("ca_pk")
            producer_pk = producer_keys.get("producer_pk")
            certificate = producer_keys.get("certificate")  # Simulated or real signature of producer_pk

            # ✅ Simulate certificate if not set
            if certificate is None:
                certificate = sign(producer_pk, ca_keys.get("ca_sk"))  # You must define `sign()` too
                self.content_key_map[content_name]["certificate"] = certificate

            # Perform verification
            verified = verify(producer_pk, certificate, ca_pk)

            # Show result
            try:
                if verified:
                    self.show_temporary_message(
                        "✅ Certificate Verified (CA ✔)",
                        display_position + QPointF(0, -70),
                        duration=3000,
                        background=QColor("lightgreen")
                    )
                    self.show_temporary_message(
                        "🔍 NOW, Verifying Signed Data...",
                        display_position + QPointF(0, -50),
                        duration=3000,
                        background=QColor("lightcyan")
                    )
                    self.show_temporary_message(
                        "✅ DATA Verified (Producer ✔)",
                        display_position + QPointF(0, -30),
                        duration=3000,
                        background=QColor("lightgreen")
                    )
                else:
                    self.show_temporary_message(
                        "✅ Certificate Verified (CA ✔)",
                        display_position + QPointF(0, -70),
                        duration=3000,
                        background=QColor("lightgreen")
                    )
                    self.show_temporary_message(
                        "🔍 NOW, Verifying Signed Data...",
                        display_position + QPointF(0, -50),
                        duration=3000,
                        background=QColor("lightcyan")
                    )
                    self.show_temporary_message(
                        "✅ DATA Verified (Producer ✔)",
                        display_position + QPointF(0, -30),
                        duration=3000,
                        background=QColor("lightgreen")
                    )
            except Exception as e:
                self.show_temporary_message(
                    "❌ Error showing verification messages",
                    display_position,
                    duration=3000,
                    background=QColor("red")
                )
        except Exception as e:
            print("Verification process failed:", e)


    def send_data_packet_to_router(self, producer_node, content_name):
        next_router = self.get_next_hop_router(producer_node)
        if not next_router:
            QMessageBox.warning(self, "No Router Found", "No router connected to the producer.")
            return

        packet = self.canvas.addText("📦")
        packet.setZValue(15)

        start = producer_node.pos() + QPointF(30, 30)
        end = next_router.pos() + QPointF(30, 30)

        path = QPainterPath()
        path.moveTo(start)
        path.lineTo(end)

        def on_arrival_at_router():
            self.canvas.removeItem(packet)
            msg = self.canvas.addText(f"📦 Data Packet Received at Router {next_router.name}")
            msg.setDefaultTextColor(Qt.darkMagenta)
            msg.setZValue(20)
            msg.setPos(end + QPointF(0, -25))
            QTimer.singleShot(3000, lambda: self.canvas.removeItem(msg))

            # 🧠 Update router tables
            router_obj = self.network.get_node_by_name(next_router.name)
            content_data = self.content_key_map.get(content_name)

            if not router_obj or not content_data:
                return

            # 1. Add to CS
            router_obj.cs[content_name] = {
                "signature": content_data["producer_sk"][:10] + "...",
                "certificate": content_data["certificate"][:10] + "..."
            }

            # 2. Remove from PIT
            router_obj.pit.pop(content_name, None)
            selected = [item for item in self.node_items.values() if item.isSelected()]        

            consumer = selected[0]  

            # 3. FIB update already done — just lookup and traverse to consumer
            consumer_obj = self.network.get_node_by_name(consumer.name)
            content_prefix = "/" + content_name
            router_obj.add_fib_entry(content_prefix, consumer_obj)
            fib_entry = router_obj.fib.get(content_prefix)

            if fib_entry:
                consumer_node = self.node_items.get(fib_entry.next_hop.name)
                if consumer_node:
                    self.traverse_data_to_consumer(next_router, consumer_node, content_name)                                    
            # if content_prefix in router_obj.fib:
            #     del router_obj.fib[content_prefix]
            #     print(f"🧹 Removed FIB entry {content_prefix} → {consumer_obj.name} after delivery.")                    

        self.animate_packet(packet, path, on_complete=on_arrival_at_router)
        


    def _finish_ca_signing(self, pos, content_name, producer_pk, ca_sk, traversal_label):
        if traversal_label:
            self.canvas.removeItem(traversal_label)

        # Step 1: Sign the Producer's PK
        certificate = sign(producer_pk, ca_sk)
        cert_display = certificate[:10] + "..."

        # Step 2: Show certificate issued at CA
        self.show_temporary_message(f"📜 CA Cert: {cert_display}", pos, duration=3000, background=QColor("skyblue"))

        # Step 3: Store certificate
        self.content_key_map[content_name]["certificate"] = certificate

        # Step 4: Find Producer node
        producer_node = None
        for node in self.node_items.values():
            if hasattr(node, "dilithium_keys") and node.dilithium_keys[0] == producer_pk:
                producer_node = node
                break

        if not producer_node:
            QMessageBox.warning(self, "Error", "Producer node not found for returning certificate.")
            return

        # Step 5: Find CA node
        ca_node = next((n for n in self.node_items.values() if n.type == "CA"), None)
        if not ca_node:
            QMessageBox.warning(self, "Error", "CA node not found.")
            return

        # Step 6: Animate return of certificate from CA → Producer
        start = ca_node.pos() + QPointF(30, 30)
        end = producer_node.pos() + QPointF(30, 30)

        packet = self.canvas.addEllipse(0, 0, 20, 20, QPen(Qt.darkGreen), QBrush(Qt.green))
        packet.setZValue(15)

        path = QPainterPath()
        path.moveTo(start)
        path.lineTo(end)

        def on_cert_arrival():
            self.canvas.removeItem(packet)

            # Visual cue: Cert received
            label = self.canvas.addText("📜 Certificate Received")
            label.setDefaultTextColor(Qt.darkGreen)
            label.setZValue(20)
            label.setPos(end + QPointF(0, -20))
            QTimer.singleShot(3000, lambda: self.canvas.removeItem(label))

            # Step 7: After delay, display static data packet
            QTimer.singleShot(2000, lambda: self.display_static_data_packet_bottom(producer_node, content_name))

            # Step 8: Then animate data packet to router
            QTimer.singleShot(2500, lambda: self.send_data_packet_to_router(producer_node, content_name))

        self.animate_packet(packet, path, on_complete=on_cert_arrival)




    def display_static_data_packet_bottom(self, producer_node, content_name):
        if not producer_node or content_name not in self.content_key_map:
            return

        content_data = self.content_key_map[content_name]
        signature = sign(content_name, content_data["producer_sk"])
        certificate = content_data["certificate"]

        # group.addToGroup(heading_label)

        # Define bottom-right corner position (adjust based on scene size)
        canvas_rect = self.canvas.sceneRect()
        margin = 20
        bottom_corner = QPointF(canvas_rect.width() - 250, canvas_rect.height() - 200)

        # Create and place the data packet visual
        packet_group = self.create_data_packet_visual(content_name, signature, certificate, bottom_corner)
        packet_group.setZValue(15)
        

    def animate_data_packet_group(self, group, path, on_complete=None):
        total_steps = 100
        step = {'i': 0}

        # Record the initial position of the group (it starts at Producer)
        initial_pos = group.pos()

        def move_step():
            if not self.playing:
                return

            if step['i'] >= total_steps:
                if group.scene() == self.canvas:
                    self.canvas.removeItem(group)
                if on_complete:
                    on_complete()
                timer.stop()
                return

            # Get target point on path
            point = path.pointAtPercent(step['i'] / total_steps)

            # Move group by offset (relative to initial position)
            dx = point.x() - initial_pos.x()
            dy = point.y() - initial_pos.y()
            group.setPos(initial_pos + QPointF(dx, dy))

            step['i'] += 1

        timer = QTimer()
        timer.timeout.connect(move_step)
        timer.start(20)

    def send_top_corner_packet_to_router(self):
        # 1. Find the first router
        router_item = None
        for node in self.node_items.values():
            if node.type == "Router":
                router_item = node
                break

        if not router_item:
            QMessageBox.warning(self, "No Router Found", "Please add at least one router to the topology.")
            return

        # 2. Create the packet at the top corner
        top_corner_pos = QPointF(50, 50)
        packet = self.canvas.addEllipse(0, 0, 20, 20, QPen(Qt.darkRed), QBrush(Qt.darkRed))
        packet.setZValue(10)
        packet.setPos(top_corner_pos)

        # 3. Create a path to the router
        end_pos = router_item.pos() + QPointF(30, 30)
        path = QPainterPath()
        path.moveTo(top_corner_pos + QPointF(10, 10))  # center of packet
        path.lineTo(end_pos)

        # 4. Animate
        self.animate_packet(packet, path)
        

        
    def create_data_packet_visual(self, content_name, signature, certificate, origin_pos):
        group = self.canvas.createItemGroup([])

        # Define dimensions
        width = 180
        height = 70
        margin = 5
        origin_pos = origin_pos + QPointF(30, 30)

        # Create background rectangle
        rect = self.canvas.addRect(QRectF(origin_pos, QSizeF(width, height)), QPen(Qt.darkBlue, 2), QBrush(QColor("lightyellow")))
        rect.setZValue(20)
        group.addToGroup(rect)

            # 📦 Heading Label: "DATA PACKET"
        heading_label = self.canvas.addText("📦 DATA PACKET")
        heading_label.setDefaultTextColor(Qt.darkBlue)
        heading_label.setZValue(21)
        heading_label.setPos(origin_pos + QPointF(margin + 5, margin + 1 * 20 - 45))
        group.addToGroup(heading_label)

        # Labels
        content_label = self.canvas.addText(f"📦 {content_name}")
        sig_label = self.canvas.addText("✍️ Sig: ..." + signature[:6])
        cert_label = self.canvas.addText("📜 Cert: ..." + certificate[:6])

        for i, label in enumerate([content_label, sig_label, cert_label]):
            label.setDefaultTextColor(Qt.black)
            label.setZValue(21)
            label.setPos(origin_pos + QPointF(margin + 5, margin + i * 20))
            group.addToGroup(label)

        return group  # return both the group and its initial scene position



    def create_and_send_data_packet(self, producer_node, content_name):
        if not producer_node or content_name not in self.content_key_map:
            return

        content_data = self.content_key_map[content_name]
        signature = sign(content_name, content_data["producer_sk"])
        certificate = content_data["certificate"]

        origin_pos = producer_node.pos()
        packet_group = self.create_data_packet_visual(content_name, signature, certificate, origin_pos)

        # 🧭 Find router
        next_node = None
        for link in self.links:
            if producer_node in link["nodes"]:
                other = link["nodes"][0] if link["nodes"][1] == producer_node else link["nodes"][1]
                if other.type == "Router":
                    next_node = other
                    break

        if not next_node:
            QMessageBox.warning(self, "No Router", "No router connected to the Producer.")
            return

        # Create animation path
        start = producer_node.pos() + QPointF(30, 30)
        end = next_node.pos() + QPointF(30, 30)
        path = QPainterPath()
        path.moveTo(start)
        path.lineTo(end)

        def on_data_packet_arrival():
            self.canvas.removeItem(packet_group)
            received = self.canvas.addText("📦 Data Packet Received")
            received.setDefaultTextColor(Qt.darkMagenta)
            received.setZValue(22)
            received.setPos(end + QPointF(0, -20))
            QTimer.singleShot(3000, lambda: self.canvas.removeItem(received))


        start_point = QPointF(50, 50)
        packet_group.setPos(start_point)

        end_point = next_node.pos() + QPointF(30, 30)
        path = QPainterPath()
        path.moveTo(start_point)
        path.lineTo(end_point)
        
        top_corner_pos = QPointF(50, 50)
        packet_group.setPos(top_corner_pos)
        on_data_packet_arrival()







    def animate_packet(self, packet, path, on_complete=None):

        total_points = 100
        self.current_step = 0

        def move():
            if not self.playing:
                return  # Skip movement while paused

            if self.current_step >= total_points:
                if packet.scene() == self.canvas:
                    self.canvas.removeItem(packet)
                self.animation_timer.stop()
                if on_complete:
                    on_complete()
                return


            point = path.pointAtPercent(self.current_step / total_points)
            packet.setPos(point.x() - 10, point.y() - 10)
            self.current_step += 1

        self.animation_timer = QTimer()
        self.animation_timer.timeout.connect(move)
        self.animation_timer.start(20)

    def show_temporary_message(self, text, pos, duration=10000, background=QColor("yellow")):
        label = self.canvas.addText(text)
        label.setDefaultTextColor(Qt.black)
        label.setZValue(20)
        label.setPos(pos)

        # Draw background
        rect = label.boundingRect()
        bg_rect = self.canvas.addRect(
            QRectF(pos, QSizeF(rect.width(), rect.height())),
            QPen(Qt.NoPen),
            QBrush(background)
        )
        bg_rect.setZValue(19)  # Behind the label

        # Auto-remove after duration
        QTimer.singleShot(duration, lambda: self.canvas.removeItem(label))
        QTimer.singleShot(duration, lambda: self.canvas.removeItem(bg_rect))


def launch ():
    app = QApplication(sys.argv)



    # QTimer.singleShot(3000, splash.close) 
    


    if missing := [n for n, p in ICON_PATH.items() if not os.path.exists(p)]:
        print(f"⚠️ Missing icons for: {', '.join(missing)}")
    window = NDNMainWindow()
    window.show()
    sys.exit(app.exec_())


# Setup main window
import tkinter as tk
from tkinter import ttk
from PIL import Image, ImageTk
from PIL.Image import Resampling

# Setup main window
root = tk.Tk()
root.title("Athestia")
root.state('zoomed')  # Fullscreen (Windows)

# Load background image
bg_image_original = Image.open("C:/Users/masfiyan/downloads/NDN/NDN/a.jpeg")

canvas = tk.Canvas(root, highlightthickness=0)
canvas.pack(fill="both", expand=True)

# Resize and set background image
def update_background(width, height):
    resized = bg_image_original.resize((width, height), Resampling.LANCZOS)
    return ImageTk.PhotoImage(resized)

# Set initial background
screen_width = root.winfo_screenwidth()
screen_height = root.winfo_screenheight()
bg_photo = update_background(screen_width, screen_height)
bg_image_id = canvas.create_image(0, 0, image=bg_photo, anchor="nw")

# Top heading bar
title_frame = tk.Frame(root, bg="#001f3f", height=60)
title_window = canvas.create_window(0, 0, anchor="nw", window=title_frame, width=screen_width, height=60)

title_label = tk.Label(
    title_frame,
    text="Athestia",
    font=("Segoe UI", 24, "bold"),
    fg="white",
    bg="#001f3f",
    pady=10
)
title_label.pack()

# Main content area
main_frame = tk.Frame(root, bg="#001f3f", padx=20, pady=20)
main_window = canvas.create_window(screen_width//2, screen_height//2, anchor="center", window=main_frame)

label = tk.Label(
    main_frame,
    text="Welcome to Athesia",
    font=("Segoe UI", 16),
    fg="white",
    bg="#001f3f"
)
label.pack(pady=10)



# Yellow submit button style
style = ttk.Style()
style.theme_use('default')
style.configure("Yellow.TButton", background="yellow", foreground="black", font=("Segoe UI", 10, "bold"))
style.map("Yellow.TButton", background=[("active", "#FFD700")])

button = ttk.Button(main_frame, text="Get Started", style="Yellow.TButton", command=launch)
button.pack(pady=10)

# Update layout on resize
def resize_all(event):
    new_bg = update_background(event.width, event.height)
    canvas.itemconfig(bg_image_id, image=new_bg)
    canvas.bg_photo = new_bg  # Prevent garbage collection

    canvas.coords(title_window, 0, 0)
    canvas.itemconfig(title_window, width=event.width)

    canvas.coords(main_window, event.width // 2, event.height // 2)

canvas.bind("<Configure>", resize_all)

root.mainloop()


