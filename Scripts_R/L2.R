L2=function(X,W,NbI){ #Compute the L2 distance between the estimated and true posterior density
                      #X particles
                      #W associated weights
                      #NbI: number of bins between -10 and 10 to compute the distance

    Fx=function(x){
      y=0.5*(1/(sqrt(2*pi)*1))*exp((-(x-0)^2)/(2*1^2))+0.5*(1/(sqrt(2*pi)*0.1))*exp((-(x-0)^2)/(2*0.1^2))
      y
    }
    I=seq(-10,10,20/NbI)
    R=rep(-1,length(I)-1)
    w=sum(W)
    for(i in 2:(length(I))){
      R[(i-1)]=((sum(W[X>=I[i-1] & X<I[i]])/w)-as.numeric(integrate(Fx,I[i-1],I[i])$value))^2
    }
    R=sqrt(sum(R))
    R
}