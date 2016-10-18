nObs <- 10
d <- data.frame(x = 1:nObs, y = rnorm(n = nObs, mean = 1, sd = 2))
write.csv(file = "/opt/rerickson/xout.csv", x = d, row.names = FALSE)
