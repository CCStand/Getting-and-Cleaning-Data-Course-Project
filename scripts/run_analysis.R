run_analysis <- function(){
  
  #Loading list of features [STEP 2/STEP 4]
  features <- read.delim("./data/UCI HAR Dataset/features.txt", header = FALSE, colClasses = "character")
  #Extracting names from the features (i.e. removing the numbers) [STEP 4]
  features <- strsplit(features$V1, " ")
  features <- sapply(features, "[", 2 )
  #Identify features that deal with mean or standard deviation [STEP 2]
  featuresToExtract <- grep("mean|std", features)
  #Get list of all variable names for the variables to extract [STEP 4]
  featureNames <- features[featuresToExtract]
  
  #Remove redundant data
  rm(features)
  
  #Loading activity labels [STEP 3]
  labels <- read.delim("./data/UCI HAR Dataset/activity_labels.txt", header = FALSE, colClasses = "character")
  #Extracting activity names [STEP 3]
  labels <- strsplit(labels$V1, " ")
  labels <- sapply(labels, "[", 2 )
  
  #Loading training data [STEP 1]
  subjectTrain <- read.delim("./data/UCI HAR Dataset/train/subject_train.txt", header = FALSE)
  xTrain <- read.fwf("./data/UCI HAR Dataset/train/X_train.txt", widths = rep(c(-1, 15), 561))
  yTrain <- read.delim("./data/UCI HAR Dataset/train/y_train.txt", header = FALSE, col.names = "Activity")
  
  #Loading test data [STEP 1]
  subjectTest <- read.delim("./data/UCI HAR Dataset/test/subject_test.txt", header = FALSE)
  xTest <- read.fwf("./data/UCI HAR Dataset/test/X_test.txt", widths = rep(c(-1, 15), 561))
  yTest <- read.delim("./data/UCI HAR Dataset/test/y_test.txt", header = FALSE, col.names = "Activity")
  
  #Removing all features that don't deal with mean or standard deviation [STEP 2]
  xTrainExtracted <- xTrain[,featuresToExtract]
  xTestExtracted <- xTest[,featuresToExtract]
  
  #Remove redundant data
  rm(featuresToExtract)
  
  #Change variable names to match feature names (with train/test prefixed as appropriate) [STEP 4]
  names(xTrainExtracted) <- featureNames
  names(xTestExtracted) <- featureNames
  
  #Remove redundant data
  rm(xTrain)
  rm(xTest)
  rm(featureNames)
  
  #Bind label column and subject column to x [STEP 1]
  trainData <- cbind(subjectTrain, yTrain, xTrainExtracted)
  testData <- cbind(subjectTest, yTest, xTestExtracted)
  
  #Remove redundant data
  rm(xTrainExtracted)
  rm(xTestExtracted)
  rm(yTrain)
  rm(yTest)
  rm(subjectTest)
  rm(subjectTrain)
  
  #Combine train and test data [STEP 1]
  tidyData <- rbind(trainData, testData)
  
  #Remove redundant data
  rm(trainData)
  rm(testData)
  
  #Rename subject column [STEP 4]
  library(dplyr)
  tidyData <- rename(tidyData, "Subject" = "V1")
  
  #Source function to convert activity number to activity name [STEP 3]
  source("./scripts/num_to_val.R")
  #Change Activity variable to give activity names [STEP 3]
  tidyData$Activity <- sapply(tidyData$Activity, num_to_val, labels)
  
  #Remove redundant data
  rm(labels)
  
  #Group by subject/activity [STEP 5]
  groupData <- group_by(tidyData, Subject, Activity)
  #Calculate means of each variable for each group [STEP 5]
  dataMeans <- summarise_all(groupData, mean)
  
  #Remove redundant data
  rm(groupData)
  
  #Save results to files
  write.table(tidyData, file = "./output/tidyData.txt")
  write.table(dataMeans, file = "./output/dataMeans.txt")
  
  #Remove remaining data
  rm(list =ls())
}