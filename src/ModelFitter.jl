"""
`ModelFitter`

Package for the fitting of simple population models.

**Function Library**
- `single_humped_function`: Single-humped function.

**Function Plotter**
- `plot_<function_name>`: Plot parameter effects for function `function_name`.

**Input/Output**
- `load_data`: Load data from a CSV file.
- `load_long_data`: Load long data and convert them into the wide format.
- `save_data`: Save data into a CSV file.

**Metrics**
- `integrate`: Estimate the area under the curve.
- `rmse`: Estimate the root-mean-square error.

**Parameter Fitting**
- `find_first_nonzero`: Find index of the first nonzero element in an array.
- `create_loss_function`: Create loss function for optimization.
- `fit_loss_function`: Fit loss function.
"""
module ModelFitter

using DataFrames
using DelimitedFiles
using Interpolations
using PyPlot

import BlackBoxOptim
import Optim

export single_humped_function
include("function_library.jl")

export plot_single_humped_function
include("function_plotter.jl")

export load_data, load_long_data, save_data
include("input_output.jl")

export integrate, rmse
include("metrics.jl")

export find_first_nonzero, create_loss_function, fit_loss_function
include("parameter_fitting.jl")

end # module
