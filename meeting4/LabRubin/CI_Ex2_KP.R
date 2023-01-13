## 1. Data and R-pacakges
install.packages("tableone")
install.packages("MatchIt")
install.packages("survey")

# load data
df <- read.table("SchaferKangData.dat", header=T)
df[1:10,]

## 2. Prima Facie Effect : Not controlling for any variable
### 2.1 Method1: Compare Means

# Compare the means between the groups on the outcome variable (see Equation (5) in S&K; use for instance t.test() in R).  

### 2.2 
