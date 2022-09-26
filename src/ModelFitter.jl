"""
`ModelFitter`

Package for the fitting of simple population models.

**Function Library**
- `single_humped_function`: Single-humped function.

**Function Plotter**
- `plot_<function_name>`: Plot parameter effects for function `function_name`.

**Metrics**
- `integrate`: Estimate the area under the curve.
- `rmse`: Estimate the root-mean-square error.
"""
module ModelFitter

using PyPlot

export single_humped_function
include("function_library.jl")

export plot_single_humped_function
include("function_plotter.jl")

export integrate, rmse
include("metrics.jl")

end # module
