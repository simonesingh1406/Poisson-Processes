estimate_Nt <- function(lambda, t, reps = 5000) {

  Ns <- numeric(reps)

  for (i in 1:reps) {

    sim_i <- simulate_poisson_process(lambda, t)

    Ns[i] <- tail(sim_i$counts, 1)
  }

  return(Ns)
}