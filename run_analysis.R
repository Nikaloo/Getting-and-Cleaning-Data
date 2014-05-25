# Script
# ------------------------------------------------------------------------------------

# Task #1: Merges the training and the test sets to create one data set.

# the data from test set.
	dataTest<-read.table("./UCI HAR Dataset/test/X_test.txt")		      # Load the date from the test set.
	testSubject<-read.table("./UCI HAR Dataset/test/subject_test.txt")# Load the data regarding the subjects in test set.
	dataTest$Subject<-testSubject$V1						                      # Add the subject variable to the test data set.
	testLable<-read.table("./UCI HAR Dataset/test/Y_test.txt")		    # Load the data regarding the acctivities in test set.
	dataTest$Activity<-testLable$V1							                      # Add the activity lables to the test data set.

# the data from training set.
	dataTrain<-read.table("./UCI HAR Dataset/train/X_train.txt")		  # Load the data from the training set.
	trainSubject<-read.table("./UCI HAR Dataset/train/subject_train.txt")	# Load the data regarding the subjects.
	dataTrain$Subject<-trainSubject$V1							                  # Add the subject variable to the training data set.
	trainLable<-read.table("./UCI HAR Dataset/train/Y_train.txt")		  # Load the data regarding the acctivities in training set.
	dataTrain$Activity<-trainLable$V1							                    # Add the activity lables to the training data set.

# Merging the dataframes
	fullData<-merge(dataTest,dataTrain,all=T)

# Naming the columns
	lable<-read.table("./UCI HAR Dataset/features.txt") 						                      # Read the factores from file
	lable<-rbind(lable,data.frame(V1=as.integer(c(562,563)),V2=c("Subject","Activity")))  # Add two variables names for subject and activity
	lable<-lable[,2]												                                              # Transform dataframe into a vector	
	names(fullData)<-lable											                                          # Asigne proper column names to the data

# ------------------------------------------------------------------------------------

# Task #2: Extracts only the measurements on the mean and standard deviation for each measurement.

filterData<-fullData[,(grepl("mean",names(fullData))|grepl("std",names(fullData))) & !grepl("Freq",names(fullData))]
filterData$Activity<-fullData$Activity
filterData$Subject<-fullData$Subject

# ------------------------------------------------------------------------------------

# Task #3: Uses descriptive activity names to name the activities in the data set.

#	1 - WALKING, 
#	2 - WALKING_UPSTAIRS, 
#	3 - WALKING_DOWNSTAIRS, 
#	4 - SITTING, 
#	5 - STANDING, 
#	6 - LAYING

filterData$Activity<-sub("1","WALKING",filterData$Activity)
filterData$Activity<-sub("2","WALKING_UPSTAIRS",filterData$Activity)
filterData$Activity<-sub("3","WALKING_DOWNSTAIRS",filterData$Activity)
filterData$Activity<-sub("4","SITTING",filterData$Activity)
filterData$Activity<-sub("5","STANDING",filterData$Activity)
filterData$Activity<-sub("6","LAYING",filterData$Activity)

# ------------------------------------------------------------------------------------

# Task #4: Appropriately labels the data set with descriptive activity names. 
a<-names(filterData)
a<-gsub("-",".",a)
a<-gsub("mean..","mean",a)
a<-gsub("std..","std",a)
names(filterData)<-a

# ------------------------------------------------------------------------------------

# Task #5: Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# install.packages ("reshape2")
library(reshape2)

dataMelt<-melt(filterData,id=c("Activity","Subject"))
tidyData<-dcast(dataMelt, Activity + Subject ~ variable , mean)

write.table(tidyData,file = "TidyData.txt")
