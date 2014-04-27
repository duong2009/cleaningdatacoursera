##Read the test data from the dataset
test_set <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE) 
test_label <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE)
test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt", 
                           header = FALSE)
##Read the training data from the dataset
train_set <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE) 
train_label <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)
train_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt", 
                           header = FALSE)

##1 Merge the training and test sets to create one data set
test_data <- cbind(test_label, test_subject)
test_data <- cbind(test_data, test_set)
train_data <- cbind(train_label, train_subject)
train_data <- cbind(train_data, train_set)
dataset <- rbind(test_data, train_data)

##2 Extracts only the measurements on the mean and standard deviation for each
#measurement. 
        
feature <- read.table("./UCI HAR Dataset/features.txt", header = FALSE,
                      colClasses = "character")
        ##4 Appropriately labels the data set with descriptive activity names
colnames(dataset) <- c("activities", "subjects", feature$V2 )
        #end of part 4
#Using regular expression to search for only labels with measurements of mean 
#and standard deviation
keyword <- c(".*mean\\(\\).*-X$", ".*std\\(\\).*-X$", 
             ".*mean\\(\\).*-Y$", ".*std\\(\\).*-Y$",
             ".*mean\\(\\).*-Z$", ".*std\\(\\).*-Z$")
filt <- unique(grep(paste(keyword,collapse="|"), 
                        feature$V2, value=FALSE))
#return to a data frame with only measurements on the mean and standard deviation
#subsetting starts from the 3rd collumns of the dataset, so 2 is added
data2 <- dataset[, c(1,2,filt +2)]

##3 Uses descriptive activity names to name the activities in the data set
activity_label <- read.table("./UCI HAR Dataset/activity_labels.txt", 
                             header = FALSE, colClasses = "character")
library(plyr)
dataset$activities <- mapvalues(dataset$activities, from = 1:6, 
                                to = activity_label$V2)

##5 Creates a second, independent tidy data set with the average of each 
#variable for each activity and each subject. 
library(reshape2)
dataMelt <- melt(data2, id = c("activities", "subjects"))
tidydata <- dcast(dataMelt, activities + subjects ~ variable, mean)

write.table(tidydata, file="./tidydata.txt", sep="\t", row.names=FALSE)