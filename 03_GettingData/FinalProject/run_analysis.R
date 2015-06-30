## Create one R script called run_analysis.R that does the following:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names.
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
run_analysis <- function() {
  library(reshape)
  library(plyr)
  
  xTrain = read.table("./train/X_train.txt")
  yTrain = read.table("./train/y_train.txt")
  subjectTrain = read.table("./train/subject_train.txt")
  xTest = read.table("./test/X_test.txt")
  yTest = read.table("./test/y_test.txt")
  subjectTest = read.table("./test/subject_test.txt")
  features = read.table("./features.txt")
  headings = features$V2
  colnames(xTrain) = headings
  colnames(xTest) = headings
  yTest <- rename(yTest, c(V1="activity"))
  yTrain <- rename(yTrain, c(V1="activity"))
  activity  = read.table("./activity_labels.txt")
  activityLabels = tolower(levels(activity$V2))
  yTrain$activity = factor(
    yTrain$activity,
    labels = activityLabels
  )
  yTest$activity = factor(
    yTest$activity,
    labels = activityLabels
  )
  subjectTrain <- rename(subjectTrain, c(V1="subjectid"))
  subjectTest <- rename(subjectTest, c(V1="subjectid"))
  fullTrain = cbind(xTrain, subjectTrain, yTrain)
  fullTest = cbind(xTest, subjectTest, yTest)
  fullData = rbind(fullTrain, fullTest)
  pattern = "mean|std|subjectid|activity"
  tidyData = fullData[,grep(pattern , names(fullData), value=TRUE)]
  cleanNames = gsub("\\(|\\)|-|,", "", names(tidyData))
  names(tidyData) <- tolower(cleanNames)
  result = ddply(tidyData, .(activity, subjectid), numcolwise(mean))
}