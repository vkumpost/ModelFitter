"""
`integrate`

Estimate the area under the curve.

**Arguments**
- `fun`: Function `fun(t, p)` where `t` is time and `p` is parameter vector.
- `p`: Parameter vector.
- `t1`: Start point of the integration.
- `t2`: End point of the integration.

**Keyword Arguments**
- `t_step`: Integration step. Default value is `(t2-t1)/100`.

**Returns**
- `AUC`: Estiated area under the curve.
"""
function integrate(fun, p, t1, t2; t_step=(t2-t1)/100)

    t = t1:t_step:t2
    x = fun(t, p)
    AUC = sum(x) * t_step
    return AUC

end
