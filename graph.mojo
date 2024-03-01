from collections.vector import DynamicVector
from collections import Dict, KeyElement

@value
struct StringKey(KeyElement):
    var s: String

    fn __init__(inout self, owned s: String):
        self.s = s ^

    fn __init__(inout self, s: StringLiteral):
        self.s = String(s)

    fn __hash__(self) -> Int:
        return hash(self.s)

    fn __eq__(self, other: Self) -> Bool:
        return self.s == other.s

struct Graph:
    var vertices: DynamicVector[Int]
    var edges: Dict[StringKey, DynamicVector[Int]]

    fn __init__(inout self):
        self.vertices = DynamicVector[Int]()
        self.edges = Dict[StringKey, DynamicVector[Int]]()

    fn add_vertex(inout self, v: Int):
        if not self.contains_vertex(v):
            self.vertices.push_back(v)
            self.edges[StringKey(String(v))] = DynamicVector[Int]()
        else:
            print("Vertex " + str(v) + " already exists")
    
    fn add_edge(inout self, v:Int, u:Int) raises:
        if not self.contains_edge(v, u):    
            if not self.contains_vertex(v):
                self.vertices.push_back(v)
            if not self.contains_vertex(u):
                self.vertices.push_back(u)
            self.edges[StringKey(str(v))].push_back(u)  # directed
            self.edges[StringKey(String(u))].push_back(v)  # undirected
        else:
            print("Edge " + str(v) + "->" + str(u) + " already exists")

    fn contains_vertex(self, v: Int) -> Bool:
        for i in range(len(self.vertices)):
            var w = self.vertices[i]
            if w == v:
                return True
        return False

    fn contains_edge(self, v: Int, u: Int) raises -> Bool:
        var neighbors = self.edges[StringKey(String(v))]
        for i in range(len(neighbors)):
            var neighbor = neighbors[i]
            if neighbor == u:
                return True
        return False

    fn get_vertices(self) -> DynamicVector[Int]:
        return self.vertices
    
    fn get_edges(self) raises -> DynamicVector[DynamicVector[Int]]:
        var es = DynamicVector[DynamicVector[Int]]()
        for i in range(len(self.vertices)):
            var v = self.vertices[i]
            var neighbors = self.edges[StringKey(String(v))]
            for j in range(len(neighbors)):
                var u = neighbors[j]
                var e = DynamicVector[Int]()
                e.push_back(v)
                e.push_back(u)
                es.push_back(e)
        return es
    
    fn get_neighbors(self, v: Int) raises -> DynamicVector[Int]:
        return self.edges[StringKey(String(v))]
    
    fn delete_vertex(inout self, v: Int) raises:
        for i in range(len(self.vertices)):
            if self.contains_edge(v, self.vertices[i]):
                self.delete_edge(v, self.vertices[i])
        # delete v from self.edges
        var new_edges = Dict[StringKey, DynamicVector[Int]]()
        for i in range(len(self.vertices)):
            var w = self.vertices[i]
            if w != v:
                new_edges[StringKey(String(w))] = self.edges[StringKey(String(w))]
        self.edges = new_edges
        self.edges.pop(StringKey(String(v)))

    fn delete_edge(inout self, v: Int, u: Int) raises:
        self.delete_directed_edge(v, u)
        self.delete_directed_edge(u, v)

    fn delete_directed_edge(inout self, v: Int, u: Int) raises:
        if self.contains_edge(v,u):
            var new_neighbors = DynamicVector[Int]()
            var neighbors = self.edges[StringKey(String(v))]
            for i in range(len(neighbors)):
                if neighbors[i] != u:
                    new_neighbors.push_back(neighbors[i])
            self.edges[StringKey(String(v))] = new_neighbors
        else:
            print("Edge " + str(v) + "->" + str(u) + " does not exist")

    fn print_vertices(self):
        for i in range(len(self.vertices)):
            print(self.vertices[i])
    
    fn print_edges(self) raises:
        for i in range(len(self.vertices)):
            var v = self.vertices[i]
            var neighbors = self.edges[StringKey(String(v))]
            for j in range(len(neighbors)):
                var u = neighbors[j]
                print(str(v) + "->" + str(u))
