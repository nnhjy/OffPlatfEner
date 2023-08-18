#!/bin/bash
#SBATCH -n 8 #8 cores
#SBATCH --mem-per-cpu=16G # 16GB per core	# guest users can use maximum 48 cores and 128G memory in total
#SBATCH --time=4:00:00 # 4-hour run-time
#SBATCH --tmp=10G # Local scratch space per node
#SBATCH --job-name=InstallSpineOpt
#SBATCH --mail-type=BEGIN,END,FAIL # send an email when the job begins, ends, and fails
# #SBATCH --error=errors.log # append job’s error messages to errors.log

# to execute this script: "sbatch < path/to/sbatch_install_SpineOpt.sh"

module load gurobi gcc/6.3.0 julia/1.8.5 eth_proxy

cd $HOME

julia ./path/to/install_SpineOpt.jl
# a relative path to $HOME

# # standby command to install Spine-Database-API
# $HOME/.julia/conda/3/bin/python -m pip install --user 'git+https://github.com/Spine-project/Spine-Database-API@master'
# # The python path can be obtained using PyCall in Julia, see in the install_SpineOpt.jl
