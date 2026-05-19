simulate_inhom_poisson_thinning <- function(lambda_fun,
                                            T,
                                            M = NULL,
                                            grid_n = 2000) {

  if (is.null(M)) {

    ts_grid <- seq(0,
                   T,
                   length.out = grid_n)

    M <- 1.05 * max(lambda_fun(ts_grid))
  }

  t <- 0

  out <- numeric(0)

  repeat {

    t <- t + rexp(1, rate = M)

    if (t > T) break

    if (runif(1) < lambda_fun(t) / M)
      out <- c(out, t)
  }

  sort(out)
}

lambda_periodic <- function(t) {

  2 + 1.5 * sin(2 * pi * t / 5)
}