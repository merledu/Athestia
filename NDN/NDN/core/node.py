# core/node.py

from abc import ABC, abstractmethod

class Node(ABC):
    """Base class for all nodes (Consumer, Producer, Router, CA)."""
    
    def __init__(self, name):
        self.name = name
        self.links = []  # Connections to other nodes

    def connect(self, other_node):
        if other_node not in self.links:
            self.links.append(other_node)
            other_node.links.append(self)

    @abstractmethod
    def node_type(self):
        pass

    def __str__(self):
        return f"{self.node_type()}({self.name})"


class ConsumerNode(Node):
    """Node that sends Interest packets to request content."""
    
    def __init__(self, name):
        super().__init__(name)
        self.received_data = []

    def node_type(self):
        return "Consumer"

    def request_content(self, content_name):
        """Simulate user sending an Interest packet."""
        print(f"[{self.name}] Sending Interest: {content_name}")
        return {
            "type": "interest",
            "name": content_name,
            "source": self
        }

    def receive_data(self, data_packet):
        """Called when data is received at consumer."""
        print(f"[{self.name}] Received data: {data_packet['name']}")
        self.received_data.append(data_packet)


class ProducerNode(Node):
    """Node that responds to Interest packets with signed Data packets."""
    
    def __init__(self, name, content_dict):
        super().__init__(name)
        self.content = content_dict  # Example: {'/video/123': 'some_data'}
        self.pk = None  # Public key
        self.sk = None  # Secret key

    def node_type(self):
        return "Producer"

    def provide_content(self, content_name):
        return self.content.get(content_name, None)


class RouterNode(Node):
    """Router node with CS, PIT, FIB tables."""
    
    def __init__(self, name):
        super().__init__(name)
        self.cs = {}   # Content Store: name -> data_packet
        self.pit = {}  # Pending Interest Table: name -> [incoming_interfaces]
        self.fib = {}  # Forwarding Information Base: name_prefix -> outgoing_interface

    def node_type(self):
        return "Router"

    def add_fib_entry(self, prefix, interface):
        self.fib[prefix] = interface

    def add_pit_entry(self, name, interface):
        if name not in self.pit:
            self.pit[name] = []
        self.pit[name].append(interface)

    def cache_data(self, data_packet):
        self.cs[data_packet['name']] = data_packet


class CertificateAuthorityNode(Node):
    """CA node that manages certificates and signs public keys."""
    
    def __init__(self, name):
        super().__init__(name)
        self.pk = None  # Public key
        self.sk = None  # Secret key

    def node_type(self):
        return "CA"

    def sign_producer_key(self, producer_pk):
        """Simulate signing producer's public key with CA's secret key."""
        signature = f"sig({producer_pk})_by_CA"
        return signature