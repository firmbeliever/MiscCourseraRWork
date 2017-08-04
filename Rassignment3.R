best <- function(state, outcome){
    data <- read.csv("outcome-of-care-measures.csv", na.strings = "Not Available", stringsAsFactors = FALSE)
    outIndex <- 0
    if (outcome == "heart attack")
    {
        outIndex <- 11
    }
    else if (outcome == "heart failure"){
        outIndex <- 17
    }
    else if (outcome == "pneumonia"){
        outIndex <- 23
    }
    else{
        stop("invalid outcome")
    }
    my_data <- data[, c(2, 7, outIndex)]
    names(my_data) <- c("hospital", "state", "outcome")
    ##complete.cases(my_data)
    my_data <- na.omit(my_data)
    my_data <- my_data[order(my_data$state, my_data$outcome, my_data$hospital), ]
    my_data <- my_data[which(my_data$state == state), ]
    my_data[1, 1]
}

rankhospital <- function(state, outcome, num = "best"){
    data <- read.csv("outcome-of-care-measures.csv", na.strings = "Not Available", stringsAsFactors = FALSE)
    outIndex <- 0
    if (outcome == "heart attack")
    {
        outIndex <- 11
    }
    else if (outcome == "heart failure"){
        outIndex <- 17
    }
    else if (outcome == "pneumonia"){
        outIndex <- 23
    }
    else{
        stop("invalid outcome")
    }
    my_data <- data[, c(2, 7, outIndex)]
    names(my_data) <- c("hospital", "state", "outcome")
    ##complete.cases(my_data)
    my_data <- na.omit(my_data)
    my_data <- my_data[order(my_data$state, my_data$outcome, my_data$hospital), ]
    my_data <- my_data[which(my_data$state == state), ]
    rankIndex <- 0
    if (num == "best") rankIndex <- 1
    else if (num == "worst") rankIndex <- nrow(my_data)
    else rankIndex <- num
    my_data[rankIndex, 1]
}

hospbystate <- function(data, num){
    rankIndex <- 0
    if (num == "best") rankIndex <- 1
    else if (num == "worst") rankIndex <- nrow(data)
    else rankIndex <- num
    
    data[rankIndex, c(1)]
}

rankall <- function(outcome, num = "best"){
    data <- read.csv("outcome-of-care-measures.csv", na.strings = "Not Available", stringsAsFactors = FALSE)
    outIndex <- 0
    if (outcome == "heart attack") outIndex <- 11
    else if (outcome == "heart failure") outIndex <- 17
    else if (outcome == "pneumonia") outIndex <- 23
    else stop("invalid outcome")
    
    my_data <- data[, c(2, 7, outIndex)]
    names(my_data) <- c("hospital", "state", "outcome")
    ##complete.cases(my_data)
    my_data <- na.omit(my_data)
    my_data <- my_data[order(my_data$state, my_data$outcome, my_data$hospital), ]
    
    splitData <- split(my_data, my_data$state)
    sapplyresult <- sapply(splitData, hospbystate, num)
    states <- names(sapplyresult)
    final <- data.frame(sapplyresult, states, row.names = states)
    final
}