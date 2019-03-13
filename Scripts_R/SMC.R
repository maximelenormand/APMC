SMC=function(N,alf){

    source("ToyEx.R")  #Compute simulations of theta
    source("sample.R")

    X=NULL             #Simulations
    ACC=NULL           #Acceptance rate 
    THETA=NULL         #Particles
    W=NULL             #Importance weights
    ESS=NULL           #Effective Sample Size
    EPS=NULL           #Tolerance level
    COUNTSIM=NULL      #Number of simulations
    NBEFFPART=NULL     #Number of effective particles
    
    #Initialization
    theta=runif(N,-10,10)
    x=ToyEx(theta,1)
    w=rep(1/N,N)
    nbsim=N
    eps=20
    ess=N

    NBEFFPART=c(NBEFFPART,N)
    THETA=c(THETA,list(theta))
    W=c(W,list(w))
    ESS=c(ESS,ess)
    EPS=c(EPS,eps)
    ACC=c(ACC,1)
    COUNTSIM=c(COUNTSIM,nbsim)
    
    #Main loop
    while(eps>0.01){
      
      #Find next tolerance level  
      x=as.numeric(x)
      theta=as.numeric(theta)
      w=as.numeric(w)          
      ess=alf*ess
      nb=trunc(ess)+1
      y=cbind(theta,x,abs(x))
      y=y[order(y[,3]),]
      eps=y[nb,3]
            
      #Compute the associated weights and resample if necessary
      w[abs(x)>=eps]=0
      w=w/sum(w)
      thetat=theta[w!=0]
      xt=x[w!=0]
            
      if(ess<(N/2)){
         t=sample(runif(N),seq(0,1,1/(length(thetat))))
         theta=thetat[t]
         x=xt[t]
         w=rep(1/N,N)
         ess=1/sum(w^2)
      }
      
      if(eps<0.01){eps=0.01}
      
      #Adjust std deviation of proposal and sample proposal for MH step
      sigma=sqrt(2*((sum(w*theta^2)/sum(w))-((sum(w*theta)/sum(w))^2))/(1-sum((w/sum(w))^2)))
      theta1=theta+rnorm(length(theta))*sigma
      x1=ToyEx(theta1,1)
      nbsim=nbsim+length(w[w!=0])
            
      #Compute MH acceptance ratio and update accepted proposals
      theta2=theta1
      acc=length(x1[abs(x1)<eps & w!=0 & abs(theta1)<10])/length(w[w!=0])
      theta1[(abs(x1)>=eps | abs(theta1)>=10) & w!=0]=theta[(abs(x1)>=eps | abs(theta1)>=10) & w!=0]
      theta1[w==0]=theta[w==0]
      x1[(abs(x1)>=eps | abs(theta2)>=10) & w!=0]=x[(abs(x1)>=eps | abs(theta2)>=10) & w!=0]
      x1[w==0]=x[w==0]
      theta=theta1
      x=x1
                        
      THETA=c(THETA,list(theta))
      NBEFFPART=c(NBEFFPART,length(table(theta[w!=0])))
      W=c(W,list(w))
      ESS=c(ESS,ess)
      EPS=c(EPS,eps)      
      ACC=c(ACC,acc)
      COUNTSIM=c(COUNTSIM,nbsim)
  }
  L=list(THETA=THETA,W=W,ACC=ACC,EPS=EPS,ESS=ESS,COUNTSIM=COUNTSIM,NBEFFPART=NBEFFPART)
}