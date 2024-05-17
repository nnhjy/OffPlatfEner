import Pkg
Pkg.activate("/path/to/the/SpineOpt_environment")
# Already set up in the install_SpineOpt.jl

using SpineOpt
using JuMP
using Gurobi 

# db address is relative to the working directory set when this script is run, not relative to the script location.
input_db_url = "sqlite:///./path/to/inputDB.sqlite"
output_db_url = "sqlite:///./path/to/outputDB.sqlite"

scenario_name = "scenario_xx"

m = run_spineopt(
    input_db_url, output_db_url; 
    upgrade=true,
    mip_solver=optimizer_with_attributes(Gurobi.Optimizer),
    lp_solver=optimizer_with_attributes(Gurobi.Optimizer),
    filters=Dict("tool" => "object_activity_control", "scenario" => scenario_name),
    alternative=scenario_name
)

#=
Alternatively, you can customize your run by using the form below.
Keyword arguments are described in https://spine-tools.github.io/SpineOpt.jl/latest/library/#SpineOpt.run_spineopt

m = run_spineopt(
    ARGS...;
    upgrade=false,
    mip_solver=nothing,
    lp_solver=nothing,
    add_user_variables=m -> nothing,
    add_constraints=m -> nothing,
    update_constraints=m -> nothing,
    log_level=3,
    optimize=true,
    update_names=false,
    alternative="",
    write_as_roll=0,
    use_direct_model=false,
    filters=Dict("tool" => "object_activity_control"),
    log_file_path=nothing,
    resume_file_path=nothing
)
=#