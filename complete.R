complete <- function(directory, id = 1:332){
    files_full <- list.files(directory, full.names=TRUE)
    result <- data.frame()
    for (i in id) {
        singFile <- na.omit(read.csv(files_full[i]))
        result <- rbind(result, c(i, length(singFile$sulfate)))
    }
    names(result) <- c("id", "nobs")
    result
}