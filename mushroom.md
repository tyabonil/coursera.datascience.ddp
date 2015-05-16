Is that Mushroom Poisonous or Edible?
========================================================
author: Ty Abonil
date: May 16, 2015
width: 1440
height: 1000

The Problem
========================================================

The classification problem chosen is to ascertain whether a given mushroom is edible or poisonous, given qualitative description of its physical characteristics

[The Mushroom Data Set (MDS)](https://archive.ics.uci.edu/ml/datasets/Mushroom) is a multivariate collection of 8124 instances of mushroom descriptions, each of 22 discrete attributes, including a classification of whether a mushroom is edible or poisonous. 

Bache, K. & Lichman, M. (2013). [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml). Irvine, CA: University of California, School of Information and Computer Science.


The file is read and, using the schema provided on the UCI website, names are assigned. NA values are omitted and 50/50 test and training sets are created.




Creating the Model
========================================================
We opt to use the rpart package to grow a decision tree to find the most valuable features.  First, we create a tree with all possible features, then we prune the tree to find the ones which minimize the CP hyper parameter - a measure of the 100-fold cross-validated error.

![plot of chunk unnamed-chunk-3](mushroom-figure/unnamed-chunk-3-1.png) 

It is osberved that pruning has almost no effect on the tree.

The ANN Model
========================================================

It is observed that "odor", "spore.print.color", and "population" account for almost all of the variance in the final classification.  An ANN is trained using these values


```r
mush.frm <- edible ~ odor + spore.print.color + population
mush.fit <- nnet(as.formula(mush.frm), data=mush.train, method = "nnet", maxit = 100,  trace = F, size=4)
```

The Validation Test
========================================================

Using the validation set, the accuracy of the model is tested


```r
success.rate <- sum(predict(mush.fit, newdata=mush.test, type="class") == mush.test[,1])/nrow(mush.test) * 100
```

The success rate is found to be 100%!  This is a very string model, so we can use it to predict whether a mushroom is poisonous or not.
