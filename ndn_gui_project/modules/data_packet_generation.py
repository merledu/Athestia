from PyQt5.QtCore import Qt, QPoint, QEventLoop, QTimer
from PyQt5.QtWidgets import QApplication, QLabel, QMessageBox, QHBoxLayout, QWidget
from PyQt5.QtGui import QPixmap, QFont
from time import sleep
import os
import pickle
from PyQt5.QtWidgets import QDialog, QVBoxLayout, QLabel, QPushButton, QTextEdit, QHBoxLayout
from PyQt5.QtGui import QPixmap, QFont
from PyQt5.QtCore import Qt
from modules.message_manager import MessageManager
from modules.vivado_interface import VivadoInterface

# Import Dilithium and router tables as before
from Dilithium import generate_keypair, sign
from modules.router_tables import build_topology_graph, bfs_shortest_path

def sleep_with_events(ms):
    loop = QEventLoop()
    QTimer.singleShot(ms, loop.quit)
    loop.exec_()

def animate_icon_along_link(canvas, start_comp, end_comp, icon_path, slow_ms=800):
    label = QLabel(canvas)
    pixmap = QPixmap(icon_path).scaled(20, 20, Qt.KeepAspectRatio)
    label.setPixmap(pixmap)
    label.show()
    start_pos = start_comp.pos() + QPoint(start_comp.width()//2, start_comp.height()//2)
    end_pos = end_comp.pos() + QPoint(end_comp.width()//2, end_comp.height()//2)
    progress = 0.0
    while progress < 1.0:
        progress += 0.02
        nx = start_pos.x() + (end_pos.x() - start_pos.x()) * progress
        ny = start_pos.y() + (end_pos.y() - start_pos.y()) * progress
        label.move(int(nx - label.width()/2), int(ny - label.height()/2))
        QApplication.processEvents()
        sleep(0.03)
    label.hide()
    label.deleteLater()

def find_relevant_ca(canvas, producer):
    # Returns CA component based on topology and PRODUCER_TO_CA mapping
    ca_components = [c for c in canvas.components if c.component_type == "CA"]
    if len(ca_components) == 1:
        return ca_components[0]  # root CA only
    # Multiple CAs, find subordinate CA relevant to producer
    expected_ca_name = canvas.PRODUCER_TO_CA.get(producer.name)
    for ca in ca_components:
        if ca.name == expected_ca_name:
            return ca
    return None
def generate_producer_keys(canvas, producer):
    if not hasattr(producer, 'message_manager'):
        producer.message_manager = MessageManager(producer)
    producer.message_manager.show_message("Generating keys...")
    # Generate keys with unique IDs
    key_id_pk = 441
    key_id_sk = 442

    canvas_mode = getattr(canvas, 'mode', 'simulation')
    if canvas_mode == "simulation":
        keypair = generate_keypair(str(key_id_pk))
    else:
        vivado = VivadoInterface()
        keypair = vivado.run_keygen(str(key_id_pk))
    producer.ca_keys = keypair
    os.makedirs("saved/producer_keys", exist_ok=True)
    with open(f"saved/producer_keys/{producer.name}_pk.txt", "w") as f:
        f.write(keypair['pk'])
    with open(f"saved/producer_keys/{producer.name}_sk.txt", "w") as f:
        f.write(keypair['sk'])
    if hasattr(producer, 'key_icon'):
        producer.key_icon.show()
    else:
        key_icon = QLabel(producer)

        base_path = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
        image_path_key = os.path.join(base_path, 'assets', 'key.png')
        key_icon.setPixmap(QPixmap(image_path_key).scaled(18, 18, Qt.KeepAspectRatio))
        key_icon.move(0, 0)
        key_icon.show()
        producer.key_icon = key_icon
    producer.name_label.setText(f"{producer.name}\nKeys generated\nPK:{key_id_pk} SK:{key_id_sk}")
    producer.message_manager.show_message("Keys generated")
    QApplication.processEvents()
    sleep(1.5)
    return keypair, key_id_pk, key_id_sk

def sign_producer_pk(canvas, producer, ca, key_id_pk):
    if not hasattr(producer, 'message_manager'):
        producer.message_manager = MessageManager(producer)
    if not hasattr(ca, 'message_manager'):
        ca.message_manager = MessageManager(ca)
    producer.message_manager.show_message("Sending PK to CA...")

    base_path = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    image_path_key = os.path.join(base_path, 'assets', 'key.png')
    canvas.animate_icon_along_link(producer, ca, image_path_key, slow_ms=900)
    ca.message_manager.show_message("Signing Producer PK...")
    QApplication.processEvents()
    sleep(1.2)
    
    canvas_mode = getattr(canvas, 'mode', 'simulation')
    if canvas_mode == "simulation":
        sig = sign(ca.ca_keys['sk'], producer.ca_keys['pk'], str(key_id_pk))
    else:
        vivado = VivadoInterface(operation="sign")
        sig = vivado.run_sign(ca.ca_keys['sk'], producer.ca_keys['pk'], str(key_id_pk))

    cert_name = f"/{producer.name}/KEY/{key_id_pk}/{ca.name}/" + str(hash(sig['signature']) % 1000).zfill(3)
    if not hasattr(ca, 'producer_certificates'):
        ca.producer_certificates = {}
    ca.producer_certificates[producer.name] = {
        "signature": sig['signature'],
        "sig_id": sig['sig_id'],
        "cert_name": cert_name
    }
    ca.message_manager.show_message("Certificate generated")
    cert_icon = QLabel(ca)
    
    base_path = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    image_path_cer = os.path.join(base_path, 'assets', 'certificate.jpg')
    cert_icon.setPixmap(QPixmap(image_path_cer).scaled(18, 18, Qt.KeepAspectRatio))
    cert_icon.move(ca.width()-20, 22)
    cert_icon.show()
    ca.cert_icon = cert_icon
    QApplication.processEvents()
    sleep(1.5)
    ca.message_manager.hide_message()
    ca.cert_icon.hide()
  
    base_path = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    image_path_cer = os.path.join(base_path, 'assets', 'certificate.jpg')
    canvas.animate_icon_along_link(ca, producer, image_path_cer, slow_ms=1000)
    producer.name_label.setText(f"{producer.name}\nCert received")
    producer.message_manager.show_message("Certificate received")
    producer.producer_certificate = {
        "pk": producer.ca_keys['pk'],
        "signature": sig['signature'],
        "sig_id": sig['sig_id'],
        "cert_name": cert_name
    }
    os.makedirs("saved/producer_certs", exist_ok=True)
    with open(f"saved/producer_certs/{producer.name}_cert.pkl", "wb") as f:
        pickle.dump(producer.producer_certificate, f)
    QApplication.processEvents()
    sleep(1.5)
    return producer.producer_certificate

def sign_data(canvas, producer, data):
    if not hasattr(producer, 'message_manager'):
        producer.message_manager = MessageManager(producer)
    producer.message_manager.show_message("Signing data...")
    QApplication.processEvents()
    sleep(1.0)

    canvas_mode = getattr(canvas, 'mode', 'simulation')
    if canvas_mode == "simulation":
        sig = sign(producer.ca_keys['sk'], data.encode().hex(), str(hash(data) % 1000))
    else:
        vivado = VivadoInterface(operation="sign")
        sig = vivado.run_sign(producer.ca_keys['sk'], data.encode().hex(), str(hash(data) % 1000))

    if not hasattr(producer, 'data_signatures'):
        producer.data_signatures = []
    sig_record = {
        "signature": sig['signature'],
        "sig_id": sig['sig_id'],
        "data": data
    }
    producer.data_signatures.append(sig_record)
    os.makedirs("saved/producer_data_sigs", exist_ok=True)
    with open(f"saved/producer_data_sigs/{producer.name}_data_sig_{sig['sig_id']}.pkl", "wb") as f:
        pickle.dump(sig_record, f)
    producer.message_manager.show_message("Data signed")
    QApplication.processEvents()
    sleep(1.5)
    return sig_record

class DataPacketIcon(QLabel):
    def __init__(self, canvas, component, packet_info):
        super().__init__(canvas)
        self.canvas = canvas
        self.component = component  # Changed from producer to component
        self.packet_info = packet_info  # dictionary with all 7 fields

        base_path = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
        image_path_dp = os.path.join(base_path, 'assets', 'data_packet.jpeg')
        self.setPixmap(QPixmap(image_path_dp).scaled(32, 32, Qt.KeepAspectRatio))
        self.setToolTip("Double-click to view Data Packet details")
        self.setCursor(Qt.PointingHandCursor)
        self.show()

        # Position the icon to the left of the component
        self.update_position()

    def update_position(self):
        if self.component.component_type == "Consumer":
            new_x = self.component.x() + 5  # Slightly offset from the left edge
            new_y = self.component.y() + 5  # Slightly offset from the top edge
        else:
            new_x = self.component.x() - self.width() - 5
            new_y = self.component.y() + (self.component.height() - self.height()) // 2
        self.move(new_x, new_y)
        
    def mouseDoubleClickEvent(self, event):
        # Extract producer name from the packet name (e.g., /youtube/poem/cocomelon -> youtube)
        producer_name = self.packet_info['name'].split('/')[1].lower() if len(self.packet_info['name'].split('/')) > 1 else '' 
        base_path = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
        image_path_yt = os.path.join(base_path, 'assets', 'youtube.jpeg')
        image_path_sp = os.path.join(base_path, 'assets', 'spotify.png')
        image_path_me = os.path.join(base_path, 'assets', 'medium.png')
        image_path_ki = os.path.join(base_path, 'assets', 'kindle.jpg')
        image_path_st = os.path.join(base_path, 'assets', 'steam.png')
        image_path_gm = os.path.join(base_path, 'assets', 'gmail.png')
        image_path_re = os.path.join(base_path, 'assets', 'reddit.png')
        image_path_cour = os.path.join(base_path, 'assets', 'coursera.png')
        image_path_canv = os.path.join(base_path, 'assets', 'canva.jpeg')
        image_path_ins = os.path.join(base_path, 'assets', 'instagram.jpg')
        producer_icon_map = {
            "youtube": image_path_yt,
            "spotify": image_path_sp,
            "medium": image_path_me,
            "kindle": image_path_ki,
            "steam": image_path_st,
            "gmail": image_path_gm,
            "reddit": image_path_re,
            "coursera": image_path_cour,
            "canva": image_path_canv,
            "instagram": image_path_ins
        }
        base_path = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
        image_path_dp = os.path.join(base_path, 'assets', 'data_packet.jpeg')
        icon_path = producer_icon_map.get(producer_name, image_path_dp)  # Fallback to data packet icon

        # Create a custom dialog with an icon in the heading
        dlg = QDialog(self.canvas)
        dlg.setWindowTitle("Data Packet Details")
        dlg.setMinimumWidth(500)
        dlg.setMinimumHeight(400)

        layout = QVBoxLayout(dlg)

        header_layout = QHBoxLayout()
        icon_label = QLabel()
        icon_label.setPixmap(QPixmap(icon_path).scaled(32, 32, Qt.KeepAspectRatio))
        header_layout.addWidget(icon_label)

        title_label = QLabel(f"{self.component.name} Data Packet")
        title_label.setFont(QFont("Arial", 12, QFont.Bold))
        header_layout.addWidget(title_label)
        header_layout.addStretch()
        layout.addLayout(header_layout)

        # Add packet details
        def add_clickable_label(title, full_text):
            def truncate_text(text, length=40):
                return text if len(text) <= length else text[:length] + "..."

            lbl_title = QLabel(f"<b>{title}:</b>")
            layout.addWidget(lbl_title)

            truncated = truncate_text(full_text)
            label = QLabel(truncated)
            label.setStyleSheet("background-color: #f0f0f0; padding: 5px; border-radius: 3px; font-family: monospace;")
            label.setCursor(Qt.PointingHandCursor)
            label.setToolTip("Click to view full content")
            label.setTextInteractionFlags(Qt.TextSelectableByMouse)

            label.full_text = full_text

            def on_label_click(event):
                sub_dlg = QDialog(dlg)
                sub_dlg.setWindowTitle(title + " - Full Content")
                sub_dlg.setMinimumWidth(700)
                sub_dlg.setMinimumHeight(300)

                sub_layout = QVBoxLayout(sub_dlg)
                text_edit = QTextEdit()
                text_edit.setReadOnly(True)
                text_edit.setPlainText(label.full_text)
                text_edit.setFontFamily("monospace")
                sub_layout.addWidget(text_edit)

                btn_copy = QPushButton("Copy to Clipboard")
                btn_close = QPushButton("Close")
                btn_copy.clicked.connect(lambda: QApplication.clipboard().setText(label.full_text))
                btn_close.clicked.connect(sub_dlg.accept)

                btn_layout = QHBoxLayout()
                btn_layout.addWidget(btn_copy)
                btn_layout.addStretch()
                btn_layout.addWidget(btn_close)
                sub_layout.addLayout(btn_layout)

                sub_dlg.exec_()

            label.mousePressEvent = on_label_click
            layout.addWidget(label)

        pi = self.packet_info

        add_clickable_label("ID", str(pi.get("id", "")))
        add_clickable_label("Name", pi.get("name", ""))
        add_clickable_label("Data", pi.get("data", ""))
        add_clickable_label("Data Signature", pi.get("signature", {}).get("signature", ""))
        add_clickable_label("Producer's Public Key", pi.get("producer_cert", {}).get("pk", ""))
        add_clickable_label("Signature on Producer's Public Key", pi.get("producer_cert", {}).get("signature", ""))
        add_clickable_label("Certificate Name", pi.get("producer_cert", {}).get("cert_name", ""))

        # Close button
        btn_close = QPushButton("Close")
        btn_close.clicked.connect(dlg.accept)
        layout.addWidget(btn_close, alignment=Qt.AlignRight)

        dlg.exec_()


def generate_data_packet(canvas, producer, interest_name):
    # Same as before: generate keys, sign PK, sign data
    keypair, pk_id, sk_id = generate_producer_keys(canvas, producer)
    ca = find_relevant_ca(canvas, producer)
    if not ca:
        QMessageBox.warning(canvas, "Error", "No relevant CA found for Producer.")
        return
    cert = sign_producer_pk(canvas, producer, ca, pk_id)
    data_map = {
        "YouTube": "YOUTUBE",
        "Spotify": "SPOTIFY",
        "Medium": "MEDIUM",
        "Kindle": "KINDLE",
        "Steam": "STEAM",
        "Gmail": "GMAIL",
        "Reddit": "REDDIT",
        "coursera": "COURSERA",
        "canva": "CANVA",
        "Instagram": "INSTAGRAM",
    }
    data_content = data_map.get(producer.name, "UNKNOWN")
    data_sig = sign_data(canvas, producer, data_content)

    dp_id = canvas.interest_packet_counter + 1000
    canvas.interest_packet_counter += 1

    packet_info = {
        "id": dp_id,
        "name": interest_name,
        "data": data_content,
        "signature": data_sig,
        "producer_cert": cert
    }

    # Remove previous Data Packet icon for this producer
    if hasattr(producer, "data_packet_icons"):
        for dp_icon in list(producer.data_packet_icons):
            if dp_icon in canvas.data_packets:
                canvas.data_packets.remove(dp_icon)
                dp_icon.hide()
                dp_icon.deleteLater()
        producer.data_packet_icons.clear()  # Clear GUI icons but retain other data

    # Create small Data Packet icon attached to producer
    dp_icon = DataPacketIcon(canvas, producer, packet_info)
    canvas.data_packets.append(dp_icon)

    # Keep reference for moving with producer
    if not hasattr(producer, "data_packet_icons"):
        producer.data_packet_icons = []
    producer.data_packet_icons.append(dp_icon)

    return dp_icon

def handle_interest_packet_reach_producer(canvas, producer, interest_name):
    # Called from main.py when Interest Packet traversal ends at Producer
    dp_icon = generate_data_packet(canvas, producer, interest_name)
    # Start data packet traversal back to consumer
    canvas.traverse_data_packet(producer, dp_icon)
