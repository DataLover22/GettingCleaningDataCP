---
  output: pdf_document
---
#  "Getting and Cleaning Data / Course Project"
  
# Get Data: Read table Subject_test.txt, Y_test.txt and X_test.txt, Subject_train.txt, Y_train.txt and X_train.txt into R. 
  
#Set the current working directory.
```{r}
setwd("C:/Coursera/GettingCleaningData")
```
#Create data folder to save downloaded data
```{r}
if (!file.exists("data")) {
  dir.create("data")
}
```

#Download the zip file from the web
```{r}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
```
#Save the zip file in the destinated directory
```{r}
download.file(fileUrl, destfile = "./data/TrainTestRawData.zip")
```
#Unzip the file
```{r}
unzip(zipfile="./data/TrainTestRawData.zip",exdir="./data")
```

#Read train related data
```{r}
trainX <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
trainY <- read.table("./data/UCI HAR Dataset/train/Y_train.txt")
trainSubject <- read.table("./data/UCI HAR Dataset/train/Subject_train.txt")
```

#Read test related data
```{r}
testX <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
testY <- read.table("./data/UCI HAR Dataset/test/Y_test.txt")
testSubject <- read.table("./data/UCI HAR Dataset/test/Subject_test.txt")
```


#Combine Subject_train, Y_train and X_train into one file called traindata. Combine Subject_test, Y_test and X_test into one file called testdata.
```{r}
traindata<-cbind(trainSubject,trainY,trainX)
testdata<-cbind(testSubject,testY,testX)
```

#Merge the traindata and testdata into one file called MergeTrainTestData
```{r}
MergeTrainTestData<-rbind(traindata,testdata)
```


#Check merged data dimension and have a look at the data
```{r}
dim(MergeTrainTestData)
head(MergeTrainTestData,5)
summary(MergeTrainTestData)
str(MergeTrainTestData)
```

#Install packages for manipulating data
```{r}
library(dplyr)
library(tidyr)
library(RSQLite)
require(sqldf)
```
# Read features.txt into R as a data frame to use as the column names
```{r}
featuresdf <- read.table("./data/UCI HAR Dataset/features.txt")
```

# Read activity.txt into R as a data frame to use as the descriptive activity names
```{r}
activitylabel <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
```


#Extracts only the measurements on the mean and standard deviation for each measurement.
#Select columns with key words mean or std for the measurements. 
#The result is consists of 2 columns. The 1st column is a numeric value, which has a linear relationship with the numeric values in the column names of MergeTrinTestData. The 2nd column is a string, which represents the statistics of the measurements.
```{r}
MeanSTDdf <- sqldf("select * from featuresdf where V2 like '%-mean()%' or V2 like '%-std()%'")
```

#Generate the column sequence to select columns with mean or std from mergerd train and test data. 
#It includes the 1st column as ID, the 2nd column as activity types and those columns which are related to mean and standard deviation of measurements. For example, in MeanSTDdf data frame, if V2="tBodyAcc-std()-X" and the corresponding V1 value is "1", we will select column V1 in the MergeTrainTestData data frame.
```{r}
colseq<-c(1,2,MeanSTDdf$V1+2)
Tidydt<-MergeTrainTestData[,colseq]
```


#Appropriately labels the data set with descriptive names.
```{r}
TidydtCloNames <- as.vector(c("ID", "ActivityType",as.vector(MeanSTDdf$V2)))
colnames(Tidydt) <- TidydtCloNames
```

#Rename activity type with descriptive names
```{r}
Tidydt$ActivityType <- ordered(Tidydt$ActivityType, levels = c(1,2,3,4,5,6), labels = activitylabel$V2)
```

#Group by ID and Activity Tpye, calculate the mean of each variable.
```{r}
bySubActdf<-group_by(Tidydt,ID, ActivityType)
TidyData<-summarise_each(bySubActdf,funs(mean))
```

#Output TidyData 
```{r}
write.table(TidyData, file="TidyData.txt", row.names=FALSE)
```






