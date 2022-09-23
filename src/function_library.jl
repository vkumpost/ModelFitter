"""
`single_humped_function`

Single-humped function with a time delay.

**Arguments**
- `t`: Time vector.
- `p`: Parameter vector `[R, θ, n, τ_start]`.

**Returns**
- `x`: Array of values of the function at times `t`.

**Reference**
- Kaplan and Glass (1995) Understanding Nonlinear Dynamics.
"""
function single_humped_function(t, p)

    R, θ, n, τ_start = p
    N = length(t)
    x = fill(NaN, N)
    for i = 1:N
        if t[i] < τ_start
            x[i] = 0
        else
            ti = t[i] - τ_start
            x[i] = R * ti / (1 + (ti / θ) ^ n)
        end
    end

    return x

end
