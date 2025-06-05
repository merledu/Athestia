import sys, os, pickle, time
from PyQt5.QtWidgets import (
    QApplication, QMainWindow, QWidget, QVBoxLayout, QHBoxLayout, QLabel,
    QPushButton, QScrollArea, QMessageBox, QInputDialog, QLineEdit, QFrame, QMenu,
    QTableWidget, QTableWidgetItem, QDialog, QHeaderView, QGroupBox, QTextEdit, 
    QTabBar, QFileDialog
)
from PyQt5.QtGui import QPixmap, QPainter, QPen, QFont, QColor, QIcon
from PyQt5.QtCore import Qt, QPoint, QRect, pyqtSignal, QTimer, QEventLoop, QSize
import shutil
from modules.producers_data import get_producer_subcategories
from modules.interest_packet import InterestPacket, generate_packet_id
from Dilithium import *
# Add to main.py imports
from modules.router_tables import RouterTable, build_topology_graph, bfs_shortest_path
from modules.data_packet_generation import handle_interest_packet_reach_producer
from modules.data_packet_generation import DataPacketIcon
from modules.consumer_verification import verify_signatures
from modules.data_retrieval import retrieve_data_from_router
from modules.state_inspector import StateInspectorDialog
from modules.message_manager import MessageManager
from modules.vivado_interface import VivadoInterface
from PyQt5.QtGui import QPalette, QColor


COMPONENT_SIZE = 64
MAX_CA = 3
MAX_PRODUCER = 10
MAX_CONSUMER = 10
MAX_ROUTER = 10
MAX_NDN_REPO = 1

PRODUCER_CATEGORIES = [
    "YouTube", "Spotify", "Medium", "Kindle", "Steam",
    "Gmail", "Reddit", "coursera", "canva", "Instagram"
]
PRODUCER_TO_CA = {
    "YouTube": "video-ca",
    "Spotify": "song-ca",
    "Medium": "article-ca",
    "Kindle": "book-ca",
    "Steam": "game-ca",
    "Gmail": "email-ca",
    "Reddit": "community threads-ca",
    "coursera": "courses-ca",
    "canva": "design-ca",
    "Instagram": "reel-ca"
}
CA_CATEGORIES = list(set(PRODUCER_TO_CA.values()))

def sleep_with_events(ms):
    loop = QEventLoop()
    QTimer.singleShot(ms, loop.quit)
    loop.exec_()

class KeyDetailsDialog(QDialog):
    def __init__(self, title, data, parent=None):
        """
        Create a dialog to display cryptographic keys and signatures with proper formatting.
        
        Args:
            title: Dialog title
            data: Dictionary containing keys, signatures, etc.
            parent: Parent widget
        """
        super().__init__(parent)
        self.setWindowTitle(title)
        self.setMinimumWidth(600)
        self.setMinimumHeight(400)
        
        # Main layout
        layout = QVBoxLayout(self)
        
        # Add icon and info at the top
        top_layout = QHBoxLayout()
        icon_label = QLabel()
        # base_path = os.path.dirname(os.path.abspath(__file__))
        # image_path_key = os.path.join(base_path, 'assets/key.png')

        base_path = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
        image_path_key = os.path.join(base_path, 'assets', 'key.png')

        icon_label.setPixmap(QPixmap(image_path_key).scaled(48, 48, Qt.KeepAspectRatio))
        top_layout.addWidget(icon_label)
        
        info_label = QLabel("Click on any key or signature to view its full content")
        info_label.setStyleSheet("font-style: italic; color: #666;")
        top_layout.addWidget(info_label, 1)
        layout.addLayout(top_layout)
        
        # Create a scroll area for the content
        scroll = QScrollArea()
        scroll.setWidgetResizable(True)
        scroll.setFrameShape(QFrame.NoFrame)
        content_widget = QWidget()
        content_layout = QVBoxLayout(content_widget)
        
        # Add each key/signature with a clickable label
        for key, value in data.items():
            if value:  # Only add if there's content
                # Create a group for each key/signature
                group = QGroupBox(key)
                group_layout = QVBoxLayout(group)
                
                # For values that are dictionaries (like signatures)
                if isinstance(value, dict):
                    for sub_key, sub_value in value.items():
                        if sub_key != 'pk_id' and sub_key != 'sk_id':  # Skip IDs
                            # Use friendly label names for signature keys
                            display_name = self.get_friendly_label_name(sub_key)
                            self.add_key_field(group_layout, display_name, sub_value)
                # For direct string values
                else:
                    # Create a clickable label with truncated text
                    truncated = value[:40] + "..." if len(value) > 40 else value
                    key_label = QLabel(truncated)
                    key_label.setTextInteractionFlags(Qt.TextSelectableByMouse)
                    key_label.setStyleSheet("background-color: #f0f0f0; padding: 5px; border-radius: 3px;")
                    key_label.setCursor(Qt.PointingHandCursor)
                    key_label.setToolTip("Click to view full content")
                    
                    # Store the full value as a property
                    key_label.setProperty("full_text", value)
                    
                    # Connect click event
                    key_label.mousePressEvent = lambda event, label=key_label: self.show_full_text(label)
                    
                    group_layout.addWidget(key_label)
                
                content_layout.addWidget(group)
        
        # Add a spacer at the bottom
        content_layout.addStretch()
        
        # Set the content widget to the scroll area
        scroll.setWidget(content_widget)
        layout.addWidget(scroll)
        
        # Add OK button at the bottom
        buttons = QHBoxLayout()
        buttons.addStretch()
        ok_button = QPushButton("OK")
        ok_button.setIcon(QIcon.fromTheme("dialog-ok"))
        ok_button.clicked.connect(self.accept)
        buttons.addWidget(ok_button)
        layout.addLayout(buttons)
    
    def get_friendly_label_name(self, key):
        """Convert dictionary keys to user-friendly display names."""
        if key == 'signature':
            return "Public Key"  # "Signature for Public Key" will be displayed
        elif key == 'sig_id':
            return "Signature ID"
        return key
    
    def add_key_field(self, layout, name, value):
        """Add a field with a name and clickable value."""
        if not value:
            return
            
        field_layout = QVBoxLayout()
        
        # Add field name
        name_label = QLabel(name + ":")
        name_label.setStyleSheet("font-weight: bold;")
        field_layout.addWidget(name_label)
        
        # Add truncated value as clickable
        truncated = value[:40] + "..." if len(value) > 40 else value
        value_label = QLabel(truncated)
        value_label.setTextInteractionFlags(Qt.TextSelectableByMouse)
        value_label.setStyleSheet("background-color: #f0f0f0; padding: 5px; border-radius: 3px;")
        value_label.setCursor(Qt.PointingHandCursor)
        value_label.setToolTip("Click to view full content")
        
        # Store the full value as a property
        value_label.setProperty("full_text", value)
        
        # Connect click event
        value_label.mousePressEvent = lambda event, label=value_label: self.show_full_text(label)
        
        field_layout.addWidget(value_label)
        layout.addLayout(field_layout)
    
    def show_full_text(self, label):
        """Show the full text of a key or signature in a dialog."""
        full_text = label.property("full_text")
        if not full_text:
            return
            
        dialog = QDialog(self)
        dialog.setWindowTitle("Full Content")
        dialog.setMinimumWidth(700)
        dialog.setMinimumHeight(300)
        
        layout = QVBoxLayout(dialog)
        
        # Add a text edit with the full content
        text_edit = QTextEdit()
        text_edit.setPlainText(full_text)
        text_edit.setReadOnly(True)
        layout.addWidget(text_edit)
        
        # Add buttons
        buttons = QHBoxLayout()
        copy_button = QPushButton("Copy to Clipboard")
        copy_button.clicked.connect(lambda: QApplication.clipboard().setText(full_text))
        close_button = QPushButton("Close")
        close_button.clicked.connect(dialog.accept)
        
        buttons.addWidget(copy_button)
        buttons.addStretch()
        buttons.addWidget(close_button)
        layout.addLayout(buttons)
        
        dialog.exec_()


def prepare_ca_data(ca):
    """Prepare CA data for display in the KeyDetailsDialog."""
    data = {}

    # Add keys if available
    keys = getattr(ca, "ca_keys", None)
    if keys:
        if 'pk' in keys:
            data["Public Key"] = keys['pk']
        if 'sk' in keys:
            data["Private Key"] = keys['sk']

    # Add signatures if available
    sig = getattr(ca, "signature", None)
    if sig:
        signatures = {}

        if ca.name == "root-ca" and isinstance(sig, dict):
            # Root CA storing multiple signatures
            for sub_ca, s in sig.items():
                if isinstance(s, dict):
                    if 'signature' in s:
                        signatures[f"Signature for {sub_ca} Public Key"] = s['signature']
                    if 'sig_id' in s:
                        signatures[f"Signature ID for {sub_ca}"] = s['sig_id']
                elif isinstance(s, str):
                    signatures[f"Signature for {sub_ca} Public Key"] = s
        elif isinstance(sig, dict):
            # Subordinate CA with single signature
            if 'signature' in sig:
                signatures["Signature for Public Key"] = sig['signature']
            if 'sig_id' in sig:
                signatures["Signature ID"] = sig['sig_id']
        elif isinstance(sig, str):
            signatures["Signature for Public Key"] = sig

        if signatures:
            data["Signatures"] = signatures

    # Add producer certificates signed by this CA (NEW PART)
    prod_certs = getattr(ca, "producer_certificates", None)
    if prod_certs:
        for prod_name, cert in prod_certs.items():
            # Prepare readable dict
            cert_data = {}
            if "signature" in cert:
                cert_data["Signature for Producer PK"] = cert["signature"]
            if "sig_id" in cert:
                cert_data["Signature ID"] = cert["sig_id"]
            if "cert_name" in cert:
                cert_data["Certificate Name"] = cert["cert_name"]
            if cert_data:
                data[f"Producer Certificate: {prod_name}"] = cert_data

    return data

def prepare_producer_data(producer):
    data = {}

    # Add keys
    keys = getattr(producer, "ca_keys", None)
    if keys:
        if 'pk' in keys:
            data["Public Key"] = keys['pk']
        if 'sk' in keys:
            data["Private Key"] = keys['sk']

    # Add certificate (signed PK by CA)
    cert = getattr(producer, "producer_certificate", None)
    if cert:
        cert_data = {}
        if "signature" in cert:
            cert_data["Signature"] = cert["signature"]
        if "sig_id" in cert:
            cert_data["Signature ID"] = cert["sig_id"]
        if "cert_name" in cert:
            cert_data["Certificate Name"] = cert["cert_name"]
        if cert_data:
            data["Certificate given by CA"] = cert_data

    # Add data signatures
    data_sigs = getattr(producer, "data_signatures", [])
    for i, sig_rec in enumerate(data_sigs, 1):
        sig_key = f"Data Signature {i}"
        sig_id_key = f"Data Signature ID {i}"
        if "signature" in sig_rec:
            data[sig_key] = sig_rec["signature"]
        if "sig_id" in sig_rec:
            data[sig_id_key] = str(sig_rec["sig_id"])

    return data



def prepare_consumer_data(consumer):
    """Prepare Consumer data for display in the KeyDetailsDialog."""
    data = {}
    
    # Add installed public key if available
    pk = getattr(consumer, "installed_pk", None)
    if pk:
        data["Installed Public Key"] = pk
    
    # Add fetched certificates
    certs = getattr(consumer, "fetched_certificates", [])
    for i, cert_packet in enumerate(certs, 1):
        cert_data = cert_packet["data"]
        cert_info = {}
        if "name" in cert_data:
            cert_info["Certificate Name"] = cert_data["name"]
        if "pk" in cert_data:
            cert_info["Public Key"] = cert_data["pk"]
        if "signature" in cert_data:
            cert_info["Signature"] = cert_data["signature"]
        data[f"Fetched Certificate {i}"] = cert_info
    
    # Add verification results
    results = getattr(consumer, "verification_results", [])
    for i, result in enumerate(results, 1):
        data[f"Verification Result {i}"] = {
            "Step": result["step"],
            "Result": str(result["result"]),
            "Message": result["message"]
        }
    
    return data

class Component(QWidget):
    def __init__(self, name, component_type, image_path, parent=None):
        super().__init__(parent)
        self.name = name
        self.component_type = component_type
        self.image_path = image_path
        self.connected_components = []
        self.links = []
        self.setFixedSize(COMPONENT_SIZE, COMPONENT_SIZE + 48)  # was +40
        self.pixmap = QPixmap(image_path).scaled(COMPONENT_SIZE, COMPONENT_SIZE, Qt.KeepAspectRatio)
        self.dragging = False
        self.offset = QPoint()
        self.setCursor(Qt.OpenHandCursor)

        self.name_label = QLabel(self)
        self.name_label.setText(self.name)
        self.name_label.setAlignment(Qt.AlignCenter)
        self.name_label.setFont(QFont("Arial", 10, QFont.Bold))
        self.name_label.setWordWrap(True)
        self.name_label.setGeometry(0, COMPONENT_SIZE, COMPONENT_SIZE, 28)
        self.name_label.setStyleSheet("background: white; color: #222; border-radius: 3px;")

        self.message_label = QLabel(self)
        self.message_label.setGeometry(0, COMPONENT_SIZE + 20, COMPONENT_SIZE, 20)
        self.message_label.setAlignment(Qt.AlignCenter)
        self.message_label.setFont(QFont("Arial", 8))
        self.message_label.setStyleSheet("background: white; color: green; border-radius: 3px;")
        self.message_label.setWordWrap(True)       
        self.message_label.hide()
        self.message_manager = MessageManager(self)
        self.setAttribute(Qt.WA_TransparentForMouseEvents, False)
        self.interest_packets = []
        self.router_table = RouterTable(name) if component_type == "Router" else None
        self.last_interest_from = None  # Added to track the source of interest packets
        self.data_packet_icons = []  # Added to store data packet icons near consumers

    def paintEvent(self, event):
        painter = QPainter(self)
        painter.drawPixmap(0, 0, self.pixmap)

    def resizeEvent(self, event):
        self.name_label.setGeometry(0, COMPONENT_SIZE, COMPONENT_SIZE, 24)
        self.message_label.setGeometry(0, COMPONENT_SIZE + 24, COMPONENT_SIZE, 24)
        super().resizeEvent(event)

    def mousePressEvent(self, event):
        if event.button() == Qt.LeftButton:
            self.dragging = True
            self.offset = event.pos()
            self.setCursor(Qt.ClosedHandCursor)
        super().mousePressEvent(event)

    def mouseMoveEvent(self, event):
        if self.dragging and event.buttons() & Qt.LeftButton:
            canvas = self.parent()
            new_pos = self.mapToParent(event.pos() - self.offset)
            new_pos.setX(max(0, min(new_pos.x(), canvas.width() - self.width())))
            new_pos.setY(max(0, min(new_pos.y(), canvas.height() - self.height())))
            delta = new_pos - self.pos()
            self.move_with_links(delta)
        super().mouseMoveEvent(event)

    def mouseReleaseEvent(self, event):
        self.dragging = False
        self.setCursor(Qt.OpenHandCursor)
        super().mouseReleaseEvent(event)

    def move_with_links(self, delta):
        self.move(self.pos() + delta)
        for link in self.links:
            link.update_position()
        
        # Add this block to update interest packet positions
        if self.component_type == "Consumer" and hasattr(self, "interest_packets"):
            for packet in self.interest_packets:
                # Move packet to maintain relative position to consumer
                packet.move(packet.pos() + delta)

        # Move data packet icons with consumer or producer
        if hasattr(self, "data_packet_icons"):
            for dp_icon in self.data_packet_icons:
                dp_icon.update_position()
                
    def contextMenuEvent(self, event):
        menu = QMenu(self)
        delete_action = menu.addAction("Delete")
        action = menu.exec_(self.mapToGlobal(event.pos()))
        if action == delete_action:
            self.parent().delete_component(self)

class Link(QWidget):
    def __init__(self, component1, component2, parent=None):
        super().__init__(parent)
        self.component1 = component1
        self.component2 = component2
        self.component1.links.append(self)
        self.component2.links.append(self)
        self.component1.connected_components.append(component2)
        self.component2.connected_components.append(component1)
        self.setAttribute(Qt.WA_TransparentForMouseEvents, False)  # Accept mouse events
        self.setGeometry(0, 0, parent.width(), parent.height())
        self.raise_()
        self.update_position()
        self.lower()

    def update_position(self):
        self.repaint()

    def paintEvent(self, event):
        painter = QPainter(self)
        pen = QPen(Qt.black, 2)
        pen.setStyle(Qt.CustomDashLine)           # Use custom dash style
        pen.setDashPattern([4, 4])                # 6 pixels dash, 6 pixels gap
        painter.setPen(pen)
        p1 = self.component1.pos() + QPoint(self.component1.width() // 2, self.component1.height() // 2)
        p2 = self.component2.pos() + QPoint(self.component2.width() // 2, self.component2.height() // 2)
        painter.drawLine(p1, p2)

class ComponentPanel(QScrollArea):
    component_clicked = pyqtSignal(str, str)
    link_mode_clicked = pyqtSignal()
    topology_done_clicked = pyqtSignal()
    play_pause_clicked = pyqtSignal(bool)

    def __init__(self, parent=None):
        super().__init__(parent)
        self.setWidgetResizable(True)
        self.setFixedWidth(180)
        content = QWidget()
        self.layout = QVBoxLayout(content)
        self.layout.setAlignment(Qt.AlignTop)
        title = QLabel("Components")
        title.setAlignment(Qt.AlignCenter)
        font = QFont()
        font.setBold(True)
        font.setPointSize(11)
        title.setFont(font)
        self.layout.addWidget(title)
        line = QFrame()
        line.setFrameShape(QFrame.HLine)
        line.setFrameShadow(QFrame.Sunken)
        self.layout.addWidget(line)
        base_path = os.path.dirname(os.path.abspath(__file__))
        image_path_ca = os.path.join(base_path, 'assets/ca.jpeg')
        image_path_pro = os.path.join(base_path, 'assets/producer.jpeg')
        image_path_con = os.path.join(base_path, 'assets/consumer.jpeg')
        image_path_rou = os.path.join(base_path, 'assets/router.jpeg')
        image_path_li = os.path.join(base_path, 'assets/link.png')
        image_path_ndn = os.path.join(base_path, 'assets/ndn_repo.png')
        self.add_component_button("CA", image_path_ca)
        self.add_component_button("Producer", image_path_pro)
        self.add_component_button("Consumer", image_path_con)
        self.add_component_button("Router", image_path_rou)
        self.add_component_button("Link", image_path_li)
        self.add_component_button("NDN Repo", image_path_ndn)
        # Add Modes heading
        modes_title = QLabel("Modes")
        modes_title.setAlignment(Qt.AlignCenter)
        modes_title_font = QFont()
        modes_title_font.setBold(True)
        modes_title_font.setPointSize(11)
        modes_title.setFont(modes_title_font)
        self.layout.addWidget(modes_title)
        modes_line = QFrame()
        modes_line.setFrameShape(QFrame.HLine)
        modes_line.setFrameShadow(QFrame.Sunken)
        self.layout.addWidget(modes_line)

        # Add Simulation and Emulation buttons
        self.simulation_btn = QPushButton("Simulation")
        self.simulation_btn.setCheckable(True)
        self.simulation_btn.clicked.connect(self.set_simulation_mode)
        self.simulation_btn.setStyleSheet("""
            QPushButton {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1, stop:0 #deadd2, stop:1 #c5dee5);
                color: black;
                border: 1px solid #2e6da4;
                border-radius: 5px;
                padding: 5px;
            }
            QPushButton:hover {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1, stop:0 #deadd2, stop:1 #c5dee5);
            }
            QPushButton:pressed {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1, stop:0 #deadd2, stop:1 #c5dee5);
            }
            QPushButton:disabled {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1, stop:0 #deadd2, stop:1 #c5dee5);
                color: #666;
            }
        """)
        self.layout.addWidget(self.simulation_btn)
        
        self.emulation_btn = QPushButton("Emulation")
        self.emulation_btn.setCheckable(True)
        self.emulation_btn.clicked.connect(self.set_emulation_mode)
        self.emulation_btn.setStyleSheet("""
            QPushButton {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1, stop:0 #deadd2, stop:1 #c5dee5);
                color: black;
                border: 1px solid #a42e2e;
                border-radius: 5px;
                padding: 5px;
            }
            QPushButton:hover {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1, stop:0 #deadd2, stop:1 #c5dee5);
            }
            QPushButton:pressed {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1, stop:0 #deadd2, stop:1 #c5dee5);
            }
            QPushButton:disabled {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1, stop:0 #deadd2, stop:1 #c5dee5);
                color: #666;
            }
        """)
        self.layout.addWidget(self.emulation_btn)
        
        self.mode = "simulation"  # Default mode
        self.emulation_btn.setEnabled(True)  # Temporarily enable for testing
        self.emulation_btn.setToolTip("Run Dilithium algorithms using Vivado (SystemVerilog).")
        self.layout.addSpacing(20)
        self.link_btn = QPushButton("Link Mode")
        self.link_btn.setCheckable(True)
        self.link_btn.clicked.connect(self.link_mode_clicked)
        self.link_btn.setStyleSheet("""
            QPushButton {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1, stop:0 #deadd2, stop:1 #c5dee5);
                color: black;
                border: 1px solid #2ea42e;
                border-radius: 5px;
                padding: 5px;
            }
            QPushButton:hover {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1, stop:0 #deadd2, stop:1 #c5dee5);
            }
            QPushButton:pressed {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1, stop:0 #deadd2, stop:1 #c5dee5);
            }
        """)
        self.layout.addWidget(self.link_btn)
        self.topology_btn = QPushButton("Topology Completed")
        self.topology_btn.clicked.connect(self.topology_done_clicked)
        self.topology_btn.setStyleSheet("""
            QPushButton {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1, stop:0 #deadd2, stop:1 #c5dee5);
                color: black;
                border: 1px solid #cc7a00;
                border-radius: 5px;
                padding: 5px;
            }
            QPushButton:hover {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1, stop:0 #deadd2, stop:1 #c5dee5);
            }
            QPushButton:pressed {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1, stop:0 #deadd2, stop:1 #c5dee5);
            }
        """)
        self.layout.addWidget(self.topology_btn)
        self.play_pause_btn = QPushButton("Play")
        self.play_pause_btn.setCheckable(True)
        self.play_pause_btn.clicked.connect(self.on_play_pause)
        self.play_pause_btn.setStyleSheet("""
            QPushButton {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1, stop:0 #deadd2, stop:1 #c5dee5);
                color: black;
                border: 1px solid #2e6d6d;
                border-radius: 5px;
                padding: 5px;
            }
            QPushButton:hover {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1, stop:0 #deadd2, stop:1 #c5dee5);
            }
            QPushButton:pressed {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1, stop:0 #deadd2, stop:1 #c5dee5);
            }
        """)
        self.layout.addWidget(self.play_pause_btn)
        self.is_paused = False
        self.setWidget(content)
        # Add new "Request Content" button
        self.request_btn = QPushButton("Request Content")
        self.request_btn.setEnabled(False)  # Initially disable the button
        self.request_btn.setToolTip("Complete the topology setup to enable this button.")
        self.request_btn.clicked.connect(self.handle_request_content)
        self.request_btn.setStyleSheet("""
            QPushButton {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1, stop:0 #deadd2, stop:1 #c5dee5);
                color: black;
                border: 1px solid #a42e6d;
                border-radius: 5px;
                padding: 5px;
            }
            QPushButton:hover {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1, stop:0 #deadd2, stop:1 #c5dee5);
            }
            QPushButton:pressed {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1, stop:0 #deadd2, stop:1 #c5dee5);
            }
            QPushButton:disabled {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1, stop:0 #deadd2, stop:1 #c5dee5);
                color: #666;
            }
        """)
        self.layout.addWidget(self.request_btn)

    def check_vivado_availability(self):
        """Check if Vivado is available and enable/disable Emulation button."""
        vivado = VivadoInterface()
        if vivado.is_vivado_available():
            self.emulation_btn.setEnabled(True)
            self.emulation_btn.setToolTip("Run Dilithium algorithms using Vivado (SystemVerilog).")
        else:
            self.emulation_btn.setToolTip("Vivado not found. Emulation mode is disabled.")

    def set_simulation_mode(self):
        """Set Simulation mode, update button states, and initialize topology."""
        if self.simulation_btn.isChecked():
            self.mode = "simulation"
            self.emulation_btn.setChecked(False)
            self.simulation_btn.setEnabled(False)
            self.emulation_btn.setEnabled(VivadoInterface().is_vivado_available())
            # Sync mode with NDNDilithiumApp
            parent = self.parent()
            while parent and not hasattr(parent, 'mode'):
                parent = parent.parent()
            if parent:
                parent.mode = "simulation"
                # Initialize topology if completed
                canvas = parent.canvas
                if hasattr(canvas, 'topology_completed') and canvas.topology_completed:
                    canvas.initialize_topology()
        else:
            self.mode = None
            self.simulation_btn.setEnabled(True)
            self.emulation_btn.setEnabled(VivadoInterface().is_vivado_available())

    def set_emulation_mode(self):
        """Set Emulation mode, update button states, and initialize topology."""
        vivado = VivadoInterface()
        if not vivado.is_vivado_available():
            QMessageBox.warning(self, "Emulation Error", "No Vivado/FPGA setup found. Cannot run Emulation mode.")
            self.emulation_btn.setChecked(False)
            return
        if self.emulation_btn.isChecked():
            self.mode = "emulation"
            self.simulation_btn.setChecked(False)
            self.emulation_btn.setEnabled(False)
            self.simulation_btn.setEnabled(True)
            # Sync mode with NDNDilithiumApp
            parent = self.parent()
            while parent and not hasattr(parent, 'mode'):
                parent = parent.parent()
            if parent:
                parent.mode = "emulation"
                # Initialize topology if completed
                canvas = parent.canvas
                if hasattr(canvas, 'topology_completed') and canvas.topology_completed:
                    canvas.initialize_topology()
        else:
            self.mode = None
            self.emulation_btn.setEnabled(True)
            self.simulation_btn.setEnabled(True)

    def add_component_button(self, component_type, image_path):
        widget = QWidget()
        layout = QVBoxLayout(widget)
        label = QLabel()
        pixmap = QPixmap(image_path).scaled(40, 40, Qt.KeepAspectRatio)
        label.setPixmap(pixmap)
        label.setAlignment(Qt.AlignCenter)
        layout.addWidget(label)
        text = QLabel(component_type)
        text.setAlignment(Qt.AlignCenter)
        layout.addWidget(text)
        widget.mousePressEvent = lambda event: self.component_clicked.emit(component_type, image_path)
        widget.setCursor(Qt.PointingHandCursor)
        self.layout.addWidget(widget)
        self.layout.addSpacing(7)

    def on_play_pause(self):
        self.is_paused = not self.is_paused
        self.play_pause_btn.setText("Pause" if not self.is_paused else "Play")
        parent = self.parent()
        while parent and not hasattr(parent, "canvas"):
            parent = parent.parent()
        if parent and hasattr(parent, "canvas"):
            parent.canvas.set_paused(self.is_paused)
            # if self.is_paused:
            #     self.show_saved_states()

    def handle_request_content(self):
        print("[DEBUG] handle_request_content CALLED")

        parent = self.parent()
        while parent is not None and not hasattr(parent, "canvas"):
            parent = parent.parent()
        if parent is None:
            QMessageBox.warning(self, "Error", "Cannot find canvas widget.")
            return
        canvas = parent.canvas

        # 1. Select consumer
        consumers = [c.name for c in canvas.components if c.component_type == "Consumer"]
        if not consumers:
            QMessageBox.warning(self, "No Consumers", "Add consumers to topology first")
            return

        consumer_name, ok = QInputDialog.getItem(
            self, "Select Consumer", "Choose consumer:", consumers, 0, False)
        if not ok:
            return

        consumer = next(c for c in canvas.components if c.name == consumer_name)

        # 2. Select producer category
        available_producers = [c.name for c in canvas.components if c.component_type == "Producer"]
        if not available_producers:
            QMessageBox.warning(self, "No Producers", "Add producers to topology first")
            return

        producer_name, ok = QInputDialog.getItem(
            self, "Select Producer", "Choose producer:", available_producers, 0, False)
        if not ok:
            return

        # 3. Select subcategory
        subcategories = get_producer_subcategories(producer_name)
        subcat, ok = QInputDialog.getItem(
            self, "Select Content", "Choose content:", subcategories, 0, False)
        if not ok:
            return

        # 4. Create interest packet for selected consumer
        canvas.create_interest_packet(subcat, consumer)

    def show_saved_states(self):
        parent = self.parent()
        while parent and not hasattr(parent, "canvas"):
            parent = parent.parent()
        if parent and hasattr(parent, "canvas"):
            dialog = StateInspectorDialog(parent.canvas, self)
            dialog.exec_()

    def enable_request_button(self):
        """Enable the Request Content button after topology setup is complete."""
        self.request_btn.setEnabled(True)
        self.request_btn.setToolTip("Request content from a consumer.")

class TopologyCanvas(QWidget):
    topology_setup_finished = pyqtSignal()

    def __init__(self, parent=None):
        super().__init__(parent)
        self.setAcceptDrops(True)
        self.components = []
        self.links = []
        self.link_mode = False
        self.link_start_component = None
        self.ca_count = 0
        self.producer_count = 0
        self.consumer_count = 0
        self.router_count = 0
        self.ndn_repo_count = 0
        self.root_ca = None
        self.ca_names = set()
        self.producer_names = set()
        self.setStyleSheet("background: white;")
        self.anim_timer = QTimer()
        self.anim_timer.timeout.connect(self.animate_step)
        self.anim_icons = []
        self.paused = False
        self.ndn_repo_certs = []
        self.interest_packets = []
        self.interest_packet_counter = 1
        self.data_packets = []
        self.PRODUCER_TO_CA = PRODUCER_TO_CA
        # Add flag to track topology setup completion
        self.topology_setup_complete = False
        self.topology_completed = False

    def initialize_topology(self):
        # Clear all existing interest and data packets
        for comp in self.components:
            if comp.component_type == "Consumer":
                if hasattr(comp, "interest_packets"):
                    for packet in list(comp.interest_packets):
                        if packet in self.interest_packets:
                            self.interest_packets.remove(packet)
                            packet.hide()
                            packet.deleteLater()
                    comp.interest_packets.clear()
                if hasattr(comp, "data_packet_icons"):
                    for dp_icon in list(comp.data_packet_icons):
                        if dp_icon in self.data_packets:
                            self.data_packets.remove(dp_icon)
                            dp_icon.hide()
                            dp_icon.deleteLater()
                    comp.data_packet_icons.clear()
                # Clear consumer data
                for attr in ["fetched_certificates", "verification_results", "installed_pk"]:
                    if hasattr(comp, attr):
                        setattr(comp, attr, None)
            elif comp.component_type == "Producer":
                if hasattr(comp, "data_packet_icons"):
                    for dp_icon in list(comp.data_packet_icons):
                        if dp_icon in self.data_packets:
                            self.data_packets.remove(dp_icon)
                            dp_icon.hide()
                            dp_icon.deleteLater()
                    comp.data_packet_icons.clear()
                # Clear producer data
                for attr in ["ca_keys", "producer_certificate", "data_signatures", "last_interest_from"]:
                    if hasattr(comp, attr):
                        setattr(comp, attr, None)

        # Clear saved folders
        for folder in ["saved/ca_keys", "saved/ca_certs", "saved/consumer_keys", "saved/producer_keys", "saved/producer_certs", "saved/producer_data_sigs", "saved/consumer_verification", "saved/router_cs"]:
            if os.path.exists(folder):
                shutil.rmtree(folder)
            os.makedirs(folder, exist_ok=True)

        # 2. Keygen, signing, traversal, saving, with slow step-by-step animation and messages/icons
        ca_nodes = [c for c in self.components if c.component_type == "CA"]
        ca_keys = {}
        for idx, ca in enumerate(ca_nodes):
            id_prefix = f"{(idx+1)*100}"
            ca.name_label.setText(f"{ca.name}\nGenerating keys...")
            ca.message_label.setText("Generating keys...")
            ca.message_label.show()
            key_icon = QLabel(ca)

            #base_path = os.path.dirname(os.path.abspath(__file__))
            #image_path_key = os.path.join(base_path, 'assets/key.png')

            base_path = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
            image_path_key = os.path.join(base_path, 'assets', 'key.png')

            key_icon.setPixmap(QPixmap(image_path_key).scaled(18, 18, Qt.KeepAspectRatio))
            key_icon.move(0, 0)
            key_icon.show()
            ca.key_icon = key_icon
            QApplication.processEvents()
            sleep_with_events(1800)
            parent = self.parent()
            while parent and not hasattr(parent, 'mode'):
                parent = parent.parent()
            mode = parent.mode if parent else "simulation"
            if mode == "simulation":
                ca_keys[ca.name] = generate_keypair(id_prefix)
            else:
                vivado = VivadoInterface()
                ca_keys[ca.name] = vivado.run_keygen(id_prefix)
            ca.ca_keys = ca_keys[ca.name]
            os.makedirs("saved/ca_keys", exist_ok=True)
            with open(f"saved/ca_keys/{ca.name}_pk.txt", "w") as f:
                f.write(ca_keys[ca.name]['pk'])
            with open(f"saved/ca_keys/{ca.name}_sk.txt", "w") as f:
                f.write(ca_keys[ca.name]['sk'])
            ca.name_label.setText(f"{ca.name}\nKeys generated\nPK:{ca_keys[ca.name]['pk_id']} SK:{ca_keys[ca.name]['sk_id']}")
            ca.message_label.setText("Keys generated!")
            ca.message_label.setStyleSheet("background: white; color: green; border-radius: 3px;")
            ca.message_label.show()
            QApplication.processEvents()
            sleep_with_events(1800)

        root_ca = next(c for c in ca_nodes if c.name == "root-ca")
        for consumer in self.get_connected_consumers(root_ca):
            consumer.message_label.setText("Installing PK...")
            consumer.message_label.show()

            # base_path = os.path.dirname(os.path.abspath(__file__))
            # image_path_key = os.path.join(base_path, 'assets/key.png')

            base_path = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
            image_path_key = os.path.join(base_path, 'assets', 'key.png')
            
            self.animate_icon_along_link(root_ca, consumer, image_path_key, slow_ms=900)
            os.makedirs("saved/consumer_keys", exist_ok=True)
            with open(f"saved/consumer_keys/{consumer.name}_pk.txt", "w") as f:
                f.write(ca_keys[root_ca.name]['pk'])
            consumer.name_label.setText(f"{consumer.name}\nPK installed")
            consumer.message_label.setText("PK installed")
            consumer.message_label.show()
            consumer.installed_pk = ca_keys[root_ca.name]['pk']  # save for double-click
            QApplication.processEvents()
            sleep_with_events(1800)

        self.ndn_repo_certs = []
        for ca in ca_nodes:
            if ca.name == "root-ca":
                continue
            ca.message_manager.show_message("Sending PK to root CA...")
            # base_path = os.path.dirname(os.path.abspath(__file__))
            # image_path_key = os.path.join(base_path, 'assets/key.png')

            base_path = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
            image_path_key = os.path.join(base_path, 'assets', 'key.png')

            self.animate_icon_along_link(ca, root_ca, image_path_key, slow_ms=1000)
            root_ca.message_manager.show_message("Signing PK...")
            sign_icon = QLabel(root_ca)
            # base_path = os.path.dirname(os.path.abspath(__file__))
            # image_path_sig = os.path.join(base_path, 'assets/sign.png')

            base_path = os.path.dirname(os.path.abspath(__file__))
            image_path_sig = os.path.join(base_path, 'assets', 'sign.png')
            
            sign_icon.setPixmap(QPixmap(image_path_sig).scaled(18, 18, Qt.KeepAspectRatio))
            sign_icon.move(root_ca.width()-20, 0)
            sign_icon.show()
            QApplication.processEvents()
            sleep_with_events(1200)
            cert_name = f"/{ca.name}/KEY/{ca_keys[ca.name]['pk_id']}/google/{ca_keys[root_ca.name]['pk_id']}"
            parent = self.parent()
            while parent and not hasattr(parent, 'mode'):
                parent = parent.parent()
            mode = parent.mode if parent else "simulation"
            if mode == "simulation":
                sig = sign(ca_keys[root_ca.name]['sk'], ca_keys[ca.name]['pk'], ca_keys[ca.name]['pk_id'])
            else:
                vivado = VivadoInterface()
                sig = vivado.run_sign(ca_keys[root_ca.name]['sk'], ca_keys[ca.name]['pk'], ca_keys[ca.name]['pk_id'])
            ca.signature = sig
            root_ca.signature = root_ca.signature if hasattr(root_ca, 'signature') else {}
            root_ca.signature[ca.name] = sig
            root_ca.message_manager.show_message("Certificate generated")
            cert_icon = QLabel(root_ca)
            # base_path = os.path.dirname(os.path.abspath(__file__))
            # image_path_ca = os.path.join(base_path, 'assets/certificate.jpg')

            base_path = os.path.dirname(os.path.abspath(__file__))
            image_path_ca = os.path.join(base_path, 'assets', 'certificate.jpg')

            cert_icon.setPixmap(QPixmap(image_path_ca).scaled(18, 18, Qt.KeepAspectRatio))
            cert_icon.move(root_ca.width()-20, 22)
            cert_icon.show()
            root_ca.cert_icon = cert_icon
            QApplication.processEvents()
            sleep_with_events(1800)
            sign_icon.hide()
            root_ca.message_manager.hide_message()
            # base_path = os.path.dirname(os.path.abspath(__file__))
            # image_path_ca = os.path.join(base_path, 'assets/certificate.jpg')

            base_path = os.path.dirname(os.path.abspath(__file__))
            image_path_ca = os.path.join(base_path, 'assets', 'certificate.jpg')

            self.animate_icon_along_link(root_ca, ca, image_path_ca, slow_ms=1000)
            ca.name_label.setText(f"{ca.name}\nCert received")
            ca.message_manager.show_message("Cert received", duration_ms=1000)  # Hide after 1 seconds
            QApplication.processEvents()
            sleep_with_events(1800)
            cert_data = {
                "name": cert_name,
                "pk": ca_keys[ca.name]['pk'],
                "signature": sig['signature']
            }
            os.makedirs("saved/ca_certs", exist_ok=True)
            with open(f"saved/ca_certs/{ca.name}_cert.pkl", "wb") as f:
                pickle.dump(cert_data, f)
            self.ndn_repo_certs.append(cert_data)

        # Mark topology setup as complete and emit signal
        self.topology_setup_complete = True
        self.topology_setup_finished.emit()

    def set_paused(self, paused):
        self.paused = paused
        if not paused and self.anim_icons:
            self.anim_timer.start(50)
        else:
            self.anim_timer.stop()

    def animate_icon_along_link(self, start_comp, end_comp, icon_path, slow_ms=800):
        label = QLabel(self)
        pixmap = QPixmap(icon_path).scaled(20, 20, Qt.KeepAspectRatio)
        label.setPixmap(pixmap)
        label.show()
        start_pos = start_comp.pos() + QPoint(start_comp.width()//2, start_comp.height()//2)
        end_pos = end_comp.pos() + QPoint(end_comp.width()//2, end_comp.height()//2)
        anim = {'label': label, 'start': start_pos, 'end': end_pos, 'progress': 0.0, 'slow_ms': slow_ms}
        self.anim_icons.append(anim)
        if not self.paused:
            self.anim_timer.start(50)
        # Wait for the animation to finish before returning
        while anim in self.anim_icons:
            QApplication.processEvents()
            sleep_with_events(60 if not self.paused else 120)

    def animate_step(self):
        if self.paused:
            return
        to_remove = []
        for anim in self.anim_icons:
            anim['progress'] += 0.0125
            if anim['progress'] > 1.0:
                anim['label'].hide()
                anim['label'].deleteLater()
                to_remove.append(anim)
                continue
            sx, sy = anim['start'].x(), anim['start'].y()
            ex, ey = anim['end'].x(), anim['end'].y()
            nx = sx + (ex - sx) * anim['progress']
            ny = sy + (ey - sy) * anim['progress']
            anim['label'].move(int(nx - anim['label'].width()/2), int(ny - anim['label'].height()/2))
        for rem in to_remove:
            self.anim_icons.remove(rem)
        if not self.anim_icons:
            self.anim_timer.stop()

    def handle_topology_completed(self):
        # 1. Show popup with topology summary
        summary = {}
        for c in self.components:
            summary[c.component_type] = summary.get(c.component_type, 0) + 1
        msg = "Topology contains:\n"
        for k, v in summary.items():
            msg += f"- {v} {k}{'s' if v > 1 else ''}\n"
        QMessageBox.information(self, "Topology Summary", msg)

        # Inform user to select mode
        QMessageBox.information(self, "Mode Selection", "Please select mode (Simulation or Emulation) from the side panel.")
        self.topology_completed = True  # Flag to indicate topology is ready

        # Find parent and enable Request Content button
        parent = self.parent()
        while parent and not hasattr(parent, 'component_panel'):
            parent = parent.parent()
        if parent:
            parent.component_panel.enable_request_button()  # Enable Request Content button

    def get_connected_consumers(self, ca):
        return [c for c in ca.connected_components if c.component_type == "Consumer"]

    def mouseDoubleClickEvent(self, event):
    # Check for double-click on data packet icons near consumers
        for comp in self.components:
            if comp.component_type == "Consumer":
                for dp_icon in comp.data_packet_icons:
                    if dp_icon.geometry().contains(event.pos()):
                        dialog = KeyDetailsDialog(f"{comp.name} Data Packet", dp_icon.packet_info, self)
                        dialog.exec_()
                        return

        for comp in self.components:
            if comp.component_type == "Consumer" and comp.geometry().contains(event.pos()):
                data = prepare_consumer_data(comp)
                
                # Add interest packets to the data dictionary
                if hasattr(comp, "interest_packets") and comp.interest_packets:
                    for i, packet in enumerate(comp.interest_packets, 1):
                        packet_data = {
                            "Interest Packet ID": str(packet.packet_id),
                            "Name": packet.name
                        }
                        data[f"Interest Packet {i}"] = packet_data

                if data:
                    dialog = KeyDetailsDialog(f"{comp.name} Public Key", data, self)
                    dialog.exec_()
                else:
                    QMessageBox.information(self, f"{comp.name}", "No PK installed.")
                return

            if comp.component_type == "CA" and comp.geometry().contains(event.pos()):
                data = prepare_ca_data(comp)
                if data:
                    dialog = KeyDetailsDialog(f"{comp.name} Keys and Signatures", data, self)
                    dialog.exec_()
                else:
                    QMessageBox.information(self, f"{comp.name}", "No keys or signatures available.")
                return

        for comp in self.components:
            if comp.component_type == "NDN Repo" and comp.geometry().contains(event.pos()):
                self.show_ndn_repo_table()
                break

        for comp in self.components:
            if comp.component_type == "Router" and comp.geometry().contains(event.pos()):
                self.show_router_tables_dialog(comp)
                return
        for comp in self.components:
            if comp.component_type == "Producer" and comp.geometry().contains(event.pos()):
                data = prepare_producer_data(comp)
                if data:
                    dialog = KeyDetailsDialog(f"{comp.name} Keys and Signatures", data, self)
                    dialog.exec_()
                else:
                    QMessageBox.information(self, f"{comp.name}", "No keys or signatures available.")
                return


    def show_ndn_repo_table(self):
        if not hasattr(self, 'ndn_repo_certs') or not self.ndn_repo_certs:
            QMessageBox.information(self, "NDN Repo", "No certificates available.")
            return
        dlg = QDialog(self)
        dlg.setWindowTitle("NDN Repo Certificates")
        layout = QVBoxLayout(dlg)
        table = QTableWidget()
        table.setColumnCount(3)
        table.setHorizontalHeaderLabels(["Name", "Public Key", "Signature"])
        table.horizontalHeader().setSectionResizeMode(QHeaderView.Stretch)
        table.setRowCount(len(self.ndn_repo_certs))
        for i, cert in enumerate(self.ndn_repo_certs):
            table.setItem(i, 0, QTableWidgetItem(cert["name"]))
            table.setItem(i, 1, QTableWidgetItem(cert["pk"]))
            table.setItem(i, 2, QTableWidgetItem(cert["signature"]))
        layout.addWidget(table)
        dlg.resize(700, 400)
        dlg.exec_()

    def set_link_mode(self, enabled):
        self.link_mode = enabled
        self.link_start_component = None
        self.setCursor(Qt.CrossCursor if enabled else Qt.ArrowCursor)

    def add_component(self, component_type, image_path, position=None):
        if component_type == "CA" and self.ca_count >= MAX_CA:
            QMessageBox.warning(self, "Component Limit", f"Maximum of {MAX_CA} CAs allowed.")
            return None
        elif component_type == "Producer" and self.producer_count >= MAX_PRODUCER:
            QMessageBox.warning(self, "Component Limit", f"Maximum of {MAX_PRODUCER} Producers allowed.")
            return None
        elif component_type == "Consumer" and self.consumer_count >= MAX_CONSUMER:
            QMessageBox.warning(self, "Component Limit", f"Maximum of {MAX_CONSUMER} Consumers allowed.")
            return None
        elif component_type == "Router" and self.router_count >= MAX_ROUTER:
            QMessageBox.warning(self, "Component Limit", f"Maximum of {MAX_ROUTER} Routers allowed.")
            return None
        elif component_type == "NDN Repo" and self.ndn_repo_count >= MAX_NDN_REPO:
            QMessageBox.warning(self, "Component Limit", f"Maximum of {MAX_NDN_REPO} NDN Repos allowed.")
            return None

        name = ""
        if component_type == "CA":
            if self.ca_count == 0:
                name = "root-ca"
                self.root_ca = name
            else:
                used_cas = [c.name for c in self.components if c.component_type == "CA" and c.name != "root-ca"]
                available_cas = [ca for ca in CA_CATEGORIES if ca not in used_cas]
                if not available_cas:
                    QMessageBox.warning(self, "No CA", "No available CA category for subordinate CA.")
                    return None
                ca_cat, ok = QInputDialog.getItem(
                    self, "Subordinate CA Category", "Select CA Category:",
                    available_cas, 0, False
                )
                if not ok or not ca_cat:
                    return None
                name = ca_cat
            self.ca_count += 1
            self.ca_names.add(name)
        elif component_type == "NDN Repo":
            ca_count = sum(1 for c in self.components if c.component_type == "CA")
            if ca_count <= 1:
                QMessageBox.warning(self, "NDN Repo Not Allowed", "NDN Repository is not allowed in single CA topology.")
                return None
            name = "NDN Repository"
            self.ndn_repo_count += 1
        elif component_type == "Producer":
            available = [cat for cat in PRODUCER_CATEGORIES if cat not in self.producer_names]
            if not available:
                QMessageBox.warning(self, "Producer Limit", "All producer categories have been used.")
                return None
            category, ok = QInputDialog.getItem(
                self, "Producer Category", "Select Producer Category:",
                available, 0, False
            )
            if not ok or not category:
                return None
            name = category
            self.producer_count += 1
            self.producer_names.add(name)
        else:
            name, ok = QInputDialog.getText(
                self, f"Name {component_type}",
                f"Enter {component_type} name:", QLineEdit.Normal
            )
            if not ok or not name:
                return None
            if component_type == "Consumer":
                self.consumer_count += 1
            elif component_type == "Router":
                self.router_count += 1

        component = Component(name, component_type, image_path, self)
        if position:
            component.move(position)
        else:
            component.move((self.width() - component.width()) // 2,
                           (self.height() - component.height()) // 2)
        self.components.append(component)
        component.show()
        return component

    def mousePressEvent(self, event):
        if event.button() == Qt.RightButton:
            # Check if right-click is near any link line
            pos = event.pos()
            link_to_delete = None
            threshold = 6  # pixels tolerance

            for link in self.links:
                p1 = link.component1.pos() + QPoint(link.component1.width() // 2, link.component1.height() // 2)
                p2 = link.component2.pos() + QPoint(link.component2.width() // 2, link.component2.height() // 2)
                if self._point_near_line(pos, p1, p2, threshold):
                    link_to_delete = link
                    break

            if link_to_delete:
                menu = QMenu(self)
                delete_action = menu.addAction("Delete Link")
                action = menu.exec_(self.mapToGlobal(pos))
                if action == delete_action:
                    self.delete_link(link_to_delete)
                return  # Consume event

        if self.link_mode:
            for component in self.components:
                if component.geometry().contains(event.pos()):
                    if self.link_start_component is None:
                        self.link_start_component = component
                        self.setCursor(Qt.DragLinkCursor)
                    else:
                        valid, message = self.validate_connection(self.link_start_component, component)
                        if valid:
                            new_link = Link(self.link_start_component, component, self)
                            self.links.append(new_link)
                            new_link.show()
                        else:
                            QMessageBox.warning(self, "Invalid Connection", message)
                        self.link_start_component = None
                        self.setCursor(Qt.CrossCursor)
                    break
        else:
            super().mousePressEvent(event)

    def _point_near_line(self, pt, line_start, line_end, threshold):
        x, y = pt.x(), pt.y()
        x1, y1 = line_start.x(), line_start.y()
        x2, y2 = line_end.x(), line_end.y()

        dx = x2 - x1
        dy = y2 - y1
        if dx == dy == 0:
            dist = ((x - x1)**2 + (y - y1)**2)**0.5
            return dist <= threshold

        t = ((x - x1)*dx + (y - y1)*dy) / (dx*dx + dy*dy)
        t = max(0, min(1, t))
        nearest_x = x1 + t*dx
        nearest_y = y1 + t*dy
        dist = ((x - nearest_x)**2 + (y - nearest_y)**2)**0.5
        return dist <= threshold
    
    def delete_component(self, component):
        for link in list(component.links):
            self.delete_link(link)
        if component.component_type == "Consumer":
            # Clear interest packets
            if hasattr(component, "interest_packets"):
                for packet in list(component.interest_packets):
                    if packet in self.interest_packets:
                        self.interest_packets.remove(packet)
                        packet.deleteLater()
                component.interest_packets.clear()
            # Clear data packet icons
            if hasattr(component, "data_packet_icons"):
                for dp_icon in list(component.data_packet_icons):
                    if dp_icon in self.data_packets:
                        self.data_packets.remove(dp_icon)
                        dp_icon.hide()
                        dp_icon.deleteLater()
                component.data_packet_icons.clear()
            # Clear other consumer data
            for attr in ["fetched_certificates", "verification_results", "installed_pk"]:
                if hasattr(component, attr):
                    setattr(component, attr, None)
        elif component.component_type == "Producer":
            # Clear data packet icons
            if hasattr(component, "data_packet_icons"):
                for dp_icon in list(component.data_packet_icons):
                    if dp_icon in self.data_packets:
                        self.data_packets.remove(dp_icon)
                        dp_icon.hide()
                        dp_icon.deleteLater()
                component.data_packet_icons.clear()
            # Clear other producer data
            for attr in ["ca_keys", "producer_certificate", "data_signatures", "last_interest_from"]:
                if hasattr(component, attr):
                    setattr(component, attr, None)
        if component in self.components:
            self.components.remove(component)
            component.deleteLater()
            if component.component_type == "CA":
                self.ca_count -= 1
                self.ca_names.discard(component.name)
            elif component.component_type == "Producer":
                self.producer_count -= 1
                self.producer_names.discard(component.name)
            elif component.component_type == "Consumer":
                self.consumer_count -= 1
            elif component.component_type == "Router":
                self.router_count -= 1
            elif component.component_type == "NDN Repo":
                self.ndn_repo_count -= 1
        for comp in self.components:
            comp.raise_()

    def delete_link(self, link):
        if link in self.links:
            self.links.remove(link)
            if link.component1:
                if link in link.component1.links:
                    link.component1.links.remove(link)
                if link.component2 in link.component1.connected_components:
                    link.component1.connected_components.remove(link.component2)
            if link.component2:
                if link in link.component2.links:
                    link.component2.links.remove(link)
                if link.component1 in link.component2.connected_components:
                    link.component2.connected_components.remove(link.component1)
            link.deleteLater()

    def validate_connection(self, c1, c2):
        if c1 is c2:
            return False, "Cannot connect a component to itself."
        if c2 in c1.connected_components:
            return False, "These components are already connected."
        t1, t2 = c1.component_type, c2.component_type
        n1, n2 = c1.name, c2.name
        ca_components = [c for c in self.components if c.component_type == "CA"]
        ca_count = len(ca_components)
        root_ca = next((c for c in ca_components if c.name == "root-ca"), None)

        # Prevent Producer-to-Producer connections
        if t1 == "Producer" and t2 == "Producer":
            return False, "Producers cannot connect to each other."

        if t1 == "CA" or t2 == "CA":
            ca, other = (c1, c2) if t1 == "CA" else (c2, c1)
            is_root = ca.name == "root-ca"
            is_sub = ca.name in CA_CATEGORIES
            if other.component_type == "Router":
                return False, "CA cannot connect to Routers."
            if ca_count == 1:
                if is_root and other.component_type in ["Consumer", "Producer"]:
                    return True, ""
                if is_root and other.component_type == "NDN Repo":
                    return False, "NDN Repository is not allowed in single CA topology."
                return False, "Root CA can only connect to Producers and Consumers in single CA topology."
            else:
                if is_root:
                    if other.component_type == "Consumer":
                        return True, ""
                    if other.component_type == "CA" and other.name in CA_CATEGORIES:
                        return True, ""
                    return False, "Root CA can only connect to Consumers and Subordinate CAs."
                elif is_sub:
                    if other.component_type == "Producer":
                        expected_ca = PRODUCER_TO_CA.get(other.name)
                        if expected_ca and expected_ca == ca.name:
                            return True, ""
                        return False, f"{ca.name} can only connect to its relevant Producer(s)."
                    if other.component_type == "CA" and other.name == "root-ca":
                        return True, ""
                    return False, "Subordinate CA can only connect to Root CA or its relevant Producers."
        if t1 == "NDN Repo" or t2 == "NDN Repo":
            if ca_count <= 1:
                return False, "NDN Repository is not allowed in single CA topology."
            other = c2 if t1 == "NDN Repo" else c1
            if other.component_type != "Consumer":
                return False, "NDN Repository can only connect to Consumers."
            return True, ""
        if t1 == "Router" or t2 == "Router":
            other = c2 if t1 == "Router" else c1
            if other.component_type not in ["Router", "Producer", "Consumer"]:
                return False, "Routers can only connect to Routers, Producers, or Consumers."
            return True, ""
        return True, ""

    def resizeEvent(self, event):
        for link in self.links:
            link.setGeometry(0, 0, self.width(), self.height())
            link.update_position()
        super().resizeEvent(event)
    
    def show_router_tables_dialog(self, router_comp):
        dlg = QDialog(self)
        dlg.setAttribute(Qt.WA_DeleteOnClose)  # Ensure dialog is destroyed after closing
        dlg.setWindowTitle(f"{router_comp.name} Tables")
        layout = QVBoxLayout(dlg)

        def add_table(label, data, col_headers):
            group = QGroupBox(label)
            vbox = QVBoxLayout(group)
            table = QTableWidget()
            table.setColumnCount(len(col_headers))
            table.setHorizontalHeaderLabels(col_headers)
            table.horizontalHeader().setSectionResizeMode(QHeaderView.Stretch)
            table.setRowCount(len(data))
            for i, row in enumerate(data):
                for j, h in enumerate(col_headers):
                    item = QTableWidgetItem(str(row[h.lower()]))
                    table.setItem(i, j, item)
            vbox.addWidget(table)
            layout.addWidget(group)

        # Debug: Print the state of the tables before displaying
        # print(f"[DEBUG] Displaying tables for {router_comp.name} - CS: {router_comp.router_table.cs}")
        # print(f"[DEBUG] Displaying tables for {router_comp.name} - PIT: {router_comp.router_table.pit}")
        # print(f"[DEBUG] Displaying tables for {router_comp.name} - FIB: {router_comp.router_table.fib}")

        add_table("Content Store (CS)", router_comp.router_table.cs, ["Name", "Data"])
        add_table("Pending Interest Table (PIT)", router_comp.router_table.pit, ["Name", "Incoming_Interface"])
        add_table("Forwarding Info Base (FIB)", router_comp.router_table.fib, ["Name", "Outgoing_Interface"])

        dlg.resize(800, 550)
        dlg.exec_()

    def traverse_interest_packet(self, consumer, producer, interest_name, packet):
        graph, name_to_comp = build_topology_graph(self.components)
        print("COMPONENTS:", [(c.name, c.component_type, [n.name for n in c.connected_components]) for c in self.components])
        path = bfs_shortest_path(graph, consumer.name, producer.name)
        print("PATH FOUND:", path)

        if not path or len(path) < 2:
            QMessageBox.warning(self, "Path Error", "No path found between Consumer and Producer.")
            return

        prev_node = consumer.name
        for idx in range(1, len(path)):
            curr_node = path[idx]
            curr_comp = name_to_comp[curr_node]
            prev_comp = name_to_comp[prev_node]

            # base_path = os.path.dirname(os.path.abspath(__file__))
            # image_path_pac = os.path.join(base_path, 'assets/packet.png')

            base_path = os.path.dirname(os.path.abspath(__file__))
            image_path_pac = os.path.join(base_path, 'assets', 'packet.png')

            self.animate_icon_along_link(prev_comp, curr_comp, image_path_pac, slow_ms=800)
            if curr_comp.component_type == "Router":
                rtab = curr_comp.router_table
                found = rtab.get_cs(interest_name)
                curr_comp.message_label.setText("Checking CS...")
                curr_comp.message_label.show()
                QApplication.processEvents()
                sleep_with_events(800)
                if found:
                    retrieve_data_from_router(self, curr_comp, consumer, found, interest_name)
                    return  # Stop traversal
                incoming_if = prev_node
                rtab.add_pit(interest_name, incoming_if)
                curr_comp.message_label.setText("Added to PIT.")
                QApplication.processEvents()
                sleep_with_events(700)
                outgoing_if = path[idx+1] if idx+1 < len(path) else producer.name
                normalized_name = interest_name.lower().rstrip('/')
                rtab.add_fib(normalized_name, outgoing_if)
                curr_comp.message_label.setText(f"FIB updated. Next: {outgoing_if}")
                QApplication.processEvents()
                sleep_with_events(700)
                curr_comp.message_label.setText("Data not found, forwarding...")
                QApplication.processEvents()
                sleep_with_events(800)
                curr_comp.message_label.hide()
            prev_node = curr_node

        producer.message_label.setText("Interest received!")
        producer.message_label.show()
        producer.last_interest_from = prev_comp  # Added: Track where the interest came from
        QApplication.processEvents()
        sleep_with_events(1200)
        producer.message_label.hide()

        # Now handle data packet generation for step 6
        handle_interest_packet_reach_producer(self, producer, interest_name)

    def traverse_data_packet(self, producer, data_packet_icon):
        # Extract the data packet info from the DataPacketIcon
        data_packet = data_packet_icon.packet_info

        # Start traversal from the producer
        current_component = producer
        while current_component:
            # Determine the next component to send the data packet to
            if current_component.component_type == "Producer":
                next_component = current_component.last_interest_from
                if not next_component:
                    QMessageBox.warning(self, "Traversal Error", "No path back to consumer found.")
                    return
                # Clear producer message before moving
                current_component.message_manager.hide_message()
                # Animate the data packet moving to the next component
                # base_path = os.path.dirname(os.path.abspath(__file__))
                # image_path_pac = os.path.join(base_path, 'assets/packet.png')

                base_path = os.path.dirname(os.path.abspath(__file__))
                image_path_pac = os.path.join(base_path, 'assets', 'packet.png')
                self.animate_icon_along_link(current_component, next_component, image_path_pac, slow_ms=800)
                current_component = next_component
            elif current_component.component_type == "Router":
                rtab = current_component.router_table
                # Check CS
                current_component.message_manager.show_message("Checking router tables...")
                QApplication.processEvents()
                sleep_with_events(800)

                # Add to CS if not already present
                if not rtab.get_cs(data_packet['name']):
                    rtab.add_cs(data_packet['name'], data_packet)
                    current_component.message_manager.show_message("Updating CS...")
                    QApplication.processEvents()
                    sleep_with_events(800)
                    # Save to backend
                    os.makedirs("saved/router_cs", exist_ok=True)
                    safe_name = data_packet['name'].replace('/', '_')
                    with open(f"saved/router_cs/{current_component.name}_cs_{safe_name}.pkl", "wb") as f:
                        pickle.dump(data_packet, f)
                    current_component.message_manager.show_message("CS updated successfully!")
                    QApplication.processEvents()
                    sleep_with_events(800)

                # Check PIT to find where to forward the data packet
                pit_entry = next((entry for entry in rtab.pit if entry['name'] == data_packet['name']), None)
                if pit_entry:
                    incoming_if = pit_entry['incoming_interface']
                    next_component = next((c for c in self.components if c.name == incoming_if), None)
                    if not next_component:
                        QMessageBox.warning(self, "Traversal Error", f"Cannot find component {incoming_if}.")
                        return
                    # Update PIT: Remove the entry since the request is fulfilled
                    rtab.remove_pit(data_packet['name'])
                    current_component.message_manager.show_message("Updating PIT...")
                    QApplication.processEvents()
                    sleep_with_events(800)

                    # Update FIB: Add the outgoing interface
                    normalized_name = data_packet['name'].lower().rstrip('/')
                    print(f"[DEBUG] Before updating FIB for {current_component.name} with name: {normalized_name}, incoming_if: {incoming_if}")
                    rtab.add_fib(normalized_name, incoming_if)
                    current_component.message_manager.show_message(f"Updating FIB: Forwarding to {incoming_if}")
                    QApplication.processEvents()
                    sleep_with_events(800)

                    # Clear message before moving to next component
                    current_component.message_manager.hide_message()
                    # Animate the data packet moving to the next component
                    # base_path = os.path.dirname(os.path.abspath(__file__))
                    # image_path_pac = os.path.join(base_path, 'assets/packet.png')
                    base_path = os.path.dirname(os.path.abspath(__file__))
                    image_path_pac = os.path.join(base_path, 'assets', 'packet.png')

                    self.animate_icon_along_link(current_component, next_component, image_path_pac, slow_ms=800)
                    current_component = next_component
                else:
                    current_component.message_manager.show_message("No PIT entry found.")
                    QApplication.processEvents()
                    sleep_with_events(800)
                    current_component.message_manager.hide_message()
                    break
            elif current_component.component_type == "Consumer":
                # Data packet reached the consumer
                current_component.message_manager.show_message("Data packet received!")
                QApplication.processEvents()
                sleep_with_events(1200)

                # Add data packet icon near the consumer
                dp_icon = DataPacketIcon(self, current_component, data_packet)
                dp_icon.setParent(self)
                dp_icon.show()
                current_component.data_packet_icons.append(dp_icon)
                self.data_packets.append(dp_icon)
                current_component.message_manager.show_message("Data packet displayed!")
                QApplication.processEvents()
                sleep_with_events(800)

                # Start verification process
                if not self.paused:
                    verify_signatures(self, current_component, data_packet)
                else:
                    # Wait for unpause to verify
                    while self.paused:
                        QApplication.processEvents()
                        sleep_with_events(100)
                    verify_signatures(self, current_component, data_packet)

                current_component.message_manager.hide_message()
                break

            current_component.message_label.hide()

    def create_interest_packet(self, name, consumer):
        print("[DEBUG] create_interest_packet CALLED with:", name, consumer.name if consumer else None)

        if not consumer:
            QMessageBox.warning(self, "No Consumer", "Add a consumer first")
            return

        # Remove previous Interest Packet widget for this consumer
        if hasattr(consumer, "interest_packets"):
            for packet in consumer.interest_packets:
                if packet in self.interest_packets:
                    self.interest_packets.remove(packet)
                    packet.hide()
                    packet.deleteLater()
            consumer.interest_packets.clear()  # Clear GUI packets but retain data elsewhere

        packet_id = self.interest_packet_counter
        self.interest_packet_counter += 1
        packet = InterestPacket(packet_id, name, self)
        packet.move(consumer.x() + 70, consumer.y() - 30)
        packet.show()
        self.interest_packets.append(packet)

        if not hasattr(consumer, "interest_packets"):
            consumer.interest_packets = []
        consumer.interest_packets.append(packet)

        producer = next(
            (c for c in self.components
            if c.component_type == "Producer" and c.name.lower() in name.lower()),
            None
        )
        if producer:
            # Immediately start traversal!
            self.traverse_interest_packet(consumer, producer, name, packet)

class NDNDilithiumApp(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Athestia - Named Data Network with Dilithium")
        self.mode = "simulation"
        self.setGeometry(100, 100, 1300, 800)
        central_widget = QWidget()
        central_widget.setStyleSheet("background: white;")
        self.setCentralWidget(central_widget)
        
        # Main layout for the entire window (vertical to include tabs)
        main_layout = QVBoxLayout(central_widget)
        
        # Add tab bar at the top
        self.tab_bar = QTabBar(self)
        self.tab_bar.addTab("New")
        self.tab_bar.addTab("Save")
        self.tab_bar.addTab("Exit/Close")
        self.tab_bar.setStyleSheet("""
            QTabBar::tab {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1, stop:0 #e6f0fa, stop:1 #c3d9f0);
                border: 1px solid #a3c1da;
                border-bottom: none;
                border-top-left-radius: 5px;
                border-top-right-radius: 5px;
                padding: 5px 15px;
                margin-right: 2px;
                color: #333;
            }
            QTabBar::tab:selected {
                background: white;
                border-bottom: 2px solid #1976d2;
                color: #1976d2;
            }
            QTabBar::tab:hover:!selected {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1, stop:0 #f0f7ff, stop:1 #d9e6f7);
            }
        """)
        self.tab_bar.currentChanged.connect(self.handle_tab_changed)
        main_layout.addWidget(self.tab_bar)
        
        # Layout for the component panel and canvas (horizontal)
        content_layout = QHBoxLayout()
        self.component_panel = ComponentPanel(self)
        content_layout.addWidget(self.component_panel)
        # Create a scroll area for the canvas
        canvas_scroll = QScrollArea(self)
        canvas_scroll.setWidgetResizable(True)
        self.canvas = TopologyCanvas(self)
        self.canvas.setMinimumSize(1200, 800)  # Ensure the canvas has a reasonable minimum size
        canvas_scroll.setWidget(self.canvas)
        content_layout.addWidget(canvas_scroll, 4)
        main_layout.addLayout(content_layout)
        
        self.component_panel.component_clicked.connect(self.handle_component_click)
        self.component_panel.link_mode_clicked.connect(self.toggle_link_mode)
        self.component_panel.topology_btn.clicked.connect(self.canvas.handle_topology_completed)
        self.canvas.topology_setup_finished.connect(self.component_panel.enable_request_button)
    
    def handle_component_click(self, component_type, image_path):
        if component_type == "Link":
            self.component_panel.link_btn.setChecked(True)
            self.toggle_link_mode()
        else:
            self.canvas.add_component(component_type, image_path)

    def toggle_link_mode(self):
        self.canvas.set_link_mode(self.component_panel.link_btn.isChecked())
    
    # def toggle_play_pause(self, paused):
    #     self.canvas.set_paused(paused)

    def finish_topology(self):
        ca_count = sum(1 for c in self.canvas.components if c.component_type == "CA")
        producer_count = sum(1 for c in self.canvas.components if c.component_type == "Producer")
        consumer_count = sum(1 for c in self.canvas.components if c.component_type == "Consumer")
        if ca_count == 0:
            QMessageBox.warning(self, "Invalid Topology", "Topology must have at least one CA.")
            return
        if producer_count == 0:
            QMessageBox.warning(self, "Invalid Topology", "Topology must have at least one Producer.")
            return
        if consumer_count == 0:
            QMessageBox.warning(self, "Invalid Topology", "Topology must have at least one Consumer.")
            return
        QMessageBox.information(self, "Topology Complete",
            f"Topology created successfully with:\n"
            f"- {ca_count} Certificate Authorities\n"
            f"- {producer_count} Producers\n"
            f"- {consumer_count} Consumers\n"
            f"- {sum(1 for c in self.canvas.components if c.component_type == 'Router')} Routers\n"
            f"- {sum(1 for c in self.canvas.components if c.component_type == 'NDN Repo')} NDN Repositories"
        )


    def handle_tab_changed(self, index):
        """Handle tab selection for New, Save, and Exit/Close."""
        tab_name = self.tab_bar.tabText(index)
        
        if tab_name == "New":
            # Clear the current topology
            self.canvas.components.clear()
            self.canvas.links.clear()
            self.canvas.ca_count = 0
            self.canvas.producer_count = 0
            self.canvas.consumer_count = 0
            self.canvas.router_count = 0
            self.canvas.ndn_repo_count = 0
            self.canvas.root_ca = None
            self.canvas.ca_names.clear()
            self.canvas.producer_names.clear()
            self.canvas.topology_completed = False
            self.canvas.topology_setup_complete = False
            self.canvas.ndn_repo_certs.clear()
            self.canvas.interest_packet_counter = 1
            self.canvas.data_packets.clear()
            # Clear all child widgets (components, links, packets)
            for widget in self.canvas.children():
                if isinstance(widget, (Component, Link, InterestPacket, DataPacketIcon)):
                    widget.deleteLater()
            # Reset the component panel state
            self.component_panel.request_btn.setEnabled(False)
            self.component_panel.request_btn.setToolTip("Complete the topology setup to enable this button.")
            self.component_panel.simulation_btn.setChecked(False)
            self.component_panel.emulation_btn.setChecked(False)
            self.component_panel.simulation_btn.setEnabled(True)
            self.component_panel.emulation_btn.setEnabled(VivadoInterface().is_vivado_available())
            self.mode = "simulation"
            # Clear saved directories
            for folder in ["saved/ca_keys", "saved/ca_certs", "saved/consumer_keys", "saved/producer_keys", "saved/producer_certs", "saved/producer_data_sigs", "saved/consumer_verification", "saved/router_cs"]:
                if os.path.exists(folder):
                    shutil.rmtree(folder)
                os.makedirs(folder, exist_ok=True)
            QMessageBox.information(self, "New Topology", "A new empty topology has been created.")
        
        elif tab_name == "Save":
            # Open a file dialog to save the topology
            file_path, _ = QFileDialog.getSaveFileName(
                self, "Save Topology", "", "Topology Files (*.topo);;All Files (*)"
            )
            if file_path:
                # Save topology data
                topology_data = {
                    "components": [
                        {
                            "name": comp.name,
                            "component_type": comp.component_type,
                            "image_path": comp.image_path,
                            "position": (comp.x(), comp.y()),
                            "connected_components": [c.name for c in comp.connected_components]
                        } for comp in self.canvas.components
                    ],
                    "links": [
                        {
                            "component1": link.component1.name,
                            "component2": link.component2.name
                        } for link in self.canvas.links
                    ],
                    "mode": self.mode,
                    "topology_completed": self.canvas.topology_completed,
                    "topology_setup_complete": self.canvas.topology_setup_complete
                }
                try:
                    with open(file_path, "wb") as f:
                        pickle.dump(topology_data, f)
                    QMessageBox.information(self, "Save Successful", f"Topology saved to {file_path}")
                except Exception as e:
                    QMessageBox.warning(self, "Save Error", f"Failed to save topology: {str(e)}")
        
        elif tab_name == "Exit/Close":
            # Close the application
            self.close()
        
        # Reset the tab bar to avoid re-triggering (optional, depending on UX preference)
        self.tab_bar.setCurrentIndex(-1)

class SplashScreen(QWidget):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Athestia")
        self.setGeometry(300, 200, 800, 400)
        self.setGeometry(QApplication.desktop().screenGeometry())
        self.init_ui()
        # self.showFullScreen()

    def init_ui(self):
        # Set background
        self.background_label = QLabel(self)
        # base_path = os.path.dirname(os.path.abspath(__file__))
        # background_image = os.path.join(base_path, 'assets/background_image.jpg')

        base_path = os.path.dirname(os.path.abspath(__file__))
        background_image = os.path.join(base_path, 'assets/background_image.jpg')
        
        self.background_label.setPixmap(QPixmap(background_image))
        self.background_label.setScaledContents(True)
        self.background_label.resize(self.size())

        # Main vertical layout
        main_layout = QVBoxLayout(self)

        # --- Top-right buttons ---
        top_layout = QHBoxLayout()
        logo_label = QLabel()
        base_path = os.path.dirname(os.path.abspath(__file__))
        logo_image = os.path.join(base_path, 'assets/logo_2.png')

        # base_path = os.path.dirname(os.path.abspath(__file__))
        # logo_image = os.path.join(base_path, 'assets/logo_2.jpg')

        logo_pixmap = QPixmap(logo_image)  # 🔁 Replace with your actual file path
        logo_pixmap = logo_pixmap.scaled(140, 140, Qt.KeepAspectRatio, Qt.SmoothTransformation)
        logo_label.setPixmap(logo_pixmap)
        top_layout.addWidget(logo_label)

        # Spacer to push buttons to the right
        top_layout.addStretch()
        top_layout.setAlignment(Qt.AlignRight)

        home_button = QPushButton("Home")
        about_button = QPushButton("About")

        for btn in [home_button, about_button]:
            btn.setStyleSheet("""
                QPushButton {
                    background: transparent;
                    color: yellow;
                    border: none;
                    font-size: 14px;
                    font-weight: bold;
                }
                QPushButton:hover {
                    text-decoration: underline;
                }
            """)
            top_layout.addWidget(btn)

        main_layout.addLayout(top_layout)

        # --- Spacer to push content to bottom ---
        main_layout.addStretch()

        center_layout = QHBoxLayout()
        center_layout.setAlignment(Qt.AlignLeft)

        quote_container = QVBoxLayout()
        quote_container.addStretch()

        quote = QLabel("""
        Cryptography is the art of creating secrets.<br>
        Cryptography is the ultimate puzzle game for mathematicians.<br>
        <i>"Privacy is not a privilege; it’s a right."</i>
                """)
        quote.setStyleSheet("""
                    color: #ffbe0b;
                    font-size: 18px;
                    background: transparent;
                """)
        quote.setFont(QFont("Arial", 14))
        quote.setTextFormat(Qt.RichText)
        quote.setWordWrap(True)
        quote.setFixedWidth(400)

        quote_container.addWidget(quote)
        quote_container.addStretch()

        center_layout.addLayout(quote_container)
        main_layout.addLayout(center_layout)

        # --- Bottom-right "Get Started" button ---
        bottom_layout = QHBoxLayout()
        bottom_layout.setAlignment(Qt.AlignRight)

        button = QPushButton("Get Started")
        button.setFixedSize(200, 50)
        font = QFont()
        font.setPointSize(14)
        font.setBold(True)
        button.setFont(font)
        button.setStyleSheet("background-color: #ffbe0b; color: #1e1e2f; border-radius: 10px;")
        button.clicked.connect(self.launch_main_window)
        home_button.clicked.connect(self.launch_home_window)
        about_button.clicked.connect(self.launch_about_window)

        bottom_layout.addWidget(button)
        main_layout.addLayout(bottom_layout)

        self.setLayout(main_layout)

    def launch_main_window(self):
        self.main_window = NDNDilithiumApp()
        self.main_window.show()
        self.close()

    def launch_home_window(self):
        self.main_window = SplashScreen()
        self.main_window.show()
        self.close()

    def launch_about_window(self):
        self.main_window = PQCWindow()
        self.main_window.show()
        self.close()

class PQCWindow(QWidget):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Post-Quantum Cryptography")
        self.setGeometry(QApplication.desktop().screenGeometry())
        # self.showFullScreen()
        self.init_ui()

    def init_ui(self):
        # Set background color to navy blue
        palette = self.palette()
        palette.setColor(QPalette.Window, QColor("#001f3f"))  # Navy Blue
        self.setPalette(palette)
        self.setAutoFillBackground(True)

        # Main layout
        main_layout = QVBoxLayout(self)
        main_layout.setContentsMargins(30, 30, 30, 30)

        # --- Top bar with "Home" and "About" buttons ---
        top_bar_layout = QHBoxLayout()
        top_bar_layout.setAlignment(Qt.AlignRight)
        logo_label = QLabel()
        base_path = os.path.dirname(os.path.abspath(__file__))
        logo_image = os.path.join(base_path, 'assets/logo_2.png')
        logo_pixmap = QPixmap(logo_image)  # 🔁 Replace with your actual file path
        logo_pixmap = logo_pixmap.scaled(140, 140, Qt.KeepAspectRatio, Qt.SmoothTransformation)
        logo_label.setPixmap(logo_pixmap)
        top_bar_layout.addWidget(logo_label)
        top_bar_layout.addStretch()

        home_button = QPushButton("Home")
        about_button = QPushButton("About")

        for btn in [home_button, about_button]:
            btn.setStyleSheet("""
                QPushButton {
                    background: transparent;
                    color: yellow;
                    border: none;
                    font-size: 14px;
                    font-weight: bold;
                }
                QPushButton:hover {
                    text-decoration: underline;
                }
            """)
            top_bar_layout.addWidget(btn)

        main_layout.addLayout(top_bar_layout)

        # --- Title ---
        title = QLabel("Post Quantum Cryptography")
        title.setFont(QFont("Arial", 24, QFont.Bold))
        title.setStyleSheet("color: white;")
        title.setAlignment(Qt.AlignLeft)
        home_button.clicked.connect(self.launch_home_window)
        about_button.clicked.connect(self.launch_about_window)
        main_layout.addWidget(title)

        # --- Scrollable content ---
        content = """Post-quantum cryptography (PQC) refers to cryptographic algorithms that are secure against the potential threats posed by quantum computers. Quantum computers, once they reach a certain level of advancement, are expected to break many of the classical cryptographic systems we currently use, such as RSA and ECC (Elliptic Curve Cryptography). The need for PQC is driven by the fact that quantum computers could efficiently solve problems like integer factorization and discrete logarithms, which form the foundation of current public-key cryptosystems.

The goal of post-quantum cryptography is to develop cryptographic systems that are resistant to both classical and quantum attacks. These systems rely on mathematical problems that are believed to be difficult for quantum computers to solve. Examples of these problems include lattice-based cryptography, hash-based signatures, and multivariate polynomial equations.

As quantum computers continue to evolve, the cryptographic community is working on standardizing post-quantum algorithms to ensure that our digital systems remain secure in a quantum-enabled future. The National Institute of Standards and Technology (NIST) is leading the effort to evaluate and standardize post-quantum cryptographic algorithms. Several promising algorithms have already been proposed and are undergoing evaluation.

In summary, post-quantum cryptography is crucial for securing data in a future where quantum computers could break traditional cryptographic methods. By developing and implementing quantum-resistant algorithms, we can ensure the confidentiality and integrity of digital communication, even in a world dominated by quantum computing.



                    © 2024 Athestia Application. All Rights Reserved. | Developed by Hafsa , Muhammad Asfiyan , Muhammad Amir , Muhammad Latif |
"""

        content_label = QLabel(content)
        content_label.setStyleSheet("color: white; font-size: 16px;")
        content_label.setFont(QFont("Arial", 14))
        content_label.setWordWrap(True)

        scroll_area = QScrollArea()
        scroll_area.setWidgetResizable(True)
        scroll_content = QWidget()
        scroll_layout = QVBoxLayout(scroll_content)
        scroll_layout.addWidget(content_label)
        scroll_area.setWidget(scroll_content)

        main_layout.addWidget(scroll_area)

        self.setLayout(main_layout)

    def launch_home_window(self):
        self.main_window = SplashScreen()
        self.main_window.show()
        self.close()

    def launch_about_window(self):
        self.main_window = PQCWindow()
        self.main_window.show()
        self.close()


if __name__ == "__main__":
    os.makedirs("saved/ca_keys", exist_ok=True)
    os.makedirs("saved/ca_certs", exist_ok=True)
    os.makedirs("saved/consumer_keys", exist_ok=True)
    app = QApplication(sys.argv)
    window = SplashScreen()
    window.show()
    sys.exit(app.exec_())
