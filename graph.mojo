from collections.vector import DynamicVector
from collections import Dict, KeyElement

@value
struct IntKey(KeyElement):
    var i: Int

    fn __init__(inout self, owned i: Int):
        self.i = i

    fn __hash__(self) -> Int:
        return hash(self.i)

    fn __eq__(self, other: Self) -> Bool:
        return self.i == other.i

struct Graph:
    var vertices: DynamicVector[Int]
    var edges: Dict[IntKey, DynamicVector[Int]]

    fn __init__(inout self):
        self.vertices = DynamicVector[Int]()
        self.edges = Dict[IntKey, DynamicVector[Int]]()

    fn add_vertex(inout self, v: Int):
        if IntKey(v) not in self.edges:
            self.vertices.push_back(v)
            self.edges[IntKey(v)] = DynamicVector[Int]()
        else:
            print("Vertex " + str(v) + " already exists")
    
    fn add_edge(inout self, v:Int, u:Int) raises:
        if not self.contains_edge(v, u):    
            if IntKey(v) not in self.edges:
                self.vertices.push_back(v)
            if IntKey(u) not in self.edges:
                self.vertices.push_back(u)
            self.edges[IntKey(v)].push_back(u)  # directed
            self.edges[IntKey(u)].push_back(v)  # undirected
        else:
            print("Edge " + str(v) + "->" + str(u) + " already exists")

    fn contains_edge(self, v: Int, u: Int) raises -> Bool:
        var neighbors = self.edges[IntKey(v)]
        for i in range(len(neighbors)):
            var neighbor = neighbors[i]
            if neighbor == u:
                return True
        return False

    fn get_vertices(self) -> DynamicVector[Int]:
        return self.vertices
    
    fn get_edges(self) raises -> Dict[IntKey, DynamicVector[Int]]:
        return self.edges
    
    fn get_neighbors(self, v: Int) raises -> DynamicVector[Int]:
        return self.edges[IntKey(v)]
    
    fn delete_vertex(inout self, v: Int) raises:
        for i in range(len(self.vertices)):
            if self.contains_edge(v, self.vertices[i]):
                self.delete_edge(v, self.vertices[i])
        var value = self.edges.pop(IntKey(v))

    fn delete_edge(inout self, v: Int, u: Int) raises:
        self.delete_directed_edge(v, u)
        self.delete_directed_edge(u, v)

    fn delete_directed_edge(inout self, v: Int, u: Int) raises:
        if self.contains_edge(v, u):
            var new_neighbors = DynamicVector[Int]()
            var neighbors = self.edges[IntKey(v)]
            for i in range(len(neighbors)):
                if neighbors[i] != u:
                    new_neighbors.push_back(neighbors[i])
            self.edges[IntKey(v)] = new_neighbors
        else:
            print("Edge " + str(v) + "->" + str(u) + " does not exist")

    fn print_vertices(self):
        for i in range(len(self.vertices)):
            print(self.vertices[i])
    
    fn print_edges(self) raises:
        for i in range(len(self.vertices)):
            var v = self.vertices[i]
            var neighbors = self.edges[IntKey(v)]
            for j in range(len(neighbors)):
                var u = neighbors[j]
                print(str(v) + "->" + str(u))
