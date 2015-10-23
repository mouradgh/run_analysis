features <- read.table('features.txt',stringsAsFactors=F)

#Train data
X_train <- read.table('./train/X_train.txt',col.names=features[,2])
y_train <- read.table('./train/y_train.txt',col.names=c('activityCode'))
subject <- read.table('./train/subject_train.txt',col.names=c('subject'))
train <- cbind(X_train,y_train,subject)

#Test data
X_test <- read.table('./test/X_test.txt',col.names=features[,2])
y_test <- read.table('./test/y_test.txt',col.names=c('activityCode'))
subject <- read.table('./test/subject_test.txt',col.names=c('subject'))
test <- cbind(X_test,y_test,subject)

#Merging the training and the test sets to create one data set
data = rbind(train,test)

#Extracting only the measurements on the mean and standard deviation for each measurement
colfilter = grep('mean|std|activity|subject',colnames(data))
data = data[colfilter]

#Using descriptive activity names to name the activities in the data set
#and ppropriately labeling the data set with descriptive variable names. 
activity_labels = read.table('activity_labels.txt',col.names=c('activityCode','activity'))


data.merged = merge(x=data,y=activity_labels,by='activityCode')
data.grouped = aggregate(. ~ activity + subject,data=data.merged,FUN=mean)

#creating a second data set with the average 
write.table(data.grouped,'avg.txt',row.names=F)

