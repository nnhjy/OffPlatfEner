Pkg.activate("path/to/a/SpineOpt_enviroment")

# use the default conda python of Julia
ENV["PYTHON"] = ""

using Pkg; Pkg.add("PyCall"); Pkg.build("PyCall")

pkg"registry add General https://github.com/spine-tools/SpineJuliaRegistry"
pkg"dev SpineOpt"
Pkg.add("JuMP")
Pkg.add("Gurobi"); Pkg.build("Gurobi")

#=
# To show the default conda python used by Julia, which usually is: $HOME/.julia/conda/3/bin/python
using PyCall
PyCall.pyprogramname
=#