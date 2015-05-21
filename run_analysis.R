run_analysis <- function() {

    ## Basic identifiers regarding the data directory
    dirSep <- "/"
    baseDir <- "UCI HAR Dataset"
    testDir <- paste( baseDir, "test", sep=dirSep )
    trainDir <- paste( baseDir, "train", sep=dirSep )

    
    ## Filenames
    activityLabelsFile <- paste( baseDir, "activity_labels.txt", sep=dirSep )
    featuresFile <- paste( baseDir, "features.txt", sep=dirSep )
    
    subjectTrainFile <- paste( trainDir, "subject_train.txt", sep=dirSep )
    XTrainFile <- paste( trainDir, "X_train.txt", sep=dirSep )
    yTrainFile <- paste( trainDir, "y_train.txt", sep=dirSep )

    subjectTestFile <- paste( testDir, "subject_test.txt", sep=dirSep )
    XTestFile <- paste( testDir, "X_test.txt", sep=dirSep )
    yTestFile <- paste( testDir, "y_test.txt", sep=dirSep )

    
    ## Read the relevant data frames
    activityLabels <- read.table( activityLabelsFile )
    features <- read.table( featuresFile )
    
    subjectTrain <- read.table( subjectTrainFile )
    XTrain <- read.table( XTrainFile )
    yTrain <- read.table( yTrainFile )
    
    subjectTest <- read.table( subjectTestFile )
    XTest <- read.table( XTestFile )
    yTest <- read.table( yTestFile )


    ## use feature names as column labels
    names( XTest ) <- features[[2]]
    names( XTrain ) <- features[[2]]

    ## add subject ID column and activity label column to training and test set, resp.
    trainingSet <- cbind( subjectID=subjectTrain[,1], activityLabel=yTrain[,1], XTrain )
    testSet <- cbind( subjectID=subjectTest[,1], activityLabel=yTest[,1], XTest )

    ## merge training and test data
    mergedData <- rbind(trainingSet, testSet )

    ## select only columns that contain "mean" or "std" in their column label
    ## (including columns 1 and 2, which are subjectID and activityLabel)
    meanSelect <- grep( "mean", names( mergedData ) )
    stdSelect <- grep( "std", names( mergedData ) )

    meanStdData <- mergedData[sort(c(1, 2, meanSelect, stdSelect))]

    ## replace activity ID with its respective label
    meanStdData[,2] <- activityLabels[,2][match(meanStdData$activityLabel, activityLabels[,1])]
    

    ## compute the mean for each activity-subject combination
    result <- aggregate( meanStdData,
                        list(activity=meanStdData$activityLabel, subject=meanStdData$subjectID),
                        mean )

    ## drop these, since they are redundant (aggregate generates columns for
    ## the group variables)
    ## (activityLabel is a factor and cannot be mean'ed anyway)
    result$activityLabel <- NULL
    result$subjectID <- NULL

    result
}
