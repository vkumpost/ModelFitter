"""
`ModelFitter`

Package for the fitting of simple population models.

**Function Library**
- `single_humped_function`: Single-humped function.

**Function Plotter**
- `plot_<function_name>`: Plot parameter effects for function `function_name`.
"""
module ModelFitter

using PyPlot

export single_humped_function
include("function_library.jl")

export plot_single_humped_function
include("function_plotter.jl")

end # module
