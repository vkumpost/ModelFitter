"""
`ModelFitter`

Package for the fitting of simple population models.

**Function Library**
- `single_humped_function`: Single-humped function.

**Function Plotter**
- `plot_<function_name>`: Plot parameter effects for function `function_name`.

**Input/Output**
- `load_data`: Load data from a CSV file.

**Metrics**
- `integrate`: Estimate the area under the curve.
- `rmse`: Estimate the root-mean-square error.
"""
module ModelFitter

using DataFrames
using DelimitedFiles
using PyPlot

export single_humped_function
include("function_library.jl")

export plot_single_humped_function
include("function_plotter.jl")

export load_data
include("input_output.jl")

export integrate, rmse
include("metrics.jl")

end # module
