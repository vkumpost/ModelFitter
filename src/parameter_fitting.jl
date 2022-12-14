"""
`find_first_nonzero`

Find the index of the first nonzero element in an array.

**Arguments**
- `x`: Array of values.

**Keyword Arguments**
- `threshold`: Threshold under which the value is considered as zero.

**Returns**
- `index`: Index of the first non-zero element or `length(x) + 1`.
"""
function find_first_nonzero(x; threshold=1e-2)
    for (index, value) in enumerate(x)
        if value > threshold
            return index
        end
    end
    return length(x) + 1
end


"""
`create_loss_function`

Create a loss function for optimization.

**Arguments**
- `t_data`: Time vector.
- `x_data`: Data vector

**Returns**
- `loss_function`: Loss function.
"""
function create_loss_function(t_data, x_data)

    function loss_function(p)

        # Make sure the function never reaches values higher than 1
        fun = t -> -single_humped_function(t, p)[1]
        res = Optim.optimize(fun, [p[end] + 0.01])
        max_value = -Optim.minimum(res)
        if max_value > 1
            return Inf
        end

        # Remove NaN values and interpolate the remaining values
        x = x_data[.!isnan.(x_data)]
        t = t_data[.!isnan.(x_data)]
        interp_linear = linear_interpolation(t, x, extrapolation_bc=Flat())

        # Calculate the distance between the function output and interpolated data
        tt = t_data[1]:0.1:t_data[end]
        xx = interp_linear(tt)
        yy = single_humped_function(tt, p)
        err = sum((xx .- yy).^2) / length(t_data)

        return err

    end

    return loss_function

end


"""
`fit_loss_function`

Fit loss function.

**Arguments**
- `loss_function`: Loss function (see `create_loss_function`).
- `search_range`: Vector of tuples indicating search range for individual parameters. 

**Returns**
- `p`: Vector of estimated parameters.
"""
function fit_loss_function(loss_function, search_range)

    result = BlackBoxOptim.bboptimize(
        loss_function;
        SearchRange = search_range,
        PopulationSize = 50,
        MaxSteps = 100_000,
        TraceMode = :verbose  # :verbose, :silent
    )
    p = BlackBoxOptim.best_candidate(result)
    return p

end
