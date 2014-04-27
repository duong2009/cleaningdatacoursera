cleaningdatacoursera
====================

The original dataset has been randomly partitioned into 2 sets: training data and test data

Each of these sets contain information regarding the activity type coded as numbers from 1 to 6 (test_label/train_label), the subject who performed the activities (test_subject/train_subject) and and sets of data (test_set/train_set).

For the purpose of integrating 2 sets in one single data set, all of the information related to test data/training data are combined by collumns into one single data table (test_data/train_data). A complete data set (called dataset) is formed after merging the test and training data using row binding.

The features.txt file contains all variables used to measures the data set. Those variables are then applied to the names of the dataset.

For the purpose of analyzing means and standard deviation of the measurements, only measurements of means and standard deviations are extracted. Regular expression to find only labels contain mean() and std(). With unique function, we're able to collect the indexes of all labels that qualify the regular expression. Subsetting the dataset with those indexes gives us a new data table called data2.

All the activity types coded as 1 to 6 are replaced by it's names according to activity_labels.txt file by using mapvalues function from plyr package.

In order to provide a summarized dataset, melt and dcast functions in the reshape2 package are used. activities and subjects are the id variables and all other measurement variables are summarized by those id variables. 