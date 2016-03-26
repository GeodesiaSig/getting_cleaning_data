# CODE BOOK
## Features
The features selected corresponds with [data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip), wich is a data set collected from the accelerometers from the Samsung Galaxy S smartphone. This experiments involves 30 people.
### Description
Below are the original measures or variables, prefixes t and f corresponds to time and frequency respectly; Acc and Gyro are the linear acceleration and the angular velocity for each of cartesian axis (XYZ); Jerk is Jerk signal; Mag is the vectorial magnitude which involves three axis XYZ. [Here full description](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).  

#### Original Variables Set  
For ech one of the following variables, many function were aplying, but only two were selected: Mean  and standard Deviation. resulting 68 variables and 10299 observations.    

- tBodyAcc-XYZ  
- tGravityAcc-XYZ  
- tBodyAccJerk-XYZ  
- tBodyGyro-XYZ  
- tBodyGyroJerk-XYZ  
- tBodyAccMag  
- tGravityAccMag  
- tBodyAccJerkMag  
- tBodyGyroMag  
- tBodyGyroJerkMag  
- fBodyAcc-XYZ  
- fBodyAccJerk-XYZ  
- fBodyGyro-XYZ  
- fBodyAccMag  
- fBodyAccJerkMag  
- fBodyGyroMag  
- fBodyGyroJerkMag  

### Activities
Each one of the varaibles were measure in six differentes activities  

1. WALKING  
2. WALKING_UPSTAIRS  
3. WALKING_DOWNSTAIRS  
4. SITTING  
5. STANDING  
6. LAYING  

### Resulting Varaibles Set
For each variable, the script group by subject and activity all measures like SQL query applying mean function for each variables. Then the data set contains 180 observations and 68 variables. The original names were changed in this way:  
- the prefixes t and f by: Time and Frequency  
- Acc by: Accelerometer  
- Gyro by: Gyroscope  
- mean() and sd() by: Mean and StandardDeviation  
- Mag by: Magnitude  
- Jerk by: JerkSignal  
- BodyBody by: Body  
- -X by AxisX  
- -Y by AxisY 
- -Z by AxisZ  
- And the group function by MeanOf




