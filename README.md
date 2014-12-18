Raw data is: Subject and activity number/description as well as scores across 561 different variables as tracked by the fitness devicenes

The goal is to pick out purely the variables which measure mean or standard deviation and take the average of these for each subject for each activity


Codebook:
First I merged the x & y data for training and test data respectively,
I then combined both data sets and added the activity and subject columns
I subset this data selecting only columns which captured the mean or standard deviation using the grep() function
Added in the activity labels
Grouped the data by subject then by activity usingthe aggregate() function
Aggregated the mean of each grouping for each variable left
Wrote the data to a text file
