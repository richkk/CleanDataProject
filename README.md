##CleanDataProject
================

Course project for course *Getting and Cleaning Data*

The Clean Data project script (*run_analysis.R*) performs the following steps (not necessarily in the described order for steps 1-4).

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

This script assumes the following files are in the current working directory and subfolders:
  - run_analysis.R - this script
  - features.txt - contains names of each column/variable
  - activities_labels.txt - names/labels the Activities (6)
  - test/X_test.txt - test data
  - test/y_test.txt - Each row identifies the activity for each test window sample. Its range is from 1 to 6.
  - test/subject_test.txt - Each row identifies the subject who performed the activity for each test window sample. Its range is from 1 to 30.
  - train/X_train.txt - training data
  - train/y_train.txt - Each row identifies the activity for each training window sample. Its range is from 1 to 6.
  - train/subject_train.txt - Each row identifies the subject who performed the activity for each training window sample. Its range is from 1 to 30.

This script writes the tidy dataset to a local file to the current WD (*project.txt*). It can be read into a data frame: **read_table("project.txt")**

####Steps 1 - 4 Logic:
Since the data files are very large, this script will only read in the data it requires. Only the mean and std deviation columns are required.  Therefore we will determine which columns/variables we need by reading in the column names from the features.txt file and determine which columns we want to read in. Only columns that contain the string "mean()" or "std()" are kept.
    
The test and training data files are in fixed width format (16 chars wide). So we will build a "widths" vector with an entry for each of the 561 columns. For the columns we want to keep we specify 16 and for the others a -16 (negative indicates to not read in). We then build the "names" vector to contain the names of the required variables. This script modifies the  original column names to be more descriptive. Read in the fixed width data files with the widths and names vectors.
  
We then need to append the activity and subject to each row/observation to the test and training data sets. We then merge the two datasets into one. 

####Step 5 Logic:
Create a second, independent tidy data set with the average of each variable for each activity and each subject. We do this by converting the DF to a data table and then doing a list apply of the mean function to each of the variables grouped by Subject and Activity. We then sort it by Subject and then write it out to a local file *project.txt*. 
