## simulate data to be recovered with linear regression

## Number of replicates, treatments, and predictor (x) range
nReps <- 10 # number of repliciates
nTreat <- 2
xMin <- 0
xMax <- 10
xBy <- 1

## x-values and names
sequence <- seq(from = xMin, to = xMax, by = xBy)
treatmentNames = letters[1:nTreat]

## Intercepts for each X
treatmentIntercept = c(0, 5)
names(treatmentIntercept) <- treatmentNames

## Slope
slopes = c( -2, 3)
names(slopes) <- treatmentNames

## Standard deviations
interceptSigma <- 0.5

## Create data
d <- data.frame(x =
                    rep(sequence, each = nReps, times = nTreat),
                x2name =
                    rep( treatmentNames, each = length(sequence) * nReps)
                )

for( index in treatmentNames){
    d$InterceptWithError[d$x2name == index] <- rnorm(n = length(sequence) * nReps, mean = treatmentIntercept[index],
                                          sd = interceptSigma)
    d$KnownIntercept[d$x2name == index] <- treatmentIntercept[index]
    d$KnownSlope[d$x2name == index] <- slopes[index]
}
head(d)

d$y <- d$InterceptWithError + d$x * d$KnownSlope

## Plot to see how it looks
pdf("simulatedData.pdf")
plotColors <- c("red", "blue", "black", "seagreen", "navyblue")[1:nTreat]
names(plotColors) <- treatmentNames
with(d, plot(x = x, y = y, type = 'n'))
for( index in treatmentNames){
    with(d[ d$x2name == index, ],
         points(x = x, y = y, col = plotColors[index]))
}
dev.off()
## Examine the outputs with a simple linear regression
sink("lm_of_simulated_data.txt")
summary(lm(y ~ x * x2name, data = d))
sink()

d$Index <- as.numeric(d$x2name)
d$stdDev = interceptSigma
write.csv(file = "simulatedData.csv", x = d, row.names = FALSE)
