## Read the Test data, add column names, add columns for Activity and Subject on right hand side
dataX<-read.table("X_test.txt")
dim(dataX)
datay<-read.table("y_test.txt")
dim(datay)
subj<-read.table("subject_test.txt")
dim(subj)
activity<-read.table("activity_labels.txt")

all(colSums(is.na(dataX))==0)  ## return TRUE if we have no NA value
varnames<-read.table("features.txt")
varnames<-varnames$V2
varnames<-as.character(varnames)
names(dataX)[1:561]<-varnames[1:561]
dataX$Activity<-datay$V1
dataX$Subject<-subj$V1 
data<-dataX

## Repeat the above for the Training data
dataX<-read.table("X_train.txt")
dim(dataX)
datay<-read.table("y_train.txt")
dim(datay)
subj<-read.table("subject_train.txt")
dim(subj)

all(colSums(is.na(dataX))==0)  ## return TRUE if we have no NA value
names(dataX)[1:561]<-varnames[1:561]
dataX$Activity<-datay$V1
dataX$Subject<-subj$V1 

## Combine the Test and Train data sets
dataSamsung<-rbind(data, dataX)
dim(dataSamsung)


## Select and combine the columns with "std", "mean", Subject and Activity data
library(dplyr)
dataSamsung<- tbl_df(dataSamsung)
tempstd<-select(dataSamsung, contains("std"))
tempmean<-select(dataSamsung, contains("mean"))
temp<-select(dataSamsung, Subject,Activity)
Samsung<-cbind(temp,tempstd,tempmean)

## Apply Activity labels to the Activity column data and tidy the variable names
Samsung$Activity<-gsub("1", "walking",Samsung$Activity)
Samsung$Activity<-gsub("2", "walking_upstairs",Samsung$Activity)
Samsung$Activity<-gsub("3", "walking_downstairs",Samsung$Activity)
Samsung$Activity<-gsub("4", "sitting",Samsung$Activity)
Samsung$Activity<-gsub("5", "standing",Samsung$Activity)
Samsung$Activity<-gsub("6", "laying",Samsung$Activity)
names(Samsung)<-tolower(names(Samsung))
names(Samsung)<-gsub("\\()","",names(Samsung))

## group by activity and subject and calculate mean of measurements
by_activity<-group_by(Samsung,Activity,Subject)
tidySamsung<-summarise_each(by_activity,funs(mean))
write.table(tidySamsung, "tidySamsung.txt",row.name=FALSE)






