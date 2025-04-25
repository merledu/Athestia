from .packet import InterestPacket, DataPacket
from typing import Dict, Set, Any, List
from dataclasses import dataclass
from datetime import datetime

@dataclass
class ContentStoreEntry:
    name: str
    data: Any
    timestamp: datetime
    size: int

@dataclass
class PITEntry:
    name: str
    incoming_interfaces: Set[Any]
    timestamp: datetime

@dataclass
class FIBEntry:
    prefix: str
    next_hop: Any
    cost: int
    timestamp: datetime

class Router:
    def __init__(self, name):
        self.name = name
        self.cs: Dict[str, ContentStoreEntry] = {}  # Content Store
        self.pit: Dict[str, PITEntry] = {}  # Pending Interest Table
        self.fib: Dict[str, FIBEntry] = {}  # Forwarding Information Base
        self.links: List[Any] = []
        self.max_cs_size = 1000  # Maximum number of entries in CS
        self.max_pit_size = 100  # Maximum number of entries in PIT

    def connect(self, node):
        """Connect to another node"""
        if node not in self.links:
            self.links.append(node)
            # Add FIB entry for connected node
            # self.add_fib_entry(f"/{node.name}", node)

    def add_fib_entry(self, prefix: str, next_hop: Any, cost: int = 1):
        """Add or update FIB entry"""
        self.fib[prefix] = FIBEntry(
            prefix=prefix,
            next_hop=next_hop,
            cost=cost,
            timestamp=datetime.now()
        )

    def add_pit_entry(self, name: str, incoming_interface: Any):
        """Add or update PIT entry"""
        if name not in self.pit:
            if len(self.pit) >= self.max_pit_size:
                # Remove oldest entry if PIT is full
                oldest = min(self.pit.items(), key=lambda x: x[1].timestamp)
                del self.pit[oldest[0]]
            
            self.pit[name] = PITEntry(
                name=name,
                incoming_interfaces=set(),
                timestamp=datetime.now()
            )
        
        self.pit[name].incoming_interfaces.add(incoming_interface)
        self.pit[name].timestamp = datetime.now()

    def add_cs_entry(self, name: str, data: Any, size: int):
        """Add or update CS entry"""
        if len(self.cs) >= self.max_cs_size:
            # Remove oldest entry if CS is full
            oldest = min(self.cs.items(), key=lambda x: x[1].timestamp)
            del self.cs[oldest[0]]
        
        self.cs[name] = ContentStoreEntry(
            name=name,
            data=data,
            timestamp=datetime.now(),
            size=size
        )

    def receive_interest_packet(self, interest_packet: InterestPacket, incoming_interface: Any):
        """Handle incoming interest packet"""
        name = interest_packet.name
        print(f"[{self.name}] 📥 Interest received: {name} from {incoming_interface.name}")

        # Check CS first
        if name in self.cs:
            print(f"[{self.name}] ✅ Content found in CS. Sending back to {incoming_interface.name}")
            data_packet = self.cs[name].data
            incoming_interface.receive_data_packet(data_packet, self)
            return

        # Add to PIT
        self.add_pit_entry(name, incoming_interface)

        # Forward based on FIB
        forwarded = False
        for prefix, entry in sorted(self.fib.items(), key=lambda x: len(x[0]), reverse=True):
            if name.startswith(prefix):
                print(f"[{self.name}] 📤 Forwarding interest to {entry.next_hop.name}")
                entry.next_hop.receive_interest_packet(interest_packet, self)
                forwarded = True
                break

        if not forwarded:
            print(f"[{self.name}] ❌ No FIB entry for: {name}")

    def receive_data_packet(self, data_packet: DataPacket, incoming_interface: Any):
        """Handle incoming data packet"""
        name = data_packet["name"]
        print(f"[{self.name}] 📦 Data packet received: {name} from {incoming_interface.name}")

        # Store in CS
        self.add_cs_entry(name, data_packet, len(str(data_packet)))

        # Forward to all pending interfaces
        if name in self.pit:
            for requester in self.pit[name].incoming_interfaces:
                if requester != incoming_interface:
                    print(f"[{self.name}] 🔁 Sending data back to {requester.name}")
                    requester.receive_data_packet(data_packet, self)
            del self.pit[name]
        else:
            print(f"[{self.name}] ⚠️ No PIT entry for: {name}")

    def get_tables_data(self) -> Dict[str, List[Dict[str, Any]]]:
        """Get formatted data for all tables"""
        return {
            "CS": [
                {
                    "Name": entry.name,
                    "Size": entry.size,
                    "Timestamp": entry.timestamp.strftime("%Y-%m-%d %H:%M:%S")
                }
                for entry in self.cs.values()
            ],
            "PIT": [
                {
                    "Name": entry.name,
                    "Interfaces": [iface.name for iface in entry.incoming_interfaces],
                    "Timestamp": entry.timestamp.strftime("%Y-%m-%d %H:%M:%S")
                }
                for entry in self.pit.values()
            ],
            "FIB": [
                {
                    "Prefix": entry.prefix,
                    "Next Hop": entry.next_hop.name,
                    "Cost": entry.cost,
                    "Timestamp": entry.timestamp.strftime("%Y-%m-%d %H:%M:%S")
                }
                for entry in self.fib.values()
            ]
        }

    def clear_tables(self):
        """Clear all tables"""
        self.cs.clear()
        self.pit.clear()
        self.fib.clear()