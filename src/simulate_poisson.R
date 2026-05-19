simulate_poisson_process <- function(lambda, Tmax) {

  t <- 0
  N <- 0

  times <- c(0)
  counts <- c(0)

  while (t < Tmax) {

    wait <- rexp(1, rate = lambda)
    t <- t + wait

    if (t > Tmax) break

    N <- N + 1

    times <- c(times, t)
    counts <- c(counts, N)
  }

  return(list(times = times,
              counts = counts))
}