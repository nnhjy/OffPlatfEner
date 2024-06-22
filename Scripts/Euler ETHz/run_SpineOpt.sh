#!/bin/bash
#SBATCH -n 4 # 4 cores				# Guest users can use maximum 48 cores and 128G memory in total.
#SBATCH --mem-per-cpu=8G # 8 GB per core	# Settings in a batch script only prescribes the resource for its own tasks. 
#SBATCH --time=4:00:00 # 4-hour run-time	# e.g. 4 cores * 16GB/core means we can simutaneously execute 2 of such scripts. 
#SBATCH --tmp=10G # Local scratch space per node
#SBATCH --job-name=runSpineOpt
#SBATCH --mail-type=BEGIN,END,FAIL # send an email when the job begins, ends, and fails
# #SBATCH --error=errors.log # append job's error messages to errors.log

# to execute this script: "sbatch < run_SpineOpt.sh"

module load gurobi gcc/11.4.0 julia/1.10.2

cd $SCRATCH/path/to/the/SpineOptProject

julia ./path/to/run_SpineOpt.jl
