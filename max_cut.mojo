from python import Python
from sys import argv
from graph import Graph

fn test_graph_ds() raises:
    var g = Graph()
    g.add_vertex(1)
    g.add_vertex(1)
    g.add_vertex(2)
    g.add_vertex(3)
    g.add_edge(1, 2)
    g.add_edge(2, 1)
    g.add_edge(2, 3)
    print(len(g.vertices))
    print(len(g.edges))
    g.print_vertices()
    g.print_edges()
    let es = g.get_edges()
    for i in range(len(es)):
        var e = es[i]
        print(str(e[0]) + "->" + str(e[1]))
    print("Neighbors of 1:")
    let n = g.get_neighbors(1)
    for i in range(len(n)):
        print(n[i])
    g.delete_edge(2,1)
    g.delete_edge(1,2)
    g.print_edges()

fn main() raises: 
    
    # Import local python modules
    Python.add_to_path("./ilp")
    let ilp = Python.import_module("ilp")
    
    let argv = argv()
    let argc = len(argv)

    # run ilp
    # if argc > 1 and argv[1] == "cplex":
    #     print("Using CPLEX ILP solver.")
    #     let ilp = ilp.ilp(argv[1])
    # else:
    #     print("Using default ILP solver.")
    #     let ilp = ilp.ilp("default")

    # test graph data structure
    test_graph_ds()

    # run approximation algorithm
