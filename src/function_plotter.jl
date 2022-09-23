"""
`plot_single_humped_function`

Visualize parameter effects for the single-humped function.

**Returns**
- `fig`: PyPlot figure.

**Reference**
- Kaplan and Glass (1995) Understanding Nonlinear Dynamics.
"""
function plot_single_humped_function()

    p = [0.25, 4.0, 3.0, 0.0]

    fig, ax_arr = subplots(2, 2, figsize=(6, 6))
    t = 0:0.1:20
    
    p = [0.4, 4.0, 3.0, 0.0]
    for τ = [0, 5, 10]
        p[4] = τ
        x = single_humped_function(t, p)
        ax_arr[1, 1].plot(t, x, label="τ = $τ")
        ax_arr[1, 1].set_title("Time delay (τ)")
    end
    
    p = [0.4, 4.0, 3.0, 0.0]
    for a = [0.2, 0.4, 0.6]
        p[1] = a
        x = single_humped_function(t, p)
        ax_arr[1, 2].plot(t, x, label="R = $a")
        ax_arr[1, 2].set_title("Growth rate (R)")
    end
    
    p = [0.4, 4.0, 3.0, 0.0]
    for a = [2.0, 4.0, 6.0]
        p[2] = a
        x = single_humped_function(t, p)
        ax_arr[2, 1].plot(t, x, label="θ = $a")
        ax_arr[2, 1].set_title("Repression coefficient (θ)")
    end
    
    p = [0.4, 4.0, 3.0, 0.0]
    for a = [1.5, 3.0, 4.5]
        p[3] = a
        x = single_humped_function(t, p)
        ax_arr[2, 2].plot(t, x, label="n = $a")
        ax_arr[2, 2].set_title("Hill coefficient (n)")
    end
    
    for i = 1:2
        for j = 1:2
            ax_arr[i, j].set_ylim(0, 1.35)
            ax_arr[i, j].legend()
            ax_arr[i, j].set_xlabel("Weeks")
            ax_arr[i, j].set_ylabel("Population")
        end
    end
    fig.tight_layout()

    return fig

end
