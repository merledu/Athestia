# core/network.py

from .node import Node
from .link import Link
from .consumer import Consumer
from .producer import Producer
from .router import Router
from .ca import CertificateAuthority


class Network:
    def __init__(self):
        # Certificate Authority
        self.ca = CertificateAuthority()

        # Initialize lists to track all nodes
        self.consumers = []
        self.producers = []
        self.routers = []
        self.cas = [self.ca]

        # Links
        self.links = []

    def add_consumer(self, name):
        """Add a new consumer to the network"""
        consumer = Consumer(name, self.ca.get_public_key())
        self.consumers.append(consumer)
        return consumer

    def add_producer(self, name):
        """Add a new producer to the network"""
        producer = Producer(name, self.ca)
        self.producers.append(producer)
        return producer

    def add_router(self, name):
        """Add a new router to the network"""
        router = Router(name)
        self.routers.append(router)
        return router

    def add_link(self, node1, node2):
        """Create a bidirectional link between two nodes"""
        # Create the link objects
        link1 = Link(node1, node2)
        link2 = Link(node2, node1)
        
        # Add to network's link list
        self.links.append(link1)
        self.links.append(link2)
        
        # Connect the nodes
        node1.connect(node2)
        node2.connect(node1)

    def get_node_by_name(self, name):
        """Find a node by its name across all node types"""
        # Check consumers
        for consumer in self.consumers:
            if consumer.name == name:
                return consumer
                
        # Check producers
        for producer in self.producers:
            if producer.name == name:
                return producer
                
        # Check routers
        for router in self.routers:
            if router.name == name:
                return router
                
        # Check CA
        if self.ca.name == name:
            return self.ca
                
        return None

    # def setup_fib(self):
    #     """Setup initial FIB entries for routers"""
    #     for router in self.routers:
    #         # Add FIB entries for connected nodes
    #         for link in self.links:
    #             if link.node1 == router:
    #                 router.add_fib_entry(f"/{link.node2.name}", link.node2)
    #             elif link.node2 == router:
    #                 router.add_fib_entry(f"/{link.node1.name}", link.node1)

    def simulate(self):
        """Start the network communication from consumer to producer"""
        if not self.consumers or not self.producers or not self.routers:
            print("Network not properly configured. Need at least one consumer, producer, and router.")
            return

        # Get the first consumer and producer
        consumer = self.consumers[0]
        producer = self.producers[0]
        
        # Find a path from consumer to producer through routers
        path = self.find_path(consumer, producer)
        if not path:
            print("No path found from consumer to producer")
            return

        # Start simulation
        print("\n🔗 Starting simulation")
        interest_name = "/video/tutorial/2025"
        interest_packet = consumer.create_interest_packet(interest_name)
        
        # Send to first router
        path[0].receive_interest_packet(interest_packet, consumer)

    def find_path(self, start, end):
        """Find a path from start node to end node through routers"""
        visited = set()
        path = []
        
        def dfs(node):
            if node == end:
                return True
            if node in visited:
                return False
                
            visited.add(node)
            path.append(node)
            
            for link in self.links:
                if link.node1 == node and link.node2 not in visited:
                    if dfs(link.node2):
                        return True
                elif link.node2 == node and link.node1 not in visited:
                    if dfs(link.node1):
                        return True
                        
            path.pop()
            return False
            
        if dfs(start):
            return path
        return None


if __name__ == "__main__":
    net = Network()
    net.simulate()