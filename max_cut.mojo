from python import Python
from sys import argv
from graph import Graph

fn test_graph_ds() raises:
    var g = Graph()
    g.add_vertex(1)
    # g.add_vertex(1)
    # g.add_vertex(2)
    # g.add_vertex(3)
    # g.add_edge(1, 2)
    # g.add_edge(2, 1)
    # g.add_edge(2, 3)
    # g.print_vertices()
    # var vs = g.get_vertices()
    # vs[0] = 8
    # g.print_vertices()
    # g.add_vertex(7)
    # g.add_vertex(5)
    # g.add_vertex(6)
    # g.add_vertex(4)
    # g.add_edge(1, 4)
    # g.add_edge(2, 4)
    # g.add_edge(2, 7)
    # g.add_vertex(7)
    # g.add_vertex(5)
    # g.add_vertex(6)
    # g.add_vertex(4)
    # g.add_edge(1, 4)
    # g.add_edge(2, 4)
    # g.add_edge(2, 7)
    # print(len(g.vertices))
    # print(len(g.edges))
    # g.print_vertices()
    # g.print_edges()
    # var n = g.get_neighbors(1)
    var es = g.get_edges()
    # var vs = g.get_vertices()
    # print("Neighbors of 1:")
    # for i in range(len(n)):
    #     print(n[i])
    # print("Edges:")
    # g.delete_edge(2,1)
    # g.delete_edge(1,2)
    # g.print_edges()
    # g.add_vertex(1)
    # g.add_vertex(4)
    # g.add_vertex(5)
    # g.add_vertex(6)
    # g.add_edge(4, 2)
    # g.add_edge(4, 1)
    # g.add_edge(4, 3)
    # g.print_vertices()
    # g.print_edges()

fn main() raises: 
    
    # Import local python modules
    Python.add_to_path("./ilp")
    var ilp = Python.import_module("ilp")
    
    var argv = argv()
    var argc = len(argv)



    # run ilp
    # if argc > 1 and argv[1] == "cplex":
    #     print("Using CPLEX ILP solver.")
    #     let ilp = ilp.ilp(argv[1])
    # else:
    #     print("Using default ILP solver.")
    #     let ilp = ilp.ilp("default")

    # test graph data structure
    test_graph_ds()
    test_graph_ds()

    # run approximation algorithm
