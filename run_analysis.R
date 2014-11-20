###########################################
#Clean Data project script performs the following steps (not necessarily in the described order for steps 1-4).

# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of 
#    each variable for each activity and each subject.
#
# This script assumes the following files are in the current working directory and subfolders:
#   -run_analysis.R - this script
#   -features.txt - contains names of each column/variable
#   -activities_labels.txt - names/labels the Activities (6)
#   -test/X_test.txt - test data
#   -test/y_test.txt - Each row identifies the activity for each test window sample. Its range is from 1 to 6.
#   -test/subject_test.txt - Each row identifies the subject who performed the activity for each test window sample. Its range is from 1 to 30.
#   -train/X_train.txt - training data
#   -train/y_train.txt - Each row identifies the activity for each training window sample. Its range is from 1 to 6.
#   -train/subject_train.txt - Each row identifies the subject who performed the activity for each training window sample. Its range is from 1 to 30.
#
# This script writes the tidy dataset to a local file to the current WD ("project.txt"). It can be read into a 
# data frame: read_table("project.txt")
############################################
run_analysis <- function() {
    
    # Steps 1-4 logic:
    # Since the data files are very large, this script will only read in the data it requires.
    # Only the mean and std deviation columns are required.  Therefore we will determine which
    # columns/variables we need by reading in the column names from the features.txt file and
    # determine which columns we want to read in. Only columns that contain the string "mean()"
    # or "std()" are kept.
    #
    # The test and training data files are in fixed width format (16 chars wide). So we will build a 
    # "widths" vector with an entry for each of the 561 columns. For the columns we want to keep we 
    # specify 16 and for the others a -16 (negative indicates to not read in). We then build the 
    # "names" vector to contain the names of the required variables. This script modifies the 
    # original column names to be more descriptive. Read in the fixed width data files with the
    # widths and names vectors.
    #
    # We then need to append the activity and subject to each row/observation to the test and training
    # data sets. We then merge the two datasets into one. 
    
    #build the list of all the column names from features.txt file. Do not treat them as factors.
    colNames <- read.table("features.txt", stringsAsFactor=FALSE)
    colNames <- colNames[,2] #names in 2nd column
    
    #get the widths to read
    widths<-getWidths(colNames)
    
    #get only the columns we are interested in (mean and std) and modify to be more descriptive.
    names <- getMeanStdColNames(colNames)
    names <-modifyNames(names)   
    
    #get the activity labels
    activities <- read.table("activity_labels.txt", stringsAsFactors=FALSE)
    
    #Now read the test data file for only the required columns and label with descriptive column names
    testDF <- read.fwf("./test/X_test.txt", widths=widths, col.names=names)    
    #get the activity for the test data
    testActivities <- read.table("./test/y_test.txt")
    #append a column indicating the activity label to the test data
    testDF$Activity <-  activities[testActivities$V1,2]    
    #append the subject ids to the test data set
    testSubjects <- read.table("./test/subject_test.txt", col.names = c("Subject"))
    testDF <- cbind(testDF, testSubjects)
    
    #Now read the training data file for only the required columns and label with descriptive column names
    trainDF <- read.fwf("./train/X_train.txt", widths=widths, col.names=names)    
    #get the activity for the training data
    trainActivities <- read.table("./train/y_train.txt")
    #append a column indicating the activity label to the training data
    trainDF$Activity <-  activities[trainActivities$V1,2]
    #append the subject ids to the training data set
    trainSubjects <- read.table("./train/subject_train.txt", col.names = c("Subject"))
    trainDF <- cbind(trainDF, trainSubjects)
    
    #append the two DFs together 
    DF <- rbind(trainDF, testDF)
    
    #Step 5:
    # Create a second, independent tidy data set with the average of each variable for each activity and 
    # each subject. We do this by converting the DF to a data table and then doing a list apply the mean 
    # function to the variables by Subject and Activity. We then sort it by Subject and then write it out.
    
    library(data.table) # need to load data.table library in order to use it
    DT <- data.table(DF)
    #create tidy data set with mean of variables by Subject and Activity
    DT <- DT[, lapply(.SD, mean), by=list(Subject, Activity)]
    DT <- DT[order(DT$Subject),]  #sort by Subject
    
    #write it out
    write.table(DT, file="project.txt", row.names=FALSE)
    
    return(DT)
}

# Builds the vector of just the "mean()" and "std()" column names. Vector is to be used to read in the 
# fixed width data files.
#  -'colNames' - list of the column names to filter 
getMeanStdColNames <- function(colNames) {
    names <- c()    
    for(i in 1:561) {
        if ( isMeanOrStd(colNames[i])) {
            names <- c(names, colNames[i])
        }
    }
    return(names)
}

#Builds list of column widths. All columns are 16 char wide. If column is to be read (is mean or std)
#then sets it as 16, otherwise as -16 to not read it.
#  -'colNames' - list of the column names to filter 
getWidths <- function(colNames) {
    widths <- c()    
    for(i in 1:561) {
        if ( isMeanOrStd(colNames[i])) {
            widths <- c(widths, 16)
        } else {
            widths <- c(widths, -16)
        }
    }
    return(widths)
}

# Determines if col name is for mean or std variable. Only columns containg chars "mean(" 
# or "std(" are considered as mean or std.
#  -'colName' - column name to check if mean or std
isMeanOrStd <- function(colName) {
    mean <- grep("mean\\(", colName)
    std <- grep("std\\(", colName)
    if ( length(mean) > 0 || length(std) > 0) {
        return(TRUE)
    }
    return(FALSE)
}

# Modifies the original variable names to be more descriptive. It does:
#  -changes "t" prefix to "time"
#  -changes "f" prefix to "freq"
#  -removes "()"
#  -converts 1st dash to underscore
#  -converts 2nd dash to dot
# 'names' is list of column names to modify
modifyNames<- function(names) {
    names <- sub("^t", "time", names)
    names <- sub("^f", "freq", names)
    names <- sub("\\(\\)", "", names)
    names <- sub("-", "_", names)
    names<-make.names(names)
    return(names)
}


