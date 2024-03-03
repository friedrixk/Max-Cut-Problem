from collections import Dict

struct Graph:
    var vertices: DynamicVector[Int]
    var edges: Dict[Int, DynamicVector[Int]]

    fn __init__(inout self):
        self.vertices = DynamicVector[Int](capacity=8)
        self.edges = Dict[Int, DynamicVector[Int]]()

    fn add_vertex(inout self, v: Int):
        if v in self.edges:
            print("Vertex " + str(v) + " already exists")
        else:
            self.vertices.push_back(v)
            self.edges.__setitem__(v, DynamicVector[Int](capacity=8))
    
    fn add_edge(inout self, v:Int, u:Int) raises:
        self.add_vertex(v)
        self.add_vertex(u)
        if not self.contains_edge(v, u):    
            if v not in self.edges:
                self.edges.__setitem__(v, DynamicVector[Int](capacity=8))
            if u not in self.edges:
                self.edges.__setitem__(u, DynamicVector[Int](capacity=8))
            self.edges[v].push_back(u)  # directed
            self.edges[u].push_back(v)  # undirected
        else:
            print("Edge " + str(v) + "->" + str(u) + " already exists")

    fn contains_edge(self, v: Int, u: Int) raises -> Bool:
        if v in self.edges:
            var neighbors = self.edges[v]
            for i in range(len(neighbors)):
                var neighbor = neighbors[i]
                if neighbor == u:
                    return True
        return False

    fn get_vertices(self) -> DynamicVector[Int]:
        return self.vertices
    
    # fn get_edges(inout self) raises -> Dict[Int, DynamicVector[Int]]:
    #     return self.edges

    fn get_edges(self) raises -> DynamicVector[DynamicVector[Int]]:
        var es = DynamicVector[DynamicVector[Int]]()
        for i in range(len(self.vertices)):
            var v = self.vertices[i]
            var neighbors = self.edges[v]
            for j in range(len(neighbors)):
                var u = neighbors[j]
                var e = DynamicVector[Int]()
                e.push_back(v)
                e.push_back(u)
                es.push_back(e)
        return es
    
    fn get_neighbors(self, v: Int) raises -> DynamicVector[Int]:
        return self.edges[v]
    
    fn delete_vertex(inout self, v: Int) raises:
        for i in range(len(self.vertices)):
            if self.contains_edge(v, self.vertices[i]):
                self.delete_edge(v, self.vertices[i])
        var value = self.edges.pop(v)

    fn delete_edge(inout self, v: Int, u: Int) raises:
        self.delete_directed_edge(v, u)
        self.delete_directed_edge(u, v)

    fn delete_directed_edge(inout self, v: Int, u: Int) raises:
        if self.contains_edge(v, u):
            var new_neighbors = DynamicVector[Int](capacity=8)
            var neighbors = self.edges[v]
            for i in range(len(neighbors)):
                if neighbors[i] != u:
                    new_neighbors.push_back(neighbors[i])
        else:
            print("Edge " + str(v) + "->" + str(u) + " does not exist")

    fn print_vertices(self):
        for i in range(len(self.vertices)):
            print(self.vertices[i])
    
    fn print_edges(self) raises:
        for i in range(len(self.vertices)):
            var v = self.vertices[i]
            var neighbors = self.edges[v]
            for j in range(len(neighbors)):
                var u = neighbors[j]
                print(str(v) + "->" + str(u))

    fn __copyinit__(inout self, other: Self):
        self.vertices = other.vertices
        self.edges = other.edges
