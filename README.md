# AccuracyBalancedAccuracy
[Accuracy vs Balanced Accuracy](https://en.wikipedia.org/wiki/Evaluation_of_binary_classifiers) for binary classification

**Language: R**

**Start: 2022**

## Why
I wanted to compare Accuracy and Balanced Accuracy to evaluate a binary classification model.

## A simple observation
Accuracy and Balanced Accuracy have the same value if the dataset is perfectly balanced (i.e., p = n):

$$ \frac{TP+TN}{P+N} = \frac{Sensitivity + Specificity}{2}  \text{when p = n} $$

$$ \frac{TP+TN}{P+N} = \frac{\frac{TP}{P} + \frac{TN}{N}}{2} $$

$$ \frac{TP+TN}{P+P} = \frac{1}{2} (\frac{TP}{P} + \frac{TN}{P}) $$

$$ \frac{TP+TN}{2P} = \frac{TP}{2P} + \frac{TN}{2P} $$$