# set the seed
set.seed(123)

# SCM
n <- 1e6 # set the sample size 

Z = rnorm(n, 0,1)
X = 1 / (1 + exp(-2*Z))
Y = X + 2*Z + rnorm(n, 0,1)

scm <- data.frame(X, Y, Z) 

# predict the binary outcome for X
scm$X_bi <- ifelse(X > 0.5 , 1, 0)    # using 0.5 cut off gives 3.7 --> closer to 4 
#scm$X_bi <- sapply(X, function(vec) rbinom(1, 1, prob=vec)) # using rbinom gives 2.8 

# subset X==1 group and X==0 group
groupX_1 <- scm$Y[which(scm$X_bi ==1)] 
groupX_2 <- scm$Y[which(scm$X_bi ==0)]

# Prima Facie effect= difference in the mean of Y between X1group and X2group
mean(groupX_1) - mean(groupX_2)
