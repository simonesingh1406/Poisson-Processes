# Poisson-Processes

## Simulation and Statistical Properties of Poisson Processes

### Overview

This project explores simulation and statistical properties of homogeneous Poisson processes using R.

The work investigates:
- stochastic event arrivals,
- exponential waiting times,
- empirical convergence of mean and variance,
- trajectory behaviour,
- discrete approximations to continuous-time jump processes.

Applications to quantitative finance and stochastic modelling are also discussed.

---

### Motivation

Poisson processes are foundational stochastic models for random event arrivals.

They appear in:
- queueing systems,
- communication networks,
- reliability modelling,
- market order arrivals,
- jump-diffusion models,
- market microstructure in quantitative finance.

The objective of this project is to simulate Poisson trajectories and empirically verify key theoretical properties.

---

### Theory

For a Poisson counting process:

N_t ~ Poisson(lambda * t)

The waiting times between jumps are exponentially distributed.

Key theoretical properties:
- E[N_t] = lambda * t
- Var(N_t) = lambda * t

---

### Simulated Trajectory

![Poisson Trajectory](plots/poisson_trajectory.png)

---

### Financial Connection

In quantitative finance, Poisson processes are used to model:
- market order arrivals,
- jump events,
- trade execution dynamics,
- high-frequency transaction arrivals,
- jump-diffusion asset price models.

They form an important foundation for stochastic modelling and market microstructure research.