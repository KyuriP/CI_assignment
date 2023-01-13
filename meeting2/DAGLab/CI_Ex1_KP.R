## 1. Data and Packages

# packages for working with DAGs
install.packages("qgraph")
install.packages("dagitty")
install.packages("ggdag")

# tidyverse - i assume you already have this
library(tidyverse)

# packages for testing independence of variables
install.packages("CondIndTests")
install.packages("dHSIC")
install.packages("ppcor")
install.packages("pcalg")

# The graph, RBGL & Rgraphviz packages are needed for pcalg
# but are only available on Bioconductor but not CRAN
if (!requireNamespace("BiocManager", quietly = TRUE)){
  install.packages("BiocManager")
  BiocManager::install(c("graph", "RBGL", "Rgraphviz"))
}


# load data
ex1 <- readRDS('data_cd_ex1.RDS')
ex5 <- readRDS('ex5_data.RDS')


## 2. Graphs and Adjacency Matrices
library(qgraph)
library(dagitty)
library(ggdag)

# collider DAG
varnames <- c("X","Y","Z")
Adj <- matrix(c(0,0,1,
                0,0,1,
                0,0,0), 3,3, byrow = TRUE,
              dimnames = list(varnames,varnames))
qgraph(Adj, 
       labels = c("X","Y","Z"), # not necessary if Adj has dimnames
       #you can provide a custom layout by giving the x-y co-ordinates of each node
       layout = rbind(c(-1,-1),
                      c(1,-1),
                      c(0,1)))
# chain DAG
Adj <- matrix(c(0,0,1,
                0,0,0,
                0,1,0), 3,3, byrow = TRUE,
              dimnames = list(varnames,varnames))
qgraph(Adj, 
       labels = c("X","Y","Z"), # not necessary if Adj has dimnames
       #you can provide a custom layout by giving the x-y co-ordinates of each node
       layout = rbind(c(-1,-1),
                      c(1,-1),
                      c(0,1)))

# fork DAG
Adj <- matrix(c(0,0,0,
                0,0,0,
                1,1,0), 3,3, byrow = TRUE,
              dimnames = list(varnames,varnames))
qgraph(Adj, 
       labels = c("X","Y","Z"), # not necessary if Adj has dimnames
       #you can provide a custom layout by giving the x-y co-ordinates of each node
       layout = rbind(c(-1,-1),
                      c(1,-1),
                      c(0,1)))


# collider DAG using ggdag
coldag <- dagify(
  Z ~ X + Y,
  exposure = "X", # the "cause" variable you are interested in
  outcome = "Y", # the "effect" variable you are interested in
  # optional: give co-ordinates of the variables in the plot
  coords = list(x = c(X = -1, Y = 1, Z = 0),
                y = c(X = 0, Y = 0, Z = 1)) 
) 
ggdag_status(coldag) + theme_dag()

#  Re-create the chain and fork DAGs in the lecture using the ggdag package.
# chain dag
chaindag <- dagify(
  Z ~ X, Y ~ Z,
  exposure = "X", 
  outcome = "Y", 
  # optional: give co-ordinates of the variables in the plot
  coords = list(x = c(X = -1, Y = 1, Z = 0),
                y = c(X = 0, Y = 0, Z = 1)) 
) 
ggdag_status(chaindag) + theme_dag()

# fork dag
forkdag <- dagify(
  X ~ Z,  Y ~ Z,
  exposure = "X", # the "cause" variable you are interested in
  outcome = "Y", # the "effect" variable you are interested in
  # optional: give co-ordinates of the variables in the plot
  coords = list(x = c(X = -1, Y = 1, Z = 0),
                y = c(X = 0, Y = 0, Z = 1)) 
) 
ggdag_status(forkdag) + theme_dag()


## 3. d-seperation and DAGs
eddag <- dagify(
  EA ~ CI,
  AI ~ CI + EA + U,
  Inc ~ EA + CI + AI + U ,
  exposure = "EA", # the "cause" variable you are interested in
  outcome = "Inc", # the "effect" variable you are interested in
  # optional: give co-ordinates of the variables in the plot
  coords = list(x = c(EA = -1,CI = 0,AI =0 ,Inc =1 , U = -1),
                y = c(EA = 0,CI =1 ,AI = -1,Inc = 0, U = -1)) 
) 
ggdag_status(eddag) + theme_dag()

# check 
adjustmentSets(eddag)

## 4. Predictive vs Causal analysis
# load the data
mdata <- readRDS('mdata.RDS')
