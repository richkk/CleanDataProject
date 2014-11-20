###Raw data
The features in the raw data came from the accelerometer and gyroscope 3-axial raw signals timeAcc_XYZ and timeGyro_XYZ. These time domain signals were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (timeBodyAcc_XYZ and timeGravityAcc_XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (timeBodyAccJerk_XYZ and timeBodyGyroJerk_XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (timeBodyAccMag, timeGravityAccMag, timeBodyAccJerkMag, timeBodyGyroMag, timeBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing freqBodyAcc_XYZ, freqBodyAccJerk_XYZ, freqBodyGyro_XYZ, freqBodyAccJerkMag, freqBodyGyroMag, freqBodyGyroJerkMag.

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

Only the following raw data variables were extracted:
 - _mean: Mean value
 - _std: Standard deviation

###DATA DICTIONARY
This is the data dictionary for the variables contained in the *project.txt* tidy data set file.  Each variable is the average value of the sampling raw data for each activity and each subject. 

The first two columns identify the subject and the activity. The table is ordered by Subject and then activity.
- Subject - id of person performaing the activities (1-30)
- Activity - name of the activity
 
The next 66 columns identify the average for the different measurements taken for that subject for that activity. See the explanation of the raw data above to determine what each variable measures.
- timeBodyAcc_mean.X  
- timeBodyAcc_mean.Y 
- timeBodyAcc_mean.Z 
- timeBodyAcc_std.X 
- timeBodyAcc_std.Y 
- timeBodyAcc_std.Z 
- timeGravityAcc_mean.X 
- timeGravityAcc_mean.Y 
- timeGravityAcc_mean.Z 
- timeGravityAcc_std.X 
- timeGravityAcc_std.Y 
- timeGravityAcc_std.Z 
- timeBodyAccJerk_mean.X 
- timeBodyAccJerk_mean.Y 
- timeBodyAccJerk_mean.Z 
- timeBodyAccJerk_std.X 
- timeBodyAccJerk_std.Y 
- timeBodyAccJerk_std.Z 
- timeBodyGyro_mean.X 
- timeBodyGyro_mean.Y 
- timeBodyGyro_mean.Z 
- timeBodyGyro_std.X 
- timeBodyGyro_std.Y 
- timeBodyGyro_std.Z 
- timeBodyGyroJerk_mean.X 
- timeBodyGyroJerk_mean.Y 
- timeBodyGyroJerk_mean.Z 
- timeBodyGyroJerk_std.X 
- timeBodyGyroJerk_std.Y 
- timeBodyGyroJerk_std.Z 
- timeBodyAccMag_mean 
- timeBodyAccMag_std 
- timeGravityAccMag_mean 
- timeGravityAccMag_std 
- timeBodyAccJerkMag_mean 
- timeBodyAccJerkMag_std 
- timeBodyGyroMag_mean 
- timeBodyGyroMag_std 
- timeBodyGyroJerkMag_mean 
- timeBodyGyroJerkMag_std 
- freqBodyAcc_mean.X 
- freqBodyAcc_mean.Y 
- freqBodyAcc_mean.Z 
- freqBodyAcc_std.X 
- freqBodyAcc_std.Y 
- freqBodyAcc_std.Z 
- freqBodyAccJerk_mean.X 
- freqBodyAccJerk_mean.Y 
- freqBodyAccJerk_mean.Z 
- freqBodyAccJerk_std.X 
- freqBodyAccJerk_std.Y 
- freqBodyAccJerk_std.Z 
- freqBodyGyro_mean.X 
- freqBodyGyro_mean.Y 
- freqBodyGyro_mean.Z 
- freqBodyGyro_std.X 
- freqBodyGyro_std.Y 
- freqBodyGyro_std.Z 
- freqBodyAccMag_mean 
- freqBodyAccMag_std 
- freqBodyBodyAccJerkMag_mean 
- freqBodyBodyAccJerkMag_std 
- freqBodyBodyGyroMag_mean 
- freqBodyBodyGyroMag_std 
- freqBodyBodyGyroJerkMag_mean 
- freqBodyBodyGyroJerkMag_std

###Processing
The R script read in the required raw data and tranformed it in several steps to produce the tidy data set.  The details of this transformation can be found in the README file, as well as in comments embedded in the R script.
