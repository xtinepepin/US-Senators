# US-Senators
Classification of US Senators from 114th US Congress votes

USsenators.m is a short Matlab program that classifies US Senators as Democrats or Republicans 
using a binary SVM (from libsvm) and data from the 114th US Congress.

The data set is small: 100 senators (observations) and 15 votes (features).
A "no" is represented by 0, a "yes" by 1, and "abstain" by 0.5.

There are 44 Democrats, 54 Republicans, and 2 Independents.
During training, the 2 Independent senators are ignored. During testing, they are assumed to be Democrats.

Training sets and test sets are split 75% and 25%, respectively. We use 10-fold cross-validation on the training set.

Results give 100% accuracy on both the CV data and test data, which means that Independents are closer to Democrats
than they are to Republicans.
