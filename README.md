# Getting-and-Cleaning-Data-Course-Project

## Folder/File structure
The project has 4 subdirectories as listed below:
data - This is where the original, non-processed data is stored
documentation - This is where the codebook is stored
output - This is where the datasets created by the scripts are stored
scripts - This is where the data-processing scripts are stored

## Finding the data files to download
The files contained within the data directory were downloaded from the following URL:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Running the scripts
With the directory set to the root folder, you will need to type the following commands to load and run the scripts:

source("./scripts/num_to_val.R")
source("./scripts/run_analysis.R")
run_analysis()

Running the run_analysis should create two files in the 'output' folder named 'tidyData.txt' and 'dataMeans.txt'. Further explanation of the contents of these files can be found in the codebook. The scripts are commented to show detail how they work.

NOTE: 'tidyData.txt' and 'dataMeans.txt' are already provided in the output folder, but running the scripts allows you to reproduce the results on your own machine (this will overwrite the files currently in the 'output' folder).

## Viewing the data
You can view the result datasets with the following commands:

tidyData <- read.table("./output/tidyData.txt", header = TRUE)
View(tidyData)

dataMeans <- read.table("./output/dataMeans.txt", header = TRUE)
View(dataMeans)