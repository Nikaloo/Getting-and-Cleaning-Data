# Script
# ------------------------------------------------------------------------------------

# Task #1: Merges the training and the test sets to create one data set.

# the data from test set.
	DataTest<-read.table("./UCI HAR Dataset/test/X_test.txt")		      # Load the date from the test set.
	TestSubject<-read.table("./UCI HAR Dataset/test/subject_test.txt")# Load the data regarding the subjects in test set.
	DataTest$Subject<-TestSubject$V1						                      # Add the subject variable to the test data set.
	TestLable<-read.table("./UCI HAR Dataset/test/Y_test.txt")		    # Load the data regarding the acctivities in test set.
	DataTest$Activity<-TestLable$V1							                      # Add the activity lables to the test data set.

# the data from training set.
	DataTrain<-read.table("./UCI HAR Dataset/train/X_train.txt")		  # Load the data from the training set.
	TrainSubject<-read.table("./UCI HAR Dataset/train/subject_train.txt")	# Load the data regarding the subjects.
	DataTrain$Subject<-TrainSubject$V1							                  # Add the subject variable to the training data set.
	TrainLable<-read.table("./UCI HAR Dataset/train/Y_train.txt")		  # Load the data regarding the acctivities in training set.
	DataTrain$Activity<-TrainLable$V1							                    # Add the activity lables to the training data set.

# Merging the dataframes
	FullData<-merge(DataTest,DataTrain,all=T)

# Naming the columns
	Lable<-read.table("./UCI HAR Dataset/features.txt") 						                      # Read the factores from file
	Lable<-rbind(Lable,data.frame(V1=as.integer(c(562,563)),V2=c("Subject","Activity")))  # Add two variables names for subject and activity
	Lable<-Lable[,2]												                                              # Transform dataframe into a vector	
	names(FullData)<-Lable											                                          # Asigne proper column names to the data

# ------------------------------------------------------------------------------------

# Task #2: Extracts only the measurements on the mean and standard deviation for each measurement.

FilterData<-FullData[,(grepl("mean",names(FullData))|grepl("std",names(FullData))) & !grepl("Freq",names(FullData))]
FilterData$Activity<-FullData$Activity
FilterData$Subject<-FullData$Subject

# ------------------------------------------------------------------------------------

# Task #3: Uses descriptive activity names to name the activities in the data set.

#	1 - WALKING, 
#	2 - WALKING_UPSTAIRS, 
#	3 - WALKING_DOWNSTAIRS, 
#	4 - SITTING, 
#	5 - STANDING, 
#	6 - LAYING

FilterData$Activity<-sub("1","WALKING",FilterData$Activity)
FilterData$Activity<-sub("2","WALKING_UPSTAIRS",FilterData$Activity)
FilterData$Activity<-sub("3","WALKING_DOWNSTAIRS",FilterData$Activity)
FilterData$Activity<-sub("4","SITTING",FilterData$Activity)
FilterData$Activity<-sub("5","STANDING",FilterData$Activity)
FilterData$Activity<-sub("6","LAYING",FilterData$Activity)

# ------------------------------------------------------------------------------------

# Task #4: Appropriately labels the data set with descriptive activity names. 
a<-names(FilterData)
a<-gsub("-",".",a)
a<-gsub("mean..","mean",a)
a<-gsub("std..","std",a)
names(FilterData)<-a

# ------------------------------------------------------------------------------------

# Task #5: Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# install.packages ("reshape2")
library(reshape2)

DataMelt<-melt(FilterData,id=c("Activity","Subject"))
TidyData<-dcast(DataMelt, Activity + Subject ~ variable , mean)

write.table(TidyData,file = "TidyData.txt")
