#Get training data
xtrain <- read.table("UCI HAR Dataset/train/X_train.txt", head=F, sep="")
ytrain <- read.table("UCI HAR Dataset/train/Y_train.txt", head=F, sep="")
cols<- read.table("UCI HAR Dataset/features.txt")
colnames(xtrain) <- cols[,2]
training <- cbind(xtrain, ytrain)

#Fet testing data
xtest <- read.table("UCI HAR Dataset/test/X_test.txt", head=F, sep="")
colnames(xtest) <- cols[,2]
ytest <- read.table("UCI HAR Dataset/test/Y_test.txt", head=F, sep="")
testing <- cbind(xtest, ytest)

#Merge the two
total <- rbind(testing,training)

#Select the mean and std columns
mean = grep("mean", colnames(total), ignore.case = TRUE)
std = grep("std", colnames(total), ignore.case=TRUE)
stdcols <- total[std]
meancols <- total[mean]
total = cbind(stdcols, meancols)
ycol = rbind(ytest, ytrain)
total = cbind(total, ycol)

#Merge the subject numbers and activity
train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt")
test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt")
subject <- rbind(test_subject, train_subject)
total <- cbind(total, subject[,1])
activity <- read.table("UCI HAR Dataset/activity_labels.txt")
total <- merge(total, activity, by.x="V1", by.y= "V1")
names(total)[89] <- "activity"
names(total)[88] <- "subject"

#Group by subject and activity and take mean
ordered <- aggregate(total, by= list(total$subject, total$activity), FUN = "mean")
names(ordered)[1] <- "subject"
names(ordered)[2] <- "activity"
write.table(ordered[1:180,c(1,2,4:89)], "tidy.txt", row.name = FALSE)

