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
