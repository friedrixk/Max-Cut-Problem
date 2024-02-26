from tqdm import tqdm
import os
import pulp

path_to_cplex = "/opt/ibm/ILOG/CPLEX_Studio2211/cplex/bin/x86-64_linux/cplex"

def ilp(solver_type:str):
    file_list = sorted(os.listdir("graphs/correctness_test"))
    print(file_list)
    for file in tqdm(file_list):
        file_path = "graphs/correctness_test/" + file
        solve_instance(solver_type, file_path)
    return "############ ILP finished ############"

def solve_instance(solver_type:str, file_path:str):
    node_ids, edge_ids, data = read_file(file_path)
    lp, xv, yij = formulate_lp(node_ids, edge_ids, data)
    solver = set_solver(solver_type)
    lp.solve(solver)
    print_solution(lp, xv, node_ids)

def read_file(file_path:str) -> tuple:
    graph = open(file_path)
    node_ids, edge_ids = get_ids(graph)
    data = read_edges(graph)
    return node_ids, edge_ids, data

def get_ids(graph) -> tuple:
    n_nodes, n_edges = map(int, graph.readline().split())
    print("node_ids: " + str(n_nodes) + "\n" + "edge_ids: ", str(n_edges))
    node_ids = range(n_nodes)
    edge_ids = range(n_edges)
    return node_ids, edge_ids

def read_edges(graph) -> list:
    data = []
    for line in graph.readlines():
        tup = tuple(map(int, line.split()[:2]))
        # if "performance" in file_path:
        #     tup = (tup[0]-1, tup[1]-1)
        data.append(tup)
    return data

def formulate_lp(node_ids:range, edge_ids:range, data:list) -> tuple:
    #initialize lp problem
    lp = pulp.LpProblem("Max_Cut_Problem",pulp.LpMaximize)

    #variable x_v to indicate whether node v is in the cut
    xv = pulp.LpVariable.dicts("x",node_ids,0,1,pulp.LpInteger)
    # variable y_ij to indicate whether edge (i,j) is cut
    yij = pulp.LpVariable.dicts("y",edge_ids,0,1,pulp.LpInteger)

    #objective is the sum of yij over all edge_ids
    obj = pulp.lpSum(yij[e] for e in edge_ids)
    lp += obj, "Objective_Function"

    #constraint s.t. yij <= xi + xj for all edge_ids (i,j)
    for e in edge_ids:
        i = data[e][0]
        j = data[e][1]
        lp += yij[e] <= xv[i] + xv[j], ""

    # constraint s.t. yij <= 2 - xi - xj for all edge_ids (i,j)
    for e in edge_ids:
        i = data[e][0]
        j = data[e][1]
        lp += yij[e] <= 2 - xv[i] - xv[j], ""

    return lp, xv, yij

def set_solver(solver_type:str) -> pulp.apis.LpSolver_CMD:
    if solver_type == "cplex":
        solver = pulp.CPLEX_CMD(path=path_to_cplex, msg=False, timeLimit=120)
    else:
        solver = pulp.apis.PULP_CBC_CMD(msg=False, timeLimit=120)
    return solver

def print_solution(lp, xv, node_ids:range):
    left = []
    for i in node_ids:
        if pulp.value(xv[i]) == 0:
            left.append(i)
    print("Nodes on left side of cut: ", left)
    print("Size of cut: ", pulp.value(lp.objective))