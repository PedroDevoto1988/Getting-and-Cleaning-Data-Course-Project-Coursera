========================================================================
# Getting and Cleaning Data Course Project Coursera
## READ ME FIRST!
========================================================================

This repo contains an exercise in getting and cleaning data, for the the Getting and Cleaning Data Course in Coursera's Data science Specialization. The original data are measurments taken with Samsungs' Galaxy X phone's gyroscope and accelerometer. For the sake of clarity, the data includes measurements on 30 subjects divided in 2 groups (train and test) performing 6 activities. For further information, refer to the "Original Codebook" folder, starting with the "ReadMe.txt" file inside and following with the "features.txt".

The course project demands that this original data be transformed into a tidy dataset (one column per variable, one observation per row, the contents are values) and that a new dataset and its corresponding R script be provided. This new dataset should show show the average of every measurement that is the mean or the standard deviation of previous measurements, for every subject and activity. As the project does not specifiy a particular question to be answered by the requested tidy version of the data, every measurement that represents the mean and standard deviation of another measurement in the original data has been included. This means that raw data measurement and processed data measurements are included. Please refer to the "Original Codebook" folder for further details on the measuring techniques and the post processing decisions taken.

This repo contains the following files:

- This "ReadMe.md"
- "Original Codebook" with information on how the origianl data was obtained.
- "UpdatedCodebook.txt" file, describing the transformations done to the data and how the R script works.
- "SGX_MovementDataTidy.txt", the processed "tidy" dataset.
- "run_analysis.R", the R script that performs the data transformations.
