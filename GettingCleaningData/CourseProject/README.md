
"Getting and Cleaning Data / Course Project"

One of the most exciting areas in all of data science right now is wearable computing. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone.

The online zip file includes the following files:

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

Notes: 
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file. 

In order to prepare tidy data that can be used for later analysis, one R script called run_analysis.R was created and  does the following. 
1.Merges the training and the test sets to create one data set.
2.Extracts only the measurements on the mean and standard deviation for each measurement. 
3.Uses descriptive activity names to name the activities in the data set
4.Appropriately labels the data set with descriptive variable names. 
5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Below is the detailed steps in the R script.

Set the current working directory

Create data folder to save downloaded file

Download the zip file from the web

Save the zip file in the destinated directory

Unzip the file

Read train related data

Read test related data

Combine Subject_train, Y_train and X_train into one file called traindata. Combine Subject_test, Y_test and X_test into one file called testdata.

Merge the traindata and testdata into one file called MergeTrainTestData

Extracts only the measurements on the mean and standard deviation of variables.

Install packages for manipulating data: dplyr, tidyr, RSQLite

Read features.txt into R as a data frame to use as the column names

Read activity.txt into R as a data frame to use as the descriptive activity names

Select rows from features with key words 'mean' or 'std' into a data framed called MeanSTDdf (66 rows are selected).

Match the columns in MergeTrainTestData with those rows in MeanSTDdf with key words 'mean' and 'std'

Appropriately labels the data set with descriptive names

Rename activity type with descriptive names

Group by ID and Activity Tpye, calculate the mean of each variable

Output TidyData 







