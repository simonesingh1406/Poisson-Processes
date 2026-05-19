source("src/simulate_poisson.R")
source("src/monte_carlo_validation.R")

set.seed(123)

# Parameters
lambda <- 2
Tmax <- 5

# Simulate trajectory
sim <- simulate_poisson_process(lambda, Tmax)

# ------------------------------------------------
# Plot trajectory
# ------------------------------------------------

png("plots/poisson_trajectory.png",
    width = 900,
    height = 600)

plot(sim$times,
     sim$counts,
     type = "s",
     lwd = 2,
     col = "steelblue",
     xlab = "Time",
     ylab = expression(N[t]),
     main = "Homogeneous Poisson Process Trajectory")

dev.off()

# ------------------------------------------------
# Waiting time analysis
# ------------------------------------------------

waiting_times <- diff(sim$times)

empirical_mean_wait <- mean(waiting_times)
theoretical_mean_wait <- 1 / lambda

cat("Empirical waiting time mean:",
    empirical_mean_wait, "\n")

cat("Theoretical waiting time mean:",
    theoretical_mean_wait, "\n")

# ------------------------------------------------
# Monte Carlo validation
# ------------------------------------------------

t0 <- 5

Ns <- estimate_Nt(lambda,
                  t0,
                  reps = 5000)

empirical_mean <- mean(Ns)
empirical_variance <- var(Ns)

cat("\nEmpirical mean of N(t):",
    empirical_mean, "\n")

cat("Theoretical mean:",
    lambda * t0, "\n")

cat("\nEmpirical variance of N(t):",
    empirical_variance, "\n")

cat("Theoretical variance:",
    lambda * t0, "\n")

# ------------------------------------------------
# Histogram
# ------------------------------------------------

png("plots/poisson_histogram.png",
    width = 900,
    height = 600)

hist(Ns,
     breaks = 30,
     probability = TRUE,
     col = "lightblue",
     border = "white",
     main = "Monte Carlo Distribution of N(t)",
     xlab = "N(t)")

dev.off()