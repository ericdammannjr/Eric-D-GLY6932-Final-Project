# Runge-Kutta 4th Order Numerical Solver Function

function RK4(f, u0, tspan, h, p)

    t0, tf = tspan
    ts = t0:h:tf
    n = length(ts)
    
    us = Vector{Vector{Float64}}(undef, n)
    us[1] = u0

    for i in 1:n-1

        t = ts[i]
        u = us[i]

        k1 = f(t, u, p)
        k2 = f(t + h/2, u .+ h/2 .* k1, p) 
        k3 = f(t + h/2, u .+ h/2 .* k2, p)
        k4 = f(t + h, u .+ h .* k3, p)

        us[i+1] = u .+ (h/6) .* (k1 .+ 2 .* k2 .+ 2 .* k3 .+ k4)

    end

    return us

end

# Lotka-Volterra Equations Function

function lotka_volterra(t, u, p)

    x, y = u
    dx = p[1] * x - p[2] * x * y 
    dy = p[3] * x * y - p[4] * y

    return [dx, dy]

end

# Log-Likelihood Function

function log_likelihood(x, y, tspan, h, p, σ, sample_points)

    x0, y0, α, β, δ, γ = p
    us = RK4(lotka_volterra, [x0, y0], tspan, h, [α, β, δ, γ])
    x_mod = [i[1] for i in us]
    y_mod = [i[2] for i in us]
    x_mod = x_mod[sample_points]
    y_mod = y_mod[sample_points]
    ll_x = sum(logpdf.(Normal(0, σ), x - x_mod))
    ll_y = sum(logpdf.(Normal(0, σ), y - y_mod))

    return ll_x + ll_y

end

# Markov Chain Monte Carlo Simulation With Metropolis-Hastings Algorithm Function

function MCMC(x, y, tspan, h, p, n, σ, proposal_std)

    current_p = p  
    current_ll = log_likelihood(x, y, tspan, h, p, σ, sample_points)
    chain = zeros(n, 6)

    for i in 1:n

        proposal = current_p .+ randn(6) .* proposal_std                            # Propose new parameters 

            if any(proposal .<= 0)                                                  # Ensure all proposed parameters are positive

                chain[i, :] = current_p

                continue

            end

        proposal_ll = log_likelihood(x, y, tspan, h, proposal, σ, sample_points)    # Calculate log-likelihood of proposed parameters


        log_accept_ratio = proposal_ll - current_ll                                 # Log accept ratio will be positive if the proposed parameters fit the data better than the current ones.

            if log(rand()) < log_accept_ratio                                       # Accept the proposed parameters with probability exp(log_accept_ratio)

                current_p = proposal
                current_ll = proposal_ll

            end

        chain[i, :] = current_p                                                     # Store the current parameters in the chain

    end

    return chain

end