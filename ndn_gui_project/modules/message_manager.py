from PyQt5.QtCore import QTimer
from PyQt5.QtWidgets import QApplication

class MessageManager:
    def __init__(self, component):
        self.component = component
        self.active_timers = []

    def show_message(self, text, duration_ms=0, color="green"):
        # Clear any existing timers
        self.clear_timers()

        # Set and show the message
        self.component.message_label.setText(text)
        self.component.message_label.setStyleSheet(
            f"background: white; color: {color}; border-radius: 3px;"
        )
        self.component.message_label.show()
        QApplication.processEvents()

        # Set a timer to hide the message if duration is specified
        if duration_ms > 0:
            timer = QTimer()
            timer.setSingleShot(True)
            timer.timeout.connect(self.hide_message)
            timer.start(duration_ms)
            self.active_timers.append(timer)

    def hide_message(self):
        self.component.message_label.hide()
        self.clear_timers()
        QApplication.processEvents()

    def clear_timers(self):
        for timer in self.active_timers:
            if timer.isActive():
                timer.stop()
        self.active_timers.clear()