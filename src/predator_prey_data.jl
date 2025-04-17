# Importing Necessary Packages

using CSV, DataFrames, Distributions, Random 

# Importing Additional Functions

include("fns/functions.jl")     # The functions.jl file contains the RK4 and lotka_volterra functions

# Setting Random Seed for Reproducibility

Random.seed!(54) 

# Initial Prey and Predator Densities

u0 = [5, 5]       # Initial conditions for prey and predator densities respectively

# Model Parameter Values

α = 1.1         # Prey birth rate coefficient
β = 0.4         # Coefficient for the effect of the presence of predators on the prey death rate
δ = 0.1         # Coefficient for the effect of the presence of prey on the predator birth rate
γ = 0.4         # Predator death rate coefficient
p = [α,β,δ,γ]   

# Time Span

tspan = [0.0, 50.0]     # [t0, tf] where t0 is the initial time and tf is the final time

# Time Step Size

h = 0.01 

# Time Vector

ts = tspan[1]:h:tspan[2] 

# Model Solution

us = RK4(lotka_volterra, u0, tspan, h, p)   # Solving the Lotka-Volterra equations using the Runge-Kutta 4th order method
true_x = [i[1] for i in us]                 # Prey density over time
true_y = [i[2] for i in us]                 # Predator density over time
true_values = [u0[1], u0[2], α, β, δ, γ]          # True values of the model parameters

# Generating Observed Data Samples 

n_tps = length(ts)
n_samples = Int(ceil(n_tps*0.05)) 
data_samples = rand(1:n_tps, n_samples)             # Randomly selecting 5 % of the time point indices from the time vector
x_noise = rand(Normal(0, 1), length(data_samples))  # Generating random noise for prey density data
y_noise = rand(Normal(0, 1), length(data_samples))  # Generating random noise for predator density data
t_observed = ts[data_samples]
x_observed = true_x[data_samples] + x_noise         # Adding noise to the observed prey density data
y_observed = true_y[data_samples] + y_noise         # Adding noise to the observed predator density data
x_obs = fill(NaN, length(ts))
x_obs[data_samples] = x_observed                    # Observed prey density data
y_obs = fill(NaN, length(ts))
y_obs[data_samples] = y_observed                    # Observed predator density data

# Writing Data to CSV File

df = DataFrame(t = ts, x = x_obs, y = y_obs)    # Adding data to a DataFrame
CSV.write("data/predator_prey_data.csv", df)    # Writing the DataFrame to a CSV file

# The CSV file will contain the time points, observed prey density, and observed predator density data