


# core/link.py

from core.node import ConsumerNode, ProducerNode, RouterNode, CertificateAuthorityNode
import uuid

class Link:
    """Simulates a link between two nodes in the NDN topology."""
    
    def __init__(self, node1, node2):
        self.id = str(uuid.uuid4())
        self.node1 = node1
        self.node2 = node2
        self.active = True

        # Add bidirectional connection
        self.node1.connect(self.node2)

    def transmit_packet(self, sender, packet):
        """Handles logic of Interest/Data packet going through the link."""

        receiver = self.node2 if sender == self.node1 else self.node1
        print(f"[Link] Transmitting {packet['type'].upper()} from {sender.name} to {receiver.name}")

        # CASE 1: Consumer sending Interest
        if isinstance(sender, ConsumerNode) and packet["type"] == "interest":
            receiver.handle_interest(packet, incoming=sender)

        # CASE 2: Router forwarding Interest
        elif isinstance(sender, RouterNode) and packet["type"] == "interest":
            receiver.handle_interest(packet, incoming=sender)

        # CASE 3: Producer sending Data
        elif isinstance(sender, ProducerNode) and packet["type"] == "data":
            receiver.handle_data(packet, incoming=sender)

        # CASE 4: Router forwarding Data
        elif isinstance(sender, RouterNode) and packet["type"] == "data":
            receiver.handle_data(packet, incoming=sender)


# Patching routers/producers/consumers with interest & data handlers dynamically
def attach_packet_handlers():
    def router_handle_interest(self, packet, incoming):
        name = packet["name"]

        # Check CS
        if name in self.cs:
            print(f"[{self.name}] Cache HIT for {name}. Sending data back.")
            data_packet = self.cs[name]
            for link_node in self.links:
                if link_node == incoming:
                    Link(self, link_node).transmit_packet(self, data_packet)
            return

        # Update PIT
        self.add_pit_entry(name, incoming)

        # Forward based on FIB
        next_hop = self.fib.get(name.split("/")[0], None)
        if next_hop:
            for link_node in self.links:
                if link_node.name == next_hop:
                    print(f"[{self.name}] Forwarding Interest to {next_hop}")
                    Link(self, link_node).transmit_packet(self, packet)
        else:
            print(f"[{self.name}] No FIB entry for {name}, dropping Interest.")

    def router_handle_data(self, self_router, packet, incoming):
        name = packet["name"]

        # Cache the data
        self_router.cache_data(packet)

        # Send to all pending PIT interfaces
        if name in self_router.pit:
            for dest in self_router.pit[name]:
                if dest != incoming:
                    Link(self_router, dest).transmit_packet(self_router, packet)
            del self_router.pit[name]

    def producer_handle_interest(self, self_producer, packet, incoming):
        name = packet["name"]
        data = self_producer.provide_content(name)

        if data:
            # Sign data and PK
            ca = next((n for n in self_producer.links if isinstance(n, CertificateAuthorityNode)), None)
            if ca and self_producer.sk:
                signed_pk = ca.sign_producer_key(self_producer.pk)
                signature = f"sig({data})_by_{self_producer.name}"
                data_packet = {
                    "type": "data",
                    "name": name,
                    "data": data,
                    "signature": signature,
                    "producer_pk": self_producer.pk,
                    "signed_producer_pk": signed_pk
                }
                Link(self_producer, incoming).transmit_packet(self_producer, data_packet)
            else:
                print(f"[{self_producer.name}] Missing CA or keys.")

    def consumer_handle_data(self, self_consumer, packet, incoming):
        self_consumer.receive_data(packet)

    # Patch the methods
    RouterNode.handle_interest = router_handle_interest
    RouterNode.handle_data = router_handle_data
    ProducerNode.handle_interest = producer_handle_interest
    ConsumerNode.handle_data = consumer_handle_data

# Call this function after node classes are initialized
attach_packet_handlers()