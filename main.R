source("src/simulate_poisson.R")

set.seed(123)

lambda <- 2
Tmax <- 5

sim <- simulate_poisson_process(lambda, Tmax)

png("plots/poisson_trajectory.png",
    width = 800,
    height = 600)

plot(sim$times,
     sim$counts,
     type = "s",
     lwd = 2,
     col = "steelblue",
     xlab = "Time",
     ylab = expression(N[t]),
     main = "Simulated Poisson Process")

dev.off()
