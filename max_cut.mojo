from python import Python
from sys import argv

fn main() raises: 
    
    # Import local python modules
    Python.add_to_path("./ilp")
    let ilp = Python.import_module("ilp")
    
    let argv = argv()
    let argc = len(argv)

    if argc > 1 and argv[1] == "cplex":
        print("Using CPLEX ILP solver.")
        let ilp = ilp.ilp(argv[1])
    else:
        print("Using default ILP solver.")
        let ilp = ilp.ilp("default")