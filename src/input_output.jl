"""
`load_data`

Load a DataFrame from a csv file.

**Arguments**
- `args...`: Filename or parts of the path to the file.

**Returns**
- `df`: Data from the csv file as a DataFrame.
"""
function load_data(args...)

    # Build a path starting with "data" and continuig based on the passed args
    filename = joinpath(args...)

    # Load a csv file
    matrix, head = readdlm(filename, ',', header=true)

    # Convert the file into a dataframe
    df = DataFrame(matrix, vec(head))

    return df

end
