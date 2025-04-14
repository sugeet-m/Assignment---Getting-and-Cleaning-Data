Course Project - Getting and Cleaning Data
================
sugeet-m
2025-04-14

## Project Codebook

This document contains information related to the steps followed in
completing the assignment

- Sourcing the data
- Reading the data into R
- Cleaning up column names and activity names
- Merging the training and testing datasets
- Extracting relevant columns from merged data
- Providing descriptive column names
- Saving the resulting tidy dataset

More information about each step is provided in the relevant sections
below.

### Software information

The coding was done in RStudio version 2024.12.1 build 563. The
data.table and dplyr packages were used in addition to base R.

### Sourcing the data

The data for this project was downloaded from [the course
repository](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).
This data was originally sourced from the [Human Activity Recognition
Using
Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

### Reading the data into R

The downloaded data was unzipped and the contents were examined. The
zipped folder contained a text file named README which provided
information about the contents of the folder. The dataset consists of
data collected using a smartphone accelerometer while performing a
variety of activities such as walking and running. The complete dataset
is presented as two sets - training data and testing data, both of which
follow the same format. Each subset consists of three text files -
subject\_^, x\_^, and y\_^, where ^ represents training and testing
subsets. The subject\_^ file contains coded information on the subject
participant, the x\_^ file contains the 561-feature vector measured by
the accelerometer, and the y\_^ file contains the activity performed.
These six files were read into R as data tables.

### Cleaning up column and activity names

Column names were added to the x\_^ tables using the features.txt file.
Column names “Activity” and “SubjectID” were added for the Y\_^ and
subject\_^ files respectively.

The values of activity were converted into the underlying values using
the activity_labels.txt file.

### Merging the training and testing data sets

The three tables for each subset (training and testing) were combined to
produce two data tables by binding the underlying tables column-wise.
The resulting two tables were then bound row wise to produce a merged
dataset containing the entire dataset.

### Extracting relevant columns from merged data

The assignment requires that the final output should only contain only
subject IDs, the activity performed, and columns containing the means
and standard deviations of the various parameters that are measured.
Once extracted, the three data tables were combined column-wise to
produce the desired output.

### Providing descriptive column names

One of the features of tidy datasets is that column names be descriptive
and easily readable. As I do not understand the meaning of many of the
columns, I decided to only change a few commonly occurring abbreviations
to demonstrate how such changes should be made. I recognize that many
column names may not be readily understood.

### Saving the resulting tidy dataset

The final output was saved to a file called TidyData.txt, which is also
part of the submission.
