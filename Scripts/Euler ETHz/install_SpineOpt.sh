#!/bin/bash
#SBATCH -n 1 # 1 core
#SBATCH --mem-per-cpu=8G # 8GB per core, guest users can use maximum 48 cores and 128G memory in total
#SBATCH --time=1:00:00 # 1-hour run-time
#SBATCH --tmp=2G # Local scratch space per node
#SBATCH --job-name=InstallSpineOpt
#SBATCH --mail-type=BEGIN,END,FAIL # send an email when the job begins, ends, and fails
# #SBATCH --error=errors.log # append job’s error messages to errors.log

# to execute this script: "sbatch < path/to/install_SpineOpt.sh"
# to fix DOS line breaks error, run "dos2unix path/to/install_SpineOpt.sh" in the terminal first

module load gurobi julia/1.10.3 eth_proxy

# Place this script in the same directory as the install_SpineOpt.jl
julia ./install_SpineOpt.jl

# # standby command to install Spine-Database-API
# $HOME/.julia/conda/3/bin/python -m pip install --user 'git+https://github.com/Spine-project/Spine-Database-API@master'
# # The python path can be obtained using PyCall in Julia, see in the install_SpineOpt.jl
