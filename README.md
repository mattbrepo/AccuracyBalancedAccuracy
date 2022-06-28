# AccuracyBalancedAccuracy
[Accuracy vs Balanced Accuracy](https://en.wikipedia.org/wiki/Evaluation_of_binary_classifiers) for binary classification

**Language: R**

**Start: 2022**

## Why
I wanted to compare _Accuracy_ and _Balanced Accuracy_ when evaluating binary classification models.

## A simple observation
A first simple observation is that Accuracy and Balanced Accuracy have the same values if the dataset is perfectly balanced (i.e., when **N = P**):

$$ \frac{TP+TN}{P+N} = \frac{Sensitivity + Specificity}{2} $$

$$ \frac{TP+TN}{P+N} = \frac{\frac{TP}{P} + \frac{TN}{N}}{2} $$

$$ \frac{TP+TN}{P+P} = \frac{1}{2} (\frac{TP}{P} + \frac{TN}{P}) $$

$$ \frac{TP+TN}{2P} = \frac{TP}{2P} + \frac{TN}{2P} $$$

## A few numeric tests
I wrote a simple R program to test different combinations of possible values of N, P, TP and TN. All the 10000 tests assume a dataset of 100 elements (N + P = 100) where the smallest class has at least 30 elements. I decided to set this limit because analyzing extremely unbalanced datasets was outside the scope of this comparison.

The tests show that -unsurprisingly- the two metrics are highly correlated (0.97):

![plot ba acc](/images/plot_ba_acc.jpg)

Only 630 tests showed a difference between Accuracy and Balanced Accuracy greater than or equal to 0.1:

```r
> df[, "abs_diff"] = abs(df$acc - df$ba)
> dfMaxDiff = df[df$abs_diff >= 0.1,]

> nrow(dfMaxDiff)
[1] 630

> head(dfMaxDiff)
     p  n tp tn  acc        ba  abs_diff
801 36 64 30  6 0.36 0.4635417 0.1035417
805 36 64 32  1 0.33 0.4522569 0.1222569
808 36 64  5 55 0.60 0.4991319 0.1008681
818 36 64  9 62 0.71 0.6093750 0.1006250
824 36 64 36  5 0.41 0.5390625 0.1290625
886 36 64  9 63 0.72 0.6171875 0.1028125

> summary(df[df$abs_diff >= 0.1, "ba"])
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
 0.2976  0.4518  0.5154  0.5129  0.5742  0.7319 
> summary(df[df$abs_diff >= 0.1, "acc"])
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
 0.1900  0.3800  0.5000  0.5027  0.6300  0.8000 
```

Where the greatest difference is:

```r
> df[1316, ]
      p  n tp tn  acc        ba  abs_diff
1316 70 30 70  2 0.72 0.5333333 0.1866667
```

for a "model" using an unbalanced dataset (70 p and 30 n) that it is very good with the positive class (tp = 70, sensitivity = 100%) but quite poor with the negative class (tn = 2). This is a classic example where the Balanced Accuracy seems to yield a more reasonable result.