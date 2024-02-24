from python import Python

fn main() raises:
    # Import python modules
    let tqdm = Python.import_module("tqdm")
    
    # Import local python modules
    Python.add_to_path("./ilp")
    let ilp = Python.import_module("ilp")
    
    # Run ILP
    let str = ilp.ilp()
    print(str)