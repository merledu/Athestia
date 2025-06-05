import os
import pickle
from PyQt5.QtCore import Qt, QTimer, QEventLoop
from PyQt5.QtWidgets import QApplication, QLabel
from PyQt5.QtGui import QPixmap, QFont
from modules.interest_packet import InterestPacket
from modules.router_tables import build_topology_graph, bfs_shortest_path
from Dilithium import *
from modules.message_manager import MessageManager
from modules.vivado_interface import VivadoInterface

def sleep_with_events(ms):
    """Pause execution while processing GUI events."""
    loop = QEventLoop()
    QTimer.singleShot(ms, loop.quit)
    loop.exec_()

def fetch_ca_certificate(canvas, consumer, cert_name):
    """Generate an interest packet to fetch a CA certificate from the NDN Repository."""
    # Find NDN Repository
    ndn_repo = next((c for c in canvas.components if c.component_type == "NDN Repo"), None)
    if not ndn_repo:
        return None, "No NDN Repository found in topology."

    # Ensure NDN Repo has MessageManager
    if not hasattr(ndn_repo, 'message_manager'):
        ndn_repo.message_manager = MessageManager(ndn_repo)

    # Create interest packet
    packet_id = canvas.interest_packet_counter
    canvas.interest_packet_counter += 1
    packet = InterestPacket(packet_id, cert_name, canvas)
    if not hasattr(consumer, "interest_packets"):
        consumer.interest_packets = []
    consumer.interest_packets.append(packet)

    # Show message
    consumer.message_manager.show_message("Generating interest for certificate...")
    QApplication.processEvents()
    sleep_with_events(1000)

    # Check if NDN Repository is directly connected to the consumer
    if ndn_repo in consumer.connected_components:
        # Direct connection: Animate directly to NDN Repository
        # base_path = os.path.dirname(os.path.abspath(__file__))
        # image_path_pac = os.path.join(base_path, 'assets/packet.png')

        base_path = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
        image_path_pac = os.path.join(base_path, 'assets', 'packet.png')

        canvas.animate_icon_along_link(consumer, ndn_repo, image_path_pac, slow_ms=800)
    else:
        # Fallback to BFS path
        graph, name_to_comp = build_topology_graph(canvas.components)
        path = bfs_shortest_path(graph, consumer.name, ndn_repo.name)

        if not path or len(path) < 2:
            return None, "No path to NDN Repository."

        prev_node = consumer.name
        for idx in range(1, len(path)):
            curr_node = path[idx]
            curr_comp = name_to_comp[curr_node]
            prev_comp = name_to_comp[prev_node]
            # base_path = os.path.dirname(os.path.abspath(__file__))
            # image_path_pac = os.path.join(base_path, 'assets/packet.png')

            base_path = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
            image_path_pac = os.path.join(base_path, 'assets', 'packet.png')

            canvas.animate_icon_along_link(prev_comp, curr_comp, image_path_pac, slow_ms=800)
            prev_node = curr_node

    # NDN Repository processes the interest
    ndn_repo.message_manager.show_message("Finding certificate...")
    QApplication.processEvents()
    sleep_with_events(1000)

    # Find certificate by matching CA name in cert_name
    ca_name = cert_name.split('/')[-2]
    cert = next((c for c in canvas.ndn_repo_certs if c["name"].startswith(f"/{ca_name}/")), None)
    if not cert:
        ndn_repo.message_manager.show_message("Certificate not found!", duration_ms=3000)
        QApplication.processEvents()
        sleep_with_events(1000)
        return None, "Certificate not found in NDN Repository."

    ndn_repo.message_manager.show_message("Certificate found!", duration_ms=3000)
    QApplication.processEvents()
    sleep_with_events(1000)

    # Create data packet-like structure
    cert_packet = {
        "id": packet_id + 1000,
        "name": cert_name,
        "data": cert,
        "signature": None,
        "producer_cert": None
    }

    # Traverse back to consumer (direct connection)
    if ndn_repo in consumer.connected_components:
        # base_path = os.path.dirname(os.path.abspath(__file__))
        # image_path_pac = os.path.join(base_path, 'assets/packet.png')

        base_path = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
        image_path_pac = os.path.join(base_path, 'assets', 'packet.png')

        canvas.animate_icon_along_link(ndn_repo, consumer, image_path_pac, slow_ms=800)
    else:
        # Fallback to BFS path
        path.reverse()
        prev_node = ndn_repo.name
        for idx in range(1, len(path)):
            curr_node = path[idx]
            curr_comp = name_to_comp[curr_node]
            prev_comp = name_to_comp[prev_node]
            # base_path = os.path.dirname(os.path.abspath(__file__))
            # image_path_pac = os.path.join(base_path, 'assets/packet.png')

            base_path = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
            image_path_pac = os.path.join(base_path, 'assets', 'packet.png')

            canvas.animate_icon_along_link(prev_comp, curr_comp, image_path_pac, slow_ms=800)
            prev_node = curr_node

    # Store certificate on consumer
    if not hasattr(consumer, "fetched_certificates"):
        consumer.fetched_certificates = []
    consumer.fetched_certificates.append(cert_packet)
    consumer.message_manager.show_message("Certificate received!")
    QApplication.processEvents()
    sleep_with_events(1000)

    # Save to backend
    os.makedirs("saved/consumer_verification", exist_ok=True)
    safe_name = cert_name.replace('/', '_')
    try:
        with open(f"saved/consumer_verification/{consumer.name}_cert_{safe_name}.pkl", "wb") as f:
            pickle.dump(cert_packet, f)
    except Exception as e:
        consumer.message_manager.show_message(f"Save error: {str(e)}")
        QApplication.processEvents()
        sleep_with_events(1000)
    return cert_packet, None

def verify_signatures(canvas, consumer, data_packet):
    """Verify producer's PK and data signature, fetching CA certificates if needed."""
    verification_results = []
    ca_count = sum(1 for c in canvas.components if c.component_type == "CA")
    producer_cert = data_packet["producer_cert"]
    data_sig = data_packet["signature"]
    data_content = data_packet["data"]
    cert_name = producer_cert["cert_name"]  # e.g., '/youtube/KEY/441/video-ca/003'

    # Determine CA from certificate name
    ca_name = cert_name.split('/')[-2]  # e.g., 'video-ca'
    is_root_ca = ca_name == "root-ca"

    if ca_count > 1 and not is_root_ca:
        # Initialize CA certificate cache if it doesn’t exist
        if not hasattr(consumer, 'ca_certificate_cache'):
            consumer.ca_certificate_cache = {}

        # Check if CA certificate is already cached
        if ca_name in consumer.ca_certificate_cache:
            ca_cert = consumer.ca_certificate_cache[ca_name]
            consumer.message_label.setText(f"Using cached {ca_name} certificate...")
            consumer.message_label.show()
            QApplication.processEvents()
            sleep_with_events(1000)
        else:
            # Fetch CA certificate if not cached
            consumer.message_label.setText(f"Fetching {ca_name} certificate...")
            consumer.message_label.show()
            QApplication.processEvents()
            sleep_with_events(1000)

            cert_packet, error = fetch_ca_certificate(canvas, consumer, cert_name)
            if error:
                consumer.message_label.setText(error)
                consumer.message_label.show()
                QApplication.processEvents()
                sleep_with_events(1000)
                return [{"step": "Fetch CA Certificate", "result": False, "message": error}]

            # Store the CA certificate in the cache
            ca_cert = cert_packet["data"]
            consumer.ca_certificate_cache[ca_name] = ca_cert
            consumer.message_label.setText(f"Fetched and cached {ca_name} certificate...")
            consumer.message_label.show()
            QApplication.processEvents()
            sleep_with_events(1000)

        ca_pk = ca_cert["pk"]
        ca_signature = ca_cert["signature"]

        # Verify subordinate CA’s PK using root CA’s PK
        consumer.message_label.setText(f"Verifying {ca_name} PK...")
        consumer.message_label.show()
        QApplication.processEvents()
        sleep_with_events(1000)
        root_ca_pk = consumer.installed_pk
        canvas_mode = getattr(canvas, 'mode', 'simulation')
        if canvas_mode == "simulation":
            ca_verify_result = verify(root_ca_pk, ca_pk, ca_signature)
        else:
            vivado = VivadoInterface()
            ca_verify_result = vivado.run_verify(root_ca_pk, ca_pk, ca_signature)
        verification_results.append({
            "step": f"Verify {ca_name} PK",
            "result": ca_verify_result,
            "message": f"{ca_name} PK verification: {'True' if ca_verify_result else 'False'}"
        })
        consumer.message_label.setText(f"{ca_name} PK: {'True' if ca_verify_result else 'False'}")
        consumer.message_label.setStyleSheet(
            f"background: white; color: {'green' if ca_verify_result else 'green'}; border-radius: 3px;"
        )
        consumer.message_label.show()
        QApplication.processEvents()
        sleep_with_events(1000)
        if not ca_verify_result:
            return verification_results
    else:
        # Single-CA: Use installed root CA PK
        ca_pk = consumer.installed_pk

    # Verify producer’s PK
    consumer.message_label.setText("Verifying Producer PK...")
    consumer.message_label.show()
    QApplication.processEvents()
    sleep_with_events(1000)
    producer_pk = producer_cert["pk"]
    producer_signature = producer_cert["signature"]
    canvas_mode = getattr(canvas, 'mode', 'simulation')
    if canvas_mode == "simulation":
        producer_verify_result = verify(ca_pk, producer_pk, producer_signature)
    else:
        vivado = VivadoInterface()
        producer_verify_result = vivado.run_verify(ca_pk, producer_pk, producer_signature)

    verification_results.append({
        "step": "Verify Producer PK",
        "result": producer_verify_result,
        "message": f"Producer PK verification: {'True' if producer_verify_result else 'False'}"
    })
    consumer.message_label.setText(f"Producer PK: {'True' if producer_verify_result else 'False'}")
    consumer.message_label.setStyleSheet(
        f"background: white; color: {'green' if producer_verify_result else 'green'}; border-radius: 3px;"
    )
    consumer.message_label.show()
    QApplication.processEvents()
    sleep_with_events(1000)

    if not producer_verify_result:
        return verification_results

    # Verify data signature
    consumer.message_label.setText("Verifying Data...")
    consumer.message_label.show()
    QApplication.processEvents()
    sleep_with_events(1000)
    canvas_mode = getattr(canvas, 'mode', 'simulation')
    if canvas_mode == "simulation":
        data_verify_result = verify(producer_pk, data_content.encode().hex(), data_sig["signature"])
    else:
        vivado = VivadoInterface()
        data_verify_result = vivado.run_verify(producer_pk, data_content.encode().hex(), data_sig["signature"])

    verification_results.append({
        "step": "Verify Data",
        "result": data_verify_result,
        "message": f"Data verification: {'True' if data_verify_result else 'False'}"
    })
    consumer.message_label.setText(f"Data: {'True' if data_verify_result else 'False'}")
    consumer.message_label.setStyleSheet(
        f"background: white; color: {'green' if data_verify_result else 'green'}; border-radius: 3px;"
    )
    consumer.message_label.show()
    QApplication.processEvents()
    sleep_with_events(1000)

    # Display content icon if data verification succeeds
    if data_verify_result:
        producer_name = data_packet["name"].split('/')[1].lower()
        # base_path = os.path.dirname(os.path.abspath(__file__))
        # image_path_yt = os.path.join(base_path, 'assets/youtube.jpeg') 
        # image_path_sp = os.path.join(base_path, 'assets/spotify.png')   
        # image_path_me = os.path.join(base_path, 'assets/medium.png')   
        # image_path_ki = os.path.join(base_path, 'assets/kindle.jpg')   
        # image_path_st = os.path.join(base_path, 'assets/steam.png')   
        # image_path_gm = os.path.join(base_path, 'assets/gmail.png')   
        # image_path_re = os.path.join(base_path, 'assets/reddit.png')   
        # image_path_cour = os.path.join(base_path, 'assets/coursera.png')   
        # image_path_canv = os.path.join(base_path, 'assets/canva.jpeg')   
        # image_path_ins = os.path.join(base_path, 'assets/instagram.jpg')   

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

        icon_map = {
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
        base_path = os.path.dirname(os.path.abspath(__file__))
        image_path_dp = os.path.join(base_path, 'assets/data_packet.jpeg')
        icon_path = icon_map.get(producer_name, image_path_dp)
        content_icon = QLabel(consumer)
        content_icon.setPixmap(QPixmap(icon_path).scaled(24, 24, Qt.KeepAspectRatio))
        content_icon.move(consumer.width() - 28, 0)  # Top-right corner
        content_icon.show()
        if not hasattr(consumer, "content_icons"):
            consumer.content_icons = []
        consumer.content_icons.append(content_icon)
        consumer.message_label.setText("Content opened!")
        consumer.message_label.setStyleSheet("background: white; color: green; border-radius: 3px;")
        consumer.message_label.show()
        QApplication.processEvents()
        sleep_with_events(1000)

    # Save verification results
    if not hasattr(consumer, "verification_results"):
        consumer.verification_results = []
    consumer.verification_results.extend(verification_results)
    os.makedirs("saved/consumer_verification", exist_ok=True)
    try:
        with open(f"saved/consumer_verification/{consumer.name}_verification_{data_packet['id']}.pkl", "wb") as file:
            pickle.dump(verification_results, file)
    except Exception as e:
        consumer.message_label.setText(f"Save error: {str(e)}")
        consumer.message_label.show()
        QApplication.processEvents()
        sleep_with_events(1000)

    return verification_results