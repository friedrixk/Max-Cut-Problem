from tqdm import tqdm
import os
import ilp_solve

def ilp():
    file_list = os.listdir("graphs/correctness_test")
    print(file_list)
    for file in tqdm(file_list):
        file_path = "graphs/correctness_test/" + file
        ilp_solve.ilp_solve(file_path)
    return "############ ILP finished ############"