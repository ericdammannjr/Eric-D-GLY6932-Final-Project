## Repository Overview

This repository contains scripts for fitting a Lotka-Volterra model to noisy predator prey data using Bayesian inference. The scripts generate observed data, perform a Markov Chain Monte Carlo (MCMC) simulation with Metropolis-Hastings Algorithm, and produce visualizations of the results.

Key Files: 

- `src/predator_prey_data.jl`: Generates synthetic predator-prey data and saves it to `data/predator_prey_data.csv`.
- `src/bayesian_analysis.jl`: Performs Bayesian analysis on the generated data and produces visualizations which are saved to `figs/`.
- `src/fns/functions.jl`: Contains additional utility functions such as the Runge-Kutta 4th order method and the Lotka-Volterra equations.

### Install Julia

Ensure you have Julia installed on your system. Download it here: [Install Julia](https://julialang.org/install/)

### Clone this Repository

Clone this repository on by entering the following command into your computers terminal:

```
git clone https://github.com/ericdammannjr/Eric-D-GLY6932-Final-Project
```

### Instantiate Dependencies

Run the following commands in the Julia REPL to install the required packages:

```julia
using Pkg
Pkg.activate("deps")
Pkg.instantiate()
```

### Generate Observed Data

First run `src/predator_prey_data.jl`. This script will generate noisy predator prey data that will be saved to `data/predator_prey_data.csv`.

### Perform Bayesian Analysis

Next, run `src/bayesian_analysis.jl`. This script will utilize the functions defined in `src/fns/functions.jl` fit a lotka-volterra model to the data saved to `data/predator_prey_data.csv` using MCMC.

**THIS SCRIPT MAY TAKE UP TO 10 MINUTES TO RUN**

Upon completion, it will output the following message in the terminal:

```
MCMC Simulation Completed! All figures were saved to /figs folder.
```

and 4 figures will be generated in the `/figs` folder.

### Visualize Results







