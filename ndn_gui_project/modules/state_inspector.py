from PyQt5.QtWidgets import QDialog, QTabWidget, QVBoxLayout, QTableWidget, QTableWidgetItem, QHeaderView, QPushButton, QHBoxLayout, QLabel
import os
import pickle
import json

class StateInspectorDialog(QDialog):
    def __init__(self, canvas, parent=None):
        super().__init__(parent)
        self.canvas = canvas
        self.setWindowTitle("Saved States and Router Tables")
        self.setMinimumWidth(800)
        self.setMinimumHeight(600)
        layout = QVBoxLayout(self)

        # Saved Files Table
        saved_files = self.get_saved_files()
        files_table = QTableWidget()
        files_table.setColumnCount(2)
        files_table.setHorizontalHeaderLabels(["File Path", "Type"])
        files_table.horizontalHeader().setSectionResizeMode(QHeaderView.Stretch)
        files_table.setRowCount(len(saved_files))
        for i, (path, type_) in enumerate(saved_files):
            files_table.setItem(i, 0, QTableWidgetItem(path))
            files_table.setItem(i, 1, QTableWidgetItem(type_))
        layout.addWidget(files_table)

        # Router Tables
        routers = [c for c in canvas.components if c.component_type == "Router"]
        for router in routers:
            def add_table(label, data, col_headers):
                group = QTableWidget()
                group.setColumnCount(len(col_headers))
                group.setHorizontalHeaderLabels(col_headers)
                group.horizontalHeader().setSectionResizeMode(QHeaderView.Stretch)
                group.setRowCount(len(data))
                for i, row in enumerate(data):
                    for j, h in enumerate(col_headers):
                        item = QTableWidgetItem(str(row[h.lower()]))
                        group.setItem(i, j, item)
                layout.addWidget(QLabel(f"{router.name}: {label}"))
                layout.addWidget(group)

            add_table("Content Store (CS)", router.router_table.cs, ["Name", "Data"])
            add_table("Pending Interest Table (PIT)", router.router_table.pit, ["Name", "Incoming_Interface"])
            add_table("Forwarding Info Base (FIB)", router.router_table.fib, ["Name", "Outgoing_Interface"])

        # Buttons
        buttons = QHBoxLayout()
        buttons.addStretch()
        close_button = QPushButton("Close")
        close_button.clicked.connect(self.accept)
        buttons.addWidget(close_button)
        layout.addLayout(buttons)

    def get_saved_files(self):
        saved_files = []
        folders = [
            ("saved/ca_keys", "CA Key"),
            ("saved/ca_certs", "CA Certificate"),
            ("saved/consumer_keys", "Consumer Key"),
            ("saved/producer_keys", "Producer Key"),
            ("saved/producer_certs", "Producer Certificate"),
            ("saved/producer_data_sigs", "Data Signature"),
            ("saved/router_cs", "Router CS"),
            ("saved/consumer_verification", "Verification Result")
        ]
        for folder, type_ in folders:
            if os.path.exists(folder):
                for file in os.listdir(folder):
                    saved_files.append((os.path.join(folder, file), type_))
        return saved_files