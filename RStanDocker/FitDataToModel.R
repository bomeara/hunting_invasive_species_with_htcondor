## load required packages and data
library(rstan)
print(getwd())
print(list.files())
print(commandArgs(trailingOnly = TRUE))

d <- read.csv("simulatedData.csv")

## HTCondor iteration
n <- as.numeric(commandArgs(trailingOnly = TRUE))
## HTCondor lives in zero-based index world, but R is in one-based world
## Next line makes sure it the answer is 1 or 2 
n <-n %% 2 + 1
print("n is")
print(n)
## Format data for RStan
stanData <- list(x = d$x[ d$Index == n],
                 y = d$y[ d$Index == n],
                 N = length(d$y[ d$Index == n])
                 )

out <- stan(file = 'model.stan', data = stanData, iter = 2000, chains = 4)

outToSave <- data.frame(summary(out)$summary)
outToSave$ParameterNames <- rownames(outToSave)
outToSave$Index <- n

write.csv(x = outToSave, file = "parEst.csv")
