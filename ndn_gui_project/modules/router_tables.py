# modules/router_tables.py

from collections import deque, defaultdict

class RouterTable:
    def __init__(self, router_name):
        self.router_name = router_name
        self.cs = []   # Content Store: list of dicts {'name':..., 'data':...}
        self.pit = []  # Pending Interest Table: list of dicts {'name':..., 'incoming_interface':...}
        self.fib = []  # Forwarding Info Base: list of dicts {'name':..., 'outgoing_interface':...}

    def clear_tables(self):
        self.cs.clear()
        self.pit.clear()
        self.fib.clear()

    def add_cs(self, name, data):
        self.cs.append({'name': name, 'data': data})

    def add_pit(self, name, incoming_interface):
        self.pit.append({'name': name, 'incoming_interface': incoming_interface})

    def add_fib(self, name, outgoing_interface):
        # Normalize the name: lowercase and remove trailing slashes
        normalized_name = name.lower().rstrip('/')
        print(f"[DEBUG] {self.router_name} - Adding FIB entry: {normalized_name} -> {outgoing_interface}")
        print(f"[DEBUG] {self.router_name} - Before update: {self.fib}")
        # Remove all existing entries with the same normalized name
        self.fib.clear()
        # Add the new entry with the original name
        self.fib.append({'name': name, 'outgoing_interface': outgoing_interface})
        print(f"[DEBUG] {self.router_name} - After update: {self.fib}")
        
    def get_cs(self, name):
        for entry in self.cs:
            if entry["name"].lower().rstrip('/') == name.lower().rstrip('/'):
                return entry["data"]  # Return full data packet
        return None

    def remove_pit(self, name):
        self.pit = [entry for entry in self.pit if entry['name'] != name]

def build_topology_graph(components):
    graph = defaultdict(list)
    name_to_comp = {comp.name: comp for comp in components}
    for comp in components:
        for neighbor in comp.connected_components:
            if neighbor.component_type in ["Producer", "Consumer", "Router"] and comp.component_type in ["Producer", "Consumer", "Router"]:
                graph[comp.name].append(neighbor.name)
    return graph, name_to_comp

def bfs_shortest_path(graph, start, goal):
    visited = set()
    queue = deque([[start]])
    if start == goal:
        return [start]
    while queue:
        path = queue.popleft()
        node = path[-1]
        if node not in visited:
            for neighbor in graph.get(node, []):
                new_path = list(path)
                new_path.append(neighbor)
                if neighbor == goal:
                    return new_path
                queue.append(new_path)
            visited.add(node)
    return []
