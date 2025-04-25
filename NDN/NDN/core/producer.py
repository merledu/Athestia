# core/producer.py

from .dilithium_hw import generate_keys, sign
from .ca import CertificateAuthority


class Producer:
    def __init__(self, name, ca: CertificateAuthority):
        self.name = name  # E.g., "YouTube", "Blog", "Netflix"
        self.ca = ca
        self.links = []

        # Generate keys
        self.pk, self.sk = generate_keys()

        # CA signs the Producer's public key
        self.pk_signed_by_ca = self.ca.sign_producer_pk(self.pk)

        # Store some sample content
        self.data_store = self._load_content()

    def connect(self, node):
        self.links.append(node)    

    def _load_content(self):
        """
        Returns sample content the producer serves.
        Keys are name paths, values are plain data.
        """
        if self.name.lower() == "youtube":
            return {
                "/youtube/video/2025/1": "Welcome to 2025 YouTube Highlights",
                "/youtube/video/ai/intro": "Introduction to AI for Students",
            }
        elif self.name.lower() == "netflix":
            return {
                "/netflix/movie/action": "High-Speed Action Movie HD",
                "/netflix/show/space": "Space Adventures Season 2",
            }
        elif self.name.lower() == "blog":
            return {
                "/blog/tech/2025": "Top 5 Tech Trends in 2025",
                "/blog/life/motivation": "How to Stay Motivated in College",
            }
        elif self.name.lower() == "food":
            return {
                "/food/recipe/pasta": "Creamy Garlic Pasta Recipe",
                "/food/recipe/sweets": "3 Quick Sweet Dishes at Home",
            }
        elif self.name.lower() == "scholar":
            return {
                "/scholar/research/ai": "Latest AI Research Papers",
                "/scholar/thesis/security": "Post-Quantum Security Thesis Summary",
            }
        else:
            return {
                f"/{self.name.lower()}/default": f"Default content for {self.name}"
            }

    def get_signed_data_packet(self, name):
        """
        Generates a signed data packet if the content is available.
        """
        if name in self.data_store:
            data = self.data_store[name]
            # Sign the content data using the producer's private key
            signature = sign(data, self.sk)

            # Prepare the data packet with name, data, signature, and signed producer's public key
            data_packet = {
                "name": name,
                "data": data,
                "signature": signature,
                "producer_pk": self.pk,
                "producer_pk_signed": self.pk_signed_by_ca,
            }
            return data_packet
        else:
            print(f"[{self.name}] ❌ Content {name} not available")
            return None

    def send_data_packet(self, data_packet, outgoing_interface):
        """
        Sends the signed data packet to the outgoing interface.
        """
        print(f"[{self.name}] 📤 Sending data packet: {data_packet['name']} to {outgoing_interface.name}")
        outgoing_interface.receive_data_packet(data_packet, self)