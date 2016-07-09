library(plyr)

## Merging the training and the test sets to create one data set

# Reading trainings data set:
x_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
subject_train <- read.table("train/subject_train.txt")

# Reading testing data set:
x_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
subject_test <- read.table("test/subject_test.txt")

# Combining 'x' data set:
setXdata <- rbind(x_train, x_test)

# Combining 'y' data set:
setYdata <- rbind(y_train, y_test)

# Combining 'subject' data set:
setSubjectdata <- rbind(subject_train, subject_test)

## Extracting only the measurements on the mean and standard deviation for each measurement

# Reading feature data set:
features <- read.table("features.txt")

# Choose only the mean and standard deviation data:
setMean_Std_features <- grep("-(mean|std)\\(\\)", features[, 2])

# Subsetting the desired columns:
setXdata <- setXdata[, setMean_Std_features]

# Assigning column names:
names(setXdata) <- features[setMean_Std_features, 2]

## Using descriptive activity names to name the activities in the data set

activities <- read.table("activity_labels.txt")

# Assigning values to correct activity names:
setYdata[, 1] <- activities[setYdata[, 1], 2]

# Assigning column name:
names(setYdata) <- "activity"

## Labelling the data set with descriptive variable names

# Assigning column name:
names(subject_data) <- "subject"

# bind all the data in a single data set
all_data <- cbind(x_data, y_data, subject_data)

## Creating a second, independent tidy data set with the average of each variable for each activity and each subject

tidyset <- ddply(all_data, .(subject, activity), function(x) colMeans(x[, 1:66]))

write.table(tidyset, "tidyset.txt", row.name=FALSE)