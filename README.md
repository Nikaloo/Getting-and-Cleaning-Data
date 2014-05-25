Getting-and-Cleaning-Data
=========================
## Course project for "Getting and Cleaning Data"

This is descriptive file for run_analysis.R, prepared as a part of course project in course "Getting and Clening the Data".
Script is prepared using only plain commands, without and functions, step-by-step going through the assignment.
prerequisite for the script to work is to set working directory, so that the Samsung data, namely directory "UCI HAR Dataset" is in the working directory.

### Task #1: Merges the training and the test sets to create one data set.

The data for this assignment is in 6 different files, (plus a ceperate file for variable names).
Each file is read seperately, then combined in variables "dataTest" and "dataTrain".
Finally the datasets are merged into data frame - "fullData".
Column names are retrieved from features.txt.
Names for Subject and Activity are added.
Then names of "fullData" is updated.

### Task #2: Extracts only the measurements on the mean and standard deviation for each measurement.
only the measurements for mean and st.dev are filtered from the dataset. 
The data for FreqMeans are not inclouded.
Finally the data for Subject and Activity are transfered.
New variable called "filterData" is created.

### Task #3: Uses descriptive activity names to name the activities in the data set.
Numbers are replaced with apropreate activity names:

* 1 - WALKING, 
* 2 - WALKING_UPSTAIRS, 
* 3 - WALKING_DOWNSTAIRS, 
* 4 - SITTING, 
*5 - STANDING, 
*6 - LAYING

The date remains in dataframe "filterData".

### Task #4: Appropriately labels the data set with descriptive activity names. 
Most of the names in the dataset is acceptable. The scripts removes "()" and replaces "-" with ".".
No other change seems to be nessesary.

### Task #5: Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
The script uses the package "reshape2".
The data is melted, useing "Activity" and "Subject" as ID variables, and the rest of the variavles as measurements.
Later the data is reshaped useing "dcast" function, based on the same ID variables, taking means (averages) for all measurements.
The data is stored in new variable - "tidyData"

### Task #6: OPTIONAL - write the tidy data into the file for upload
The resulting dataframe is written in to the file TidyData.txt for further use.
