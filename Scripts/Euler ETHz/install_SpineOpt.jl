# Author: Huang, Jiangyi (ETHz)
# Date: 2023-Aug-18
# This script installs the lastest development version of SpineOpt.jl associated packages on ETHz Euler cluster.

#= Step 1: Before running this script, 
one needs to load the following modules on Euler using the command below in bash:
    module load gurobi gcc/6.3.0 julia/1.8.5 eth_proxy
=#

#= To check which julia is available on Euler, use the command below in bash:
    module spider julia
=#

#= Step 2: Default command to run this script on Euler in bash: 
julia /path/to/install_SpineOpt.jl, e.g.
    julia $HOME/Projects/SpineOptModels/install_SpineOpt.jl
=#

# Use the directory of this script as the default directory for
# the julia virtual environment that accommodates SpineOpt.jl and the related packages
path_to_SpineOpt_env = @__DIR__

# (Optional Step 2) 
# Specify the directory for the julia virtual environment in the script
target_directory = ENV["HOME"]*"/Projects/SpineOptModels"
!isdir(target_directory) ? mkdir(target_directory) : path_to_SpineOpt_env = target_directory

# (Optional Step 2) 
#= Specify the directory for the julia virtual environment in the first argument on running this script in bash, e.g.
    julia $HOME/install_SpineOpt.jl $HOME/Projects/SpineOptModels
=#
isempty(ARGS) ? nothing : path_to_SpineOpt_env = ARGS[1]

cd(path_to_SpineOpt_env)

using Pkg; Pkg.activate(".")

# Build needed packages
Pkg.add("JuMP"); 
Pkg.add("Gurobi"); Pkg.build("Gurobi")
Pkg.add(url="https://github.com/Spine-tools/SpineInterface.jl.git", rev="master")
Pkg.add(url="https://github.com/Spine-tools/SpineOpt.jl.git", rev="master")

# Use the default conda python of Julia
ENV["PYTHON"] = ""
Pkg.add("PyCall"); Pkg.build("PyCall")

# Initialise the conda environment of Julia to the latest version
Pkg.add("Conda")
using Conda
# To avoid environment inconsistency due to package `spinedb-api` on update
Conda.pip_interop(false)
# Use `conda config --show` and lookup the "pip_interop_enabled" parameter
Conda.update(); Conda.clean()
# To manage the pip installed packages listed by `Conda.list()`, see the docs below:
# 1. https://github.com/JuliaPy/Conda.jl#conda-and-pip
# 2. https://docs.conda.io/projects/conda/en/latest/user-guide/configuration/pip-interoperability.html#improving-interoperability-with-pip

# Obtain the path to the Python executable of Julia: most likely "$HOME/.julia/conda/3/bin/python"
using PyCall
PythonForSpineDB_API = PyCall.pyprogramname

command_install_SpineDB_API = PythonForSpineDB_API*" -m pip install --user 'git+https://github.com/Spine-project/Spine-Database-API@master'"

Conda.pip_interop(true)
run(`bash -c $command_install_SpineDB_API`)
# Use Conda.list() in Julia to check whether `spinedb-api` is installed

# To avoid environment inconsistency due to the pip installed package `spinedb-api` during update in other circumstances
Conda.pip_interop(false)