# Three Max Cut Algorithms: ILP, Approximation and Heuristic

Implementation realized in the context of the lecture 'Algorithm Engineering' at the University of Konstanz. This repository contains three algorithms to solve the Max Cut problem on unweighted, undirected graphs: an exact algorithm using ILP, an approximation and a heuristic.

## Setup

### Mojo

Depending on your operating system and hardware follow the installation procedures as explained in the [docs](https://docs.modular.com/mojo/). Currently there is native support for MacOS (Apple Silicon) and Linux. For MacOS (Intel) and Windows you can use a development container or WSL.

To correctly setup the development container:
This has worked for me: https://docs.modular.com/mojo/manual/get-started/hello-world.html

Be careful to choose bash_profile and not zshrc or bashrc:

    vscode ➜ /workspaces/ubuntu $ export MODULAR_HOME="$HOME/.modular"
    
    vscode ➜ /workspaces/ubuntu $ export PATH="$MODULAR_HOME/pkg/packages.modular.com_mojo/bin:$PATH"
    
    vscode ➜ /workspaces/ubuntu $ source ~/.bash_profile

If the above steps don't work try this:
https://github.com/modularml/mojo/issues/551

# Run the code
To run the code, execute the `max_cut.mojo` file:

    $ mojo max_cut.mojo

The three implemented algorithms will be executed one after the other on all files inside the `/graphs/performance` directory.

If you want to use the CPLEX_CMD solver for the ILP solution, you can use the following command:

    $ mojo max_cut.mojo "cplex"

Make sure to have [IBM ILOG CPLEX Optimization Studio](https://www.ibm.com/de-de/products/ilog-cplex-optimization-studio) installed on the system where you are executing the code. You may need to change the `path_to_cplex` variable in `ilp.py` depending on where your CPLEX installation resides. See also: [How to configure a solver in PuLP](https://coin-or.github.io/pulp/guides/how_to_configure_solvers.html#).

If no argument is specified, the default PuLP solver (CBC_CMD) will be used.