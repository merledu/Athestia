from PyQt5.QtWidgets import QApplication, QLabel
from PyQt5.QtGui import QPixmap
from PyQt5.QtCore import Qt
from modules.data_packet_generation import DataPacketIcon
from modules.consumer_verification import verify_signatures
import os
import pickle
from modules.message_manager import MessageManager

def sleep_with_events(ms):
    """Pause execution while processing GUI events."""
    from PyQt5.QtCore import QEventLoop, QTimer
    loop = QEventLoop()
    QTimer.singleShot(ms, loop.quit)
    loop.exec_()

def retrieve_data_from_router(canvas, router, consumer, data_packet, interest_name):
    """Retrieve a data packet from a router's CS and send it back to the consumer."""
    if not hasattr(router, 'message_manager'):
        router.message_manager = MessageManager(router)
    if not hasattr(consumer, 'message_manager'):
        consumer.message_manager = MessageManager(consumer)
    
    # Show message on router
    router.message_manager.show_message("Data found in CS!", color="green")
    QApplication.processEvents()
    sleep_with_events(1000)

    # Find path back to consumer
    from modules.router_tables import build_topology_graph, bfs_shortest_path
    graph, name_to_comp = build_topology_graph(canvas.components)
    path = bfs_shortest_path(graph, router.name, consumer.name)
    if not path or len(path) < 2:
        from PyQt5.QtWidgets import QMessageBox
        QMessageBox.warning(canvas, "Path Error", "No path found back to Consumer.")
        return

    # Traverse data packet back to consumer
    prev_node = router.name
    for idx in range(1, len(path)):
        curr_node = path[idx]
        curr_comp = name_to_comp[curr_node]
        prev_comp = name_to_comp[prev_node]

        # Animate data packet movement
        base_path = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
        image_path_pac = os.path.join(base_path, 'assets', 'packet.png')
        
        canvas.animate_icon_along_link(prev_comp, curr_comp, image_path_pac, slow_ms=800)
        
        if curr_comp.component_type == "Router":
            # Update router tables
            rtab = curr_comp.router_table
            if not hasattr(curr_comp, 'message_manager'):
                curr_comp.message_manager = MessageManager(curr_comp)
            curr_comp.message_manager.show_message("Checking router tables...")
            QApplication.processEvents()
            sleep_with_events(800)

            # Add to CS if not present
            if not rtab.get_cs(data_packet['name']):
                rtab.add_cs(data_packet['name'], data_packet)
                curr_comp.message_manager.show_message("Updating CS...")
                QApplication.processEvents()
                sleep_with_events(800)
                # Save to backend
                os.makedirs("saved/router_cs", exist_ok=True)
                safe_name = data_packet['name'].replace('/', '_')
                with open(f"saved/router_cs/{curr_comp.name}_cs_{safe_name}.pkl", "wb") as f:
                    pickle.dump(data_packet, f)
                curr_comp.message_manager.show_message("CS updated successfully!")
                QApplication.processEvents()
                sleep_with_events(800)

            # Update PIT
            pit_entry = next((entry for entry in rtab.pit if entry['name'] == data_packet['name']), None)
            if pit_entry:
                rtab.remove_pit(data_packet['name'])
                curr_comp.message_manager.show_message("Updating PIT...")
                QApplication.processEvents()
                sleep_with_events(800)

            curr_comp.message_manager.hide_message()
        
        prev_node = curr_node

    # Data packet reaches consumer
    consumer.message_manager.show_message("Data packet received!")
    QApplication.processEvents()
    sleep_with_events(1200)

    # Add data packet icon
    dp_icon = DataPacketIcon(canvas, consumer, data_packet)
    dp_icon.setParent(canvas)
    dp_icon.show()
    if not hasattr(consumer, "data_packet_icons"):
        consumer.data_packet_icons = []
    consumer.data_packet_icons.append(dp_icon)
    canvas.data_packets.append(dp_icon)
    consumer.message_manager.show_message("Data packet displayed!")
    QApplication.processEvents()
    sleep_with_events(800)

    # Start verification process
    if not canvas.paused:
        verify_signatures(canvas, consumer, data_packet)
    else:
        while canvas.paused:
            QApplication.processEvents()
            sleep_with_events(100)
        verify_signatures(canvas, consumer, data_packet)

    consumer.message_manager.hide_message()