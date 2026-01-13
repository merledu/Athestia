from PyQt5.QtWidgets import QWidget, QLabel, QVBoxLayout
from PyQt5.QtGui import QColor, QFont
from PyQt5.QtCore import Qt
import time

class InterestPacket(QWidget):
    def __init__(self, packet_id, name, parent=None):
        super().__init__(parent)
        self.packet_id = packet_id
        self.name = name
        self.setFixedSize(170, 100)
        # Set border/background for the whole box, not per label
        self.setStyleSheet("background: #e3f2fd; border: 2px solid #1976d2; border-radius: 8px;")
        
        layout = QVBoxLayout(self)
        layout.setContentsMargins(8, 6, 8, 6)
        layout.setSpacing(2)

        title = QLabel("Interest Packet")
        title.setFont(QFont("Arial", 9, QFont.Bold))
        title.setStyleSheet("color: #1976d2; background: transparent;")
        layout.addWidget(title)

        self.id_label = QLabel(f"ID: {self.packet_id}")
        self.name_label = QLabel(f"Name: {self.name}")
        for label in [self.id_label, self.name_label]:
            label.setFont(QFont("Arial", 8))
            label.setWordWrap(True)
            label.setStyleSheet("background: transparent; color: #222;")
            layout.addWidget(label)

def generate_packet_id():
    return int(time.time() * 1000)  # Unique ID based on timestamp
