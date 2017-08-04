## download the zip into the working directory, will overwrite with the latest if it already exists
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "tidyData.zip")

## extract the files into a folder in the working directory, will overwrite if it already exists
unzip("tidyData.zip", overwrite = TRUE, exdir = "tidyData")

## create platform-independent file paths for all 6 raw data files
rawTrainSubjectFilePath <- file.path("tidyData", "UCI HAR Dataset", "train", "subject_train.txt")
rawTrainXFilePath <- file.path("tidyData", "UCI HAR Dataset", "train", "X_train.txt")
rawTrainYFilePath <- file.path("tidyData", "UCI HAR Dataset", "train", "y_train.txt")
rawTestSubjectFilePath <- file.path("tidyData", "UCI HAR Dataset", "test", "subject_test.txt")
rawTestXFilePath <- file.path("tidyData", "UCI HAR Dataset", "test", "X_test.txt")
rawTestYFilePath <- file.path("tidyData", "UCI HAR Dataset", "test", "y_test.txt")

## load the raw data into memory
rawTrainSubject <- read.table(rawTrainSubjectFilePath)
rawTrainX <- read.table(rawTrainXFilePath)
rawTrainY <- read.table(rawTrainYFilePath)
rawTestSubject <- read.table(rawTestSubjectFilePath)
rawTestX <- read.table(rawTestXFilePath)
rawTestY <- read.table(rawTestYFilePath)

## combine the train and test data sets
combSubject <- rbind(rawTrainSubject, rawTestSubject)
combX <- rbind(rawTrainX, rawTestX)
combY <- rbind(rawTrainY, rawTestY)

## reduce the X set to just the mean and std features desired
colsToSelect <- c(1,2,3,4,5,6,41,42,43,44,45,46,81,82,83,84,85,86,121,122,123,124,125,126,161,162,163,164,165,166,201,202,214,215,227,228,240,241,253,254,266,267,268,269,270,271,345,346,347,348,349,350,424,425,426,427,428,429,503,504,516,517,529,530,542,543)
combFiltered <- select(combX, colsToSelect)

## create new column on combY data frame that holds mapped activity names
combY$labeled <- mapvalues(combY$V1, c(1,2,3,4,5,6), c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING"))

## combine the 3 data frames (the subject, filtered feature data, and activity name values)
combFinal <- cbind(combSubject, combFiltered, combY$labeled)

## give meaningful names to the variables
colNames <- c("Subject", 
           "tBodyAccMeanX", 
           "tBodyAccMeanY", 
           "tBodyAccMeanZ", 
           "tBodyAccStdX", 
           "tBodyAccStdY", 
           "tBodyAccStdZ", 
           "tGravityAccMeanX", 
           "tGravityAccMeanY", 
           "tGravityAccMeanZ", 
           "tGravityAccStdX", 
           "tGravityAccStdY", 
           "tGravityAccStdZ", 
           "tBodyAccJerkMeanX", 
           "tBodyAccJerkMeanY", 
           "tBodyAccJerkMeanZ", 
           "tBodyAccJerkStdX", 
           "tBodyAccJerkStdY", 
           "tBodyAccJerkStdZ", 
           "tBodyGyroMeanX", 
           "tBodyGyroMeanY", 
           "tBodyGyroMeanZ", 
           "tBodyGyroStdX", 
           "tBodyGyroStdY", 
           "tBodyGyroStdZ", 
           "tBodyGyroJerkMeanX", 
           "tBodyGyroJerkMeanY", 
           "tBodyGyroJerkMeanZ", 
           "tBodyGyroJerkStdX", 
           "tBodyGyroJerkStdY", 
           "tBodyGyroJerkStdZ", 
           "tBodyAccMagMean", 
           "tBodyAccMagStd", 
           "tGravityAccMagMean", 
           "tGravityAccMagStd", 
           "tBodyAccJerkMagMean", 
           "tBodyAccJerkMagStd", 
           "tBodyGyroMagMean", 
           "tBodyGyroMagStd", 
           "tBodyGyroJerkMagMean", 
           "tBodyGyroJerkMagStd", 
           "fBodyAccMeanX", 
           "fBodyAccMeanY", 
           "fBodyAccMeanZ", 
           "fBodyAccStdX", 
           "fBodyAccStdY", 
           "fBodyAccStdZ", 
           "fBodyAccJerkMeanX", 
           "fBodyAccJerkMeanY", 
           "fBodyAccJerkMeanZ", 
           "fBodyAccJerkStdX", 
           "fBodyAccJerkStdY", 
           "fBodyAccJerkStdZ", 
           "fBodyGyroMeanX", 
           "fBodyGyroMeanY", 
           "fBodyGyroMeanZ", 
           "fBodyGyroStdX", 
           "fBodyGyroStdY", 
           "fBodyGyroStdZ", 
           "fBodyAccMagMean", 
           "fBodyAccMagStd", 
           "fBodyBodyAccJerkMagMean", 
           "fBodyBodyAccJerkMagStd", 
           "fBodyBodyGyroMagMean", 
           "fBodyBodyGyroMagStd", 
           "fBodyBodyGyroJerkMagMean", 
           "fBodyBodyGyroJerkMagStd", 
           "Activity"
)
names(combFinal) <- colNames

## group the final data frame by Subject and Activity, take the mean of all other columns
grouped <- group_by(combFinal, Subject, Activity)
tidyMeans <- summarise_all(grouped, mean)
