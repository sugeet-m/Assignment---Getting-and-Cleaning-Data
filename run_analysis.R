## Set up the work environment and download data

library(data.table)
library(dplyr)

if(!file.exists("./project4"))
{    dir.create("./project4")
}
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl, destfile = "./project4/data.zip", method = "curl")
unzip("data.zip", exdir = "./project4")

## Load training and testing data

x_train <- read.table("./project4/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./project4/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./project4/UCI HAR Dataset/train/subject_train.txt")

x_test <- read.table("./project4/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./project4/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./project4/UCI HAR Dataset/test/subject_test.txt")

## Adding column names
features <- read.table("./project4/UCI HAR Dataset/features.txt")
colnames(x_train) <- features$V2
colnames(x_test) <- features$V2

colnames(y_train) <- "activity"
colnames(y_test) <- "activity"

colnames(subject_train) <- "subjectID"
colnames(subject_test) <- "subjectID"

## Add factor levels to activity in y_* data
activities <- read.table("./project4/UCI HAR Dataset/activity_labels.txt")
y_train$activity <- factor(y_train$activity, labels = activities$V2)
y_test$activity <- factor(y_test$activity, labels = activities$V2)

## Merge training and testing data
train <- cbind(subject_train, y_train, x_train)
test <- cbind(subject_test, y_test, x_test)
merged_data <- rbind(train, test)

## Extracting index columns and columns with mean and std in variable names
indexcols<-merged_data[,(1:2)]
meancols<-merged_data[,grep('mean()', names(merged_data), fixed=TRUE)]
stdcols<-merged_data[,grep('std()', names(merged_data), fixed=TRUE)]

selected_data<-cbind(indexcols,meancols,stdcols)

## Provide descriptive column names 
## (I do not understand what these variables are so I only changed a few obvious ones)
names(selected_data)<-gsub("-mean()","MeanValue",names(selected_data), fixed=TRUE)
names(selected_data)<-gsub("-std()","StandardDeviation",names(selected_data), fixed=TRUE)
names(selected_data)<-gsub("-mad()","MedianAbsoluteDeviation ",names(selected_data), fixed=TRUE)
names(selected_data)<-gsub("-max()","MaximumValue",names(selected_data), fixed=TRUE)
names(selected_data)<-gsub("-min()","MinimumValue",names(selected_data), fixed=TRUE)
names(selected_data)<-gsub("-sma()","SignalMagnitudeArea",names(selected_data), fixed=TRUE)
names(selected_data)<-gsub("-energy()","EnergyMeasure",names(selected_data), fixed=TRUE)
names(selected_data)<-gsub("-iqr()","InterquartileRange ",names(selected_data), fixed=TRUE)

## Create and save tidy data set
tidy_data <- selected_data %>% group_by(subjectID, activity) %>% summarise_all(mean)
write.table(tidy_data, file="./project4/TidyData.txt", row.name=FALSE, col.names=TRUE)
