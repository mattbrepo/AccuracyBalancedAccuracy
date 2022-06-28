
getAccuracy <- function(p, n, tp, tn) {
  return((tp+tn) / (p+n))
}

getBA <- function(p, n, tp, tn) {
  return((tp/p + tn/n)/2)
}

#
# Main
#

total = 100
min_class = 30 # minimum value for a class (it can be 0)

set.seed(123)
df <- data.frame(p=integer(),
                 n=integer(), 
                 tp=integer(), 
                 tn=integer(),
                 acc=double(),
                 ba=double()) 

for (j in 1:100) {
  p = sample.int(total - 2*min_class, 1) + min_class
  n = total - p
  
  for (i in 1:100) {
    tp = sample.int(p, 1)
    tn = sample.int(n, 1)
    
    acc = getAccuracy(p, n, tp, tn)
    ba = getBA(p, n, tp, tn)

    df <- rbind(df, data.frame(p=p, n=n, tp=tp, tn=tn, acc=acc, ba=ba))
  }
}

# number of tests
nrow(df)

# correlation of ba and acc
cor(df$ba, df$acc)

# find the maximum difference
df[, "abs_diff"] = abs(df$acc - df$ba)
which(df$abs_diff == max(df$abs_diff))
dfMaxDiff = df[df$abs_diff >= 0.1,]
nrow(dfMaxDiff)
head(dfMaxDiff)

summary(df[df$abs_diff >= 0.1, "ba"])
summary(df[df$abs_diff >= 0.1, "acc"])

# correlation plot
plot(df)

# ba vs acc
plot(df$ba, df$acc, main="Accuracy vs Balanced Accuracy", xlab="Balanced Accuracy", ylab="Accuracy")
abline(0, 1, col="blue")

