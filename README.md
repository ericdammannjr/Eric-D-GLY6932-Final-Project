## Repository Overview

This repository contains scripts for fitting a simple Lotka-Volterra model to noisy data using Bayesian inference. The scripts generate observed data, perform a Markov Chain Monte Carlo (MCMC) simulation with Metropolis-Hastings Algorithm, and produce visualizations of the results.

### Repository Structure

Key Files: 

- **`src/predator_prey_data.jl`**: Generates synthetic predator-prey data and saves it to `data/predator_prey_data.csv`.
- **`src/bayesian_analysis.jl`**: Performs Bayesian analysis on the generated data and produces visualizations.
- **`src/fns/functions.jl`**: Contains utility functions such as the Runge-Kutta 4th order method and the Lotka-Volterra equations.

### Prerequisites

Ensure you have Julia installed on your system. Download it here: [text](https://julialang.org/install/)

Clone the repository on your local computer by entering the following command into the terminal:

```
git clone https://github.com/ericdammannjr/Eric-D-GLY6932-Final-Project
```

### Installing Dependencies

Run the following commands in the Julia REPL to install the required packages:

```julia
using Pkg
Pkg.activate("deps")
Pkg.instantiate()
```






