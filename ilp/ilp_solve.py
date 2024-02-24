import pulp

def ilp_solve(file_path):
    #load graph
    graph = open(file_path)
    
    # read number of nodes and edges
    n_nodes, n_edges = map(int, graph.readline().split())
    print("nodes: ", n_nodes)
    print("edges: ", n_edges)

    # read edges
    data = []
    for line in graph.readlines():
        tup = tuple(map(int, line.split()[:2]))
        # if file_path contains the word "correctness", then subtract 1 from each value in the tuple
        if "correctness" in file_path:
            tup = (tup[0]-1, tup[1]-1)
        data.append(tup)

    nodes = range(n_nodes)
    edges = range(n_edges)

    #initialize lp problem
    lp = pulp.LpProblem("Max_Cut_Problem",pulp.LpMaximize)

    #variable x_v to indicate whether node v is in the cut
    xv = pulp.LpVariable.dicts("x",nodes,0,1,pulp.LpInteger)
    # variable y_ij to indicate whether edge (i,j) is cut
    yij = pulp.LpVariable.dicts("y",edges,0,1,pulp.LpInteger)

    #objective is the sum of yij over all edges
    obj = pulp.lpSum(yij[e] for e in edges)
    lp += obj, "Objective_Function"

    #constraint s.t. yij <= xi + xj for all edges (i,j)
    for e in edges:
        i = data[e][0]
        j = data[e][1]
        lp += yij[e] <= xv[i] + xv[j], ""

    # constraint s.t. yij <= 2 - xi - xj for all edges (i,j)
    for e in edges:
        i = data[e][0]
        j = data[e][1]
        lp += yij[e] <= 2 - xv[i] - xv[j], ""

    #solve lp; no logs; set time limit to 120 seconds
    lp.solve(pulp.apis.PULP_CBC_CMD(msg=False, timeLimit=120))

    print("Size of cut: ", pulp.value(lp.objective))