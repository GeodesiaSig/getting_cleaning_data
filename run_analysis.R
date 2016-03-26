## dependencies
library(dplyr)

## download and unzip the file
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
base_name <- basename(url)
file_path <- file.path(getwd(), base_name)
download.file(url = url, destfile = file_path)
unzip(file_path, overwrite = TRUE)
## read folder and its files
home_path <- file.path(getwd(), "UCI HAR Dataset")
## common files
col_names <- read.table(file = file.path(home_path, "features.txt"), stringsAsFactors = FALSE)
names(col_names) <- c("id", "name_var")
activity_labels <- read.table(file = file.path(home_path, "activity_labels.txt"), stringsAsFactors = FALSE)
names(activity_labels) <- c("id_activity","activity")

## training files
train_set <- read.table(file = file.path(home_path,"train/X_train.txt"), dec = ".", stringsAsFactors = FALSE)
train_label <- read.table(file = file.path(home_path, "train/y_train.txt"), stringsAsFactors = FALSE)
names(train_label) <- c("id_activity")
train_id <- read.table(file = file.path(home_path, "train/subject_train.txt"), stringsAsFactors = FALSE)
names(train_id) <- c("SubjectID")
#train_id[,1] <- as.factor(train_id[,1])
train_set <- train_set[,grep("mean[[:punct:]]|std[[:punct:]]", col_names[,2])]
names(train_set) <- col_names[grep("mean[[:punct:]]|std[[:punct:]]", col_names[,2]), 2]

## output train 
activity_train <- full_join(train_label, activity_labels, by = "id_activity")
activity_train[,2] <- tolower(activity_train[,2])
train_set <- cbind(train_id, activity_train$activity,train_set)
names(train_set)[2] <- c("activity")
rm(train_label, train_id, activity_train)
gc()

## test files
test_set <- read.table(file = file.path(home_path,"test/X_test.txt"), dec = ".", stringsAsFactors = FALSE)
test_label <- read.table(file = file.path(home_path, "test/y_test.txt"), stringsAsFactors = FALSE)
names(test_label) <- c("id_activity")
test_id <- read.table(file = file.path(home_path, "test/subject_test.txt"), stringsAsFactors = FALSE)
names(test_id) <- c("SubjectID")
#test_id[,1] <- as.factor(test_id[,1])
test_set <- test_set[,grep("mean[[:punct:]]|std[[:punct:]]", col_names[,2])]
names(test_set) <- col_names[grep("mean[[:punct:]]|std[[:punct:]]", col_names[,2]), 2]

## output test 
activity_test <- full_join(test_label, activity_labels, by = "id_activity")
activity_test[,2] <- tolower(activity_test[,2])
test_set <- cbind(test_id, activity_test$activity,test_set)
names(test_set)[2] <- c("activity")
rm(test_label, test_id, activity_test)
gc()

## common output for test and training
common <- tbl_df(rbind(train_set, test_set)) %>% arrange(SubjectID, desc(activity))
common$SubjectID<- as.factor(common$SubjectID)
common$activity <- as.factor(common$activity)
rm(test_set, train_set, activity_labels, col_names)
h <- (gsub(pattern = "^t", replacement = "Time", names(common))%>% 
     gsub(pattern= "^f", replacement ="Frequency")%>%
     gsub(pattern = "Acc", replacement = "Accelerometer") %>%
     gsub(pattern = "Gyro", replacement = "Gyroscope")%>%
     gsub(pattern = "Mag", replacement = "Magnitude")%>%
     gsub(pattern = "-mean[[:punct:]][[:punct:]]", replacement = "Mean")%>%
     gsub(pattern = "-std[[:punct:]][[:punct:]]", replacement = "StandardDeviation")%>%
     gsub(pattern = "Jerk", replacement = "JerkSignal")%>%
     gsub(pattern = "-", replacement = "Axis")%>%
     gsub(pattern = "(Body){2}", replacement = "Body")
     )
names(common) <- h
rm(h)
gc()

by_SubjectID_Activity <- (group_by(common, SubjectID, activity)%>%
                          summarize_each(funs(mean), vars = c(3:length(names(common))))
                          )
names(by_SubjectID_Activity)[3:length(names(by_SubjectID_Activity))] <- (
    paste0("MeanOf", names(common)[3:length(names(common))])
)

write.table(x = by_SubjectID_Activity, file = file.path(getwd(), "tidy_data_set.txt"), row.names = FALSE)


