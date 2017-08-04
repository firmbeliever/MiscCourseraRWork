corr <- function(directory, threshhold = 0){
    files_full <- list.files(directory, full.names=TRUE)
    result <- vector("integer", 0)
    nobs <- complete("specdata")
    for (i in 1:332) {
        if (nobs[i,2] > threshhold){
            singFile <- na.omit(read.csv(files_full[i]))
            singResult <- cor(singFile[, "sulfate"], singFile[, "nitrate"])
            result <- c(result, singResult)
        }
    }
    result
}