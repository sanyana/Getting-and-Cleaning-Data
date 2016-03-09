### Reading all the training and test data sets
trainx <- read.table("./UCI HAR Dataset/train/X_train.txt")
trainy <- read.table("./UCI HAR Dataset/train/y_train.txt")
trainsub <- read.table("./UCI HAR Dataset/train/subject_train.txt")
testx <- read.table("./UCI HAR Dataset/test/X_test.txt")
testy <- read.table("./UCI HAR Dataset/test/y_test.txt")
testsub <- read.table("./UCI HAR Dataset/test/subject_test.txt")
### Merges the training and the test sets to create one data set.
x <- rbind(trainx, testx)
y <- rbind(trainy, testy)
sub <- rbind(trainsub, testsub)
###Extracts only the measurements on the mean and standard deviation for each measurement.
## read in the names of the features
meas <- read.table("./UCI HAR Dataset/features.txt", strip.white = TRUE, stringsAsFactors = FALSE)
# create a subset with desired columns
mean_sd <- grep("mean\\(\\)|std\\(\\)", meas$V2)
x <- x[, mean_sd]
# rename columns
names(x) <- meas[mean_sd,2]
#Uses descriptive activity names to name the activities in the data set
actlabels <- read.table("./UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE)
y$V1 <- actlabels[y$V1,2]

#Appropriately labels the data set with descriptive variable names.
names(sub) <- "subject"
names(y) <- "activity"
agg_data <- cbind(x,y,sub)
#From the data set in step 4, creates a second, independent tidy
#data set with the average of each variable for each activity and each subject.
average <- aggregate(agg_data[, 3:ncol(x)],by=list(subject = agg_data$subject,label = agg_data$activity),mean)
write.table(average, "avg_data.txt", row.names = FALSE)


