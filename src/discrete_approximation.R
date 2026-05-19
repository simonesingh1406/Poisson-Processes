simulate_discrete_poisson <- function(lambda, T, eps) {

  K <- ceiling(T / eps)

  N <- numeric(K + 1)

  t_grid <- seq(0, K) * eps

  for (k in 1:K) {

    Y <- rbinom(1,
                size = 1,
                prob = lambda * eps)

    N[k + 1] <- N[k] + Y
  }

  list(times = t_grid,
       counts = N)
}

compare_distribution <- function(lambda,
                                 T,
                                 eps,
                                 nMC = 5000) {

  NT <- numeric(nMC)

  for (i in 1:nMC) {

    sim <- simulate_discrete_poisson(lambda,
                                     T,
                                     eps)

    NT[i] <- tail(sim$counts, 1)
  }

  return(NT)
}
