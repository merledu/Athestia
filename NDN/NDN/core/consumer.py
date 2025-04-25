
# core/consumer.py

from .packet import InterestPacket
from .dilithium_hw import verify


class Consumer:
    def __init__(self, name, ca_pk):
        self.name = name
        self.ca_pk = ca_pk
        self.received_data = None
        self.links = []
    
    def connect(self, node):
        self.links.append(node)
    
    def create_interest_packet(self, content_name):
        """
        Create an interest packet asking for content_name.
        """
        return InterestPacket(name=content_name, origin=self.name)

    def receive_data_packet(self, data_packet):
        """
        Handles incoming data packet:
        - Verifies producer's signed public key using CA public key
        - Verifies data using producer public key
        - On success, stores and prints the data
        """
        if not data_packet:
            print(f"[{self.name}] ❌ No data received.")
            return False

        name = data_packet["name"]
        data = data_packet["data"]
        signature = data_packet["signature"]
        producer_pk = data_packet["producer_pk"]
        producer_pk_signed = data_packet["producer_pk_signed"]

        print(f"[{self.name}] 🔐 Verifying producer's public key...")
        # Verify the producer's public key using CA's public key
        pk_valid = verify(producer_pk, producer_pk_signed, self.ca_pk)

        if not pk_valid:
            print(f"[{self.name}] ❌ Producer public key is NOT verified by CA.")
            return False

        print(f"[{self.name}] ✅ Producer public key verified!")

        print(f"[{self.name}] 🔐 Verifying signature on data...")
        # Verify the data signature using the producer's public key
        data_valid = verify(data, signature, producer_pk)

        if not data_valid:
            print(f"[{self.name}] ❌ Data signature verification failed.")
            return False

        print(f"[{self.name}] ✅ Data verified successfully.")
        self.received_data = (name, data)
        self._display_content(name, data)
        return True

    def _display_content(self, name, data):
        """
        Simulates displaying the content on the consumer's device.
        """
        print(f"\n📱 [{self.name}] Received content:")
        print(f"   - Name: {name}")
        print(f"   - Data: {data}\n")

    def request_content(self, content_name, first_router):
        """
        Request content by sending an interest packet to the first router.
        """
        interest_packet = self.create_interest_packet(content_name)
        print(f"[{self.name}] 📤 Sending Interest Packet for '{content_name}' to first router.")
        first_router.receive_interest_packet(interest_packet, None)  # No incoming interface needed here