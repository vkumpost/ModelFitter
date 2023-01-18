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


"""
`load_long_data`

Load data in the long representation from a CSV and convert them into the wide
format.

**Arguments**
- `args...`: Filename or parts of the path to the file.

**Keyword Arguments**
- `colkey`: The name of the column storing column keys (see `DataFrames.unstack`).
- `value`: The name of the column storing values (see `DataFrames.unstack`).

**Returns**
- `df_wide`: Data from the csv file as a DataFrame in the wide format.
"""
function load_long_data(args...; colkey="Month", value="rel.eng")

    df_long = load_data(args...)
    df_wide = unstack(df_long, colkey, value)
    return df_wide

end


"""
`save_data`

Save a DataFrame as a csv file.

**Arguments**
- `df`: DataFrame.
- `args...`: Filename or parts of the path to the file.

**Keyword Arguments**
- `overwrite`: If `false`, the function throws an error if the file already exists.
"""
function save_data(df::DataFrame, args...; overwrite=false)

    # Build a path starting with "data" and continuig based on the passed args
    filename = joinpath(args...)
    
    # If a file with the same name already exists, throw an error
    if !overwrite && isfile(filename)
        error("File already exists!")
    end

    # Create all subdirecotires that do not yet exist
    dir, _ = splitdir(filename)
    if !isdir(dir)
        mkpath(dir)
    end

    # Write the dataframe into the csv file
    matrix = Matrix(df)
    head = names(df)
    csv_content = [reshape(head, 1, length(head)); matrix]
    open(filename, "w") do io
        writedlm(io, csv_content, ',')
    end
    
end
