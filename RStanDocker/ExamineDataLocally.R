## load required packages and data
library(ggplot2) # used for plotting
library(data.table) # used for manhandling data

## Read in original data
d <- fread("simulatedData.csv")
## Summarize to get parameter values

parValues <- d[ , list(intercept = mean(KnownIntercept),
                       slope = mean(KnownSlope),
                       stdDev = mean(stdDev)), by = Index]
setkey( parValues, "Index")

## Read in simulated data
allFiles <- list.files()
parEstFiles <- allFiles[grep( "parEst", allFiles)]

myFiles <- lapply(parEstFiles, fread)
estValues <- rbindlist(myFiles)
setkey(estValues, Index)

## Merge known and recovered values
allValues <- estValues[ parValues]
setnames(allValues, "V1", "Parameter")

allValues[ , Intercept := paste0("Intercept ", intercept)]
allValues[ , Slope     := paste0("Slope ", slope)]
allValues[ , Sigma     := paste0("Sigma ", stdDev)]
allValues[ , IndexPlot := paste0("Index ", Index)]

ParEstimates <- ggplot(allValues, aes(x = Slope, y = mean, color = IndexPlot)) +
    geom_point(size = 1.5) +
    geom_linerange(aes(ymin = X2.5., ymax = X97.5.)) +
    geom_linerange(aes(ymin = X25., ymax = X75.), size = 1.5) +
    ## coord_flip() +
    theme_minimal() +
    facet_grid( Parameter ~ ., scales = 'free_y')
ggsave("recoveredParameters.pdf", ParEstimates, width = 4, height = 6)
