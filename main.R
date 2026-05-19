source("src/simulate_poisson.R")
source("src/monte_carlo_validation.R")
source("src/discrete_approximation.R")
source("src/inhomogeneous_poisson_thinning.R")

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


# ------------------------------------------------
# Experiment 3
# Discrete-Time Approximation
# ------------------------------------------------

eps_list <- c(0.5, 0.1, 0.01)

for (eps in eps_list) {

  sim_disc <- simulate_discrete_poisson(lambda = 2,
                                        T = 5,
                                        eps = eps)

  png(paste0("plots/discrete_path_eps_",
             eps,
             ".png"),
      width = 900,
      height = 600)

  plot(sim_disc$times,
       sim_disc$counts,
       type = "s",
       lwd = 2,
       col = "darkgreen",
       xlab = "Time",
       ylab = expression(hat(N)[t]),
       main = paste("Discrete Approximation (eps =",
                    eps,
                    ")"))

  dev.off()
}

# ------------------------------------------------
# Distributional convergence
# ------------------------------------------------

eps_test <- c(0.5, 0.1, 0.01)

for (eps in eps_test) {

  Ns <- compare_distribution(lambda = 2,
                             T = 5,
                             eps = eps)

  min_N <- floor(min(Ns))
  max_N <- ceiling(max(Ns))

  breaks <- seq(min_N - 0.5,
                max_N + 0.5,
                by = 1)

  k <- min_N:max_N

  png(paste0("plots/distribution_eps_",
             eps,
             ".png"),
      width = 900,
      height = 600)

  hist(Ns,
       breaks = breaks,
       probability = TRUE,
       col = "lightgray",
       border = "white",
       main = paste("Distribution of N(T), eps =",
                    eps),
       xlab = "N(T)")

  points(k,
         dpois(k, 10),
         col = "red",
         pch = 19)

  lines(k,
        dpois(k, 10),
        col = "red",
        lwd = 2)

  dev.off()
}


# ------------------------------------------------
# Experiment 4
# Inhomogeneous Poisson Processes
# ------------------------------------------------

T <- 5

png("plots/inhomogeneous_paths.png",
    width = 900,
    height = 600)

plot(NULL,
     xlim = c(0, T),
     ylim = c(0, 15),
     xlab = "Time",
     ylab = "N(t)",
     main = "Inhomogeneous Poisson Process Trajectories")

for (i in 1:5) {

  times <- simulate_inhom_poisson_thinning(lambda_periodic,
                                           T)

  if (length(times) == 0) {

    lines(c(0, T),
          c(0, 0),
          type = "s")
  }

  else {

    step_x <- sort(c(0, times, T))

    step_y <- c(0,
                1:length(times),
                length(times))

    lines(step_x,
          step_y,
          type = "s")
  }
}

dev.off()

png("plots/intensity_function.png",
    width = 900,
    height = 600)

ts_plot <- seq(0,
               T,
               length.out = 1000)

plot(ts_plot,
     lambda_periodic(ts_plot),
     type = "l",
     lwd = 2,
     col = "blue",
     main = expression(paste("Intensity ", lambda(t))),
     xlab = "Time",
     ylab = expression(lambda(t)))

dev.off()