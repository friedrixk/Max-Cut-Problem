## Setup

Depending on your operating system and hardware follow the installation procedures as explained in the docs: https://docs.modular.com/mojo/. Currently there is native support for MacOS (Apple Silicon) and Linux. For MacOS (Intel) and Windows you can use a development container or WSL.

To correctly setup the development container:
This has worked for me: https://docs.modular.com/mojo/manual/get-started/hello-world.html

Be careful to choose bash_profile and not zshrc or bashrc:

    vscode ➜ /workspaces/ubuntu $ export MODULAR_HOME="$HOME/.modular"
    
    vscode ➜ /workspaces/ubuntu $ export PATH="$MODULAR_HOME/pkg/packages.modular.com_mojo/bin:$PATH"
    
    vscode ➜ /workspaces/ubuntu $ source ~/.bash_profile

If the above steps don't work try this:
https://github.com/modularml/mojo/issues/551

## Workflow

### Git
https://code.visualstudio.com/remote/advancedcontainers/sharing-git-credentials