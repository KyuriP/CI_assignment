#Observational
n=10000
z=rnorm(n,0,1)
logitX=2*z
pX=1/(1+exp(-logitX))
x=round(pX,0)
y= 1*x + 2*z + rnorm(n,0,1)

mean(x)
mean(z)
mean(z[which(x==1)])
mean(z[which(x==0)])
mean(y)
mean(y[which(x==1)])
mean(y[which(x==0)])
#difference from slide:
mean(y[which(x==1)])-mean(y[which(x==0)])

#Intervention
n=10000
z=rnorm(n,0,1)
#logitX=2*z
#pX=1/(1+exp(-logitX))
#x=round(pX,0)
y_xis1= 1*1 + 2*z + rnorm(n,0,1)
y_xis0= 1*0 + 2*z + rnorm(n,0,1)

mean(x)
mean(z)
mean(z[which(x==1)])
mean(z[which(x==0)])
mean(y_xis1)
mean(y_xis0)
#difference from slide:
mean(y_xis1)-mean(y_xis0)
  
