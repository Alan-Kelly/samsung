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

## Repeat the above for the Treaining data
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


tapply(dataX[,1],dataX$Activity,mean)




