using ModelFitter
using DataFrames
using PyPlot

# Load data
df_data = load_long_data("./data/example_data.csv")
N_data = size(df_data, 1)

# Fit the single-humped_function to every row in the data
df_results = nothing  # store fitted parameters here
t = [0, 4, 8, 12, 16, 20]  # time vector
for i_data = 1:N_data
    global df_results

    # Extract data vector and create loss function
    x = Vector(df_data[i_data, 5:end])
    loss_function = create_loss_function(t, x)

    # Define search range for the parameters
    # the search range for the time delay depends on the first nonzero element in x
    t1 = 0
    t2 = t[find_first_nonzero(x)]
    search_range = [(0.0, 0.5), (0.0, 20.0), (1.0, 20.0), (t1, t2)]  # R, θ, n, τ_start

    # Fit the model parameters
    p = fit_loss_function(loss_function, search_range)

    # Calculate the area under the curve and root-mean-square error
    AUC = integrate(single_humped_function, p, 0, 20)
    RMSE = rmse(x[.!isnan.(x)], single_humped_function(t[.!isnan.(x)], p))

    # Save the fitted parameters to the result DataFrame
    df_result_tmp = hcat(
        DataFrame(df_data[i_data, :]),
        DataFrame(
            "P_R" => p[1],
            "P_theta" => p[2],
            "P_n" => p[3],
            "P_t0" => p[4],
            "AUC" => AUC,
            "RMSE" => RMSE,
            "N" => sum(.!isnan.(x))
        )
    )
    if isnothing(df_results)
        df_results = df_result_tmp
    else
        df_results = vcat(df_results, df_result_tmp)
    end

    # Create plot for the visual inspection
    tt = 0:0.01:20
    yy = single_humped_function(tt, p)
    fig, ax = subplots()
    ax.plot(t[.!isnan.(x)], x[.!isnan.(x)], "ko", label="Data", zorder=2)
    ax.plot(t[.!isnan.(x)], x[.!isnan.(x)], color="gray", label="Linear interpolation", zorder=1, linewidth=2)
    ax.plot(tt, yy, "k", label="Model fit", zorder=3, linewidth=2)
    ax.set_ylim(-0.1, 1.1)
    ax.legend()
    ax.set_title("\
        Label A=$(df_results[i_data, 1]); \
        Label T=$(df_results[i_data, 2]); \
        Label M=$(df_results[i_data, 3]); \
        Label P=$(df_results[i_data, 4]);\n\
        Estimated parameters: R=$(round(df_results[i_data, 11], digits=2)), \
        θ=$(round(df_results[i_data, 12], digits=2)), \
        n=$(round(df_results[i_data, 13], digits=2)), \
        t0=$(round(df_results[i_data, 14], digits=2)),\n\
        AUC=$(round(df_results[i_data, 15], digits=2)); \
        RMSE=$(round(df_results[i_data, 16], digits=2)); \
        N=$(df_results[i_data, 17])", loc="left")
    ax.set_xlabel("Time")
    ax.set_ylabel("Rel. eng.")
    fig.savefig("assets/$i_data.png")

end

save_data(df_results, "data/fitting_results.csv"; overwrite=true)
