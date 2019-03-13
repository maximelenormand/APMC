PMC=function(N,SeqTol){ #N: Sample size
                        #SeqTol: Decreasing sequence of tolerance level

    source("sample.R")
    source("ToyEx.R")
        
    CONTSIM=NULL     #Number of simulations
    X=NULL           #Simulations
    ACC=NULL         #Acceptance rate
    THETA=NULL       #Particles
    W=NULL           #Importance weights
    
    
    #Initialization
    w=NULL
    theta=NULL
    x=NULL
    contsim=0
    acc=0
    
    m=0
    for(i in 1:N){
      test=0
      while(test==0){
        thetac=runif(1,-10,10)
        xc=ToyEx(thetac,1)
        if(abs(xc)<SeqTol[1]){
          test=1
          theta=c(theta,thetac)
          x=c(x,xc)
          acc=acc+1
        }
        m=m+1
        contsim=contsim+1
      }
      w=c(w,1/N)
    }
    
    CONTSIM=c(CONTSIM,contsim)
    W=rbind(W,w)
    THETA=rbind(THETA,theta)
    ACC=c(ACC,acc/m)

    #Main loop
    for(j in 2:length(SeqTol)){ 
     
       thetaold=theta
       wold=w
       
       #Adjust std deviation of proposal
       th=sqrt(2*((sum(wold*thetaold^2)/sum(wold))-((sum(wold*thetaold)/sum(wold))^2))/(1-sum((wold/sum(wold))^2)))
       
       x=NULL
       theta=NULL
       w=NULL
       acc=0
       
       m=0
       for(i in 1:N){
          test=0
          while(test==0){
              t=sample(runif(1),c(0,cumsum(wold)/sum(wold)))      #Sample a particle from the previous sample
              thetac=thetaold[t]+rnorm(1)*th                      #Move the particle with the proposal
              xc=ToyEx(thetac,1)                                  #Simuation: realisation of theta
              if(abs(xc)<SeqTol[j] & abs(thetac)<10){
                  test=1
                  theta=c(theta,thetac)
                  x=c(x,xc)
                  #Compute the associated weights
                  w=c(w,(1/sum(wold*((1/(sqrt(2*pi)*th))*exp(-0.5*((thetac-thetaold)/th)^2)))))
                  acc=acc+1
              }
              m=m+1
              contsim=contsim+1
          }
       }
       CONTSIM=c(CONTSIM,contsim)
       W=rbind(W,w)
       THETA=rbind(THETA,theta)
       ACC=c(ACC,acc/m)
    }

    L=list(THETA=THETA,ACC=ACC,X=X,W=W,CONTSIM=CONTSIM)
    
}







