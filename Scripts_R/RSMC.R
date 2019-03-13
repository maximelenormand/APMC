RSMC=function(N,alf){

      source("sample.R")   
      source("ToyEx.R")       #Compute simulations of theta
      
      R=1                     
      c=0.01

      Nalf=round(N*alf)       #Sample size
      EPS=NULL                #Tolerance level
      X=NULL                  #Simulations
      Acc=NULL                #Acceptance rate
      THETA=NULL              #Particles     
      W=seq(1/N,N)            #Importance weights
      NbSim=NULL              #Number of Simulations
      NBEFFPART=NULL          #Number of effective particles
      
      #Initialization
      theta=as.numeric(runif(N,-10,10))
      x=as.numeric(ToyEx(theta,1))
      eps=max(abs(x))
      
      NBEFFPART=c(NBEFFPART,N)
      EPS=c(EPS,eps)
      THETA=c(THETA,list(theta))
      Acc=c(Acc,1)
      COUNTSIM=N
      NbSim=c(NbSim,COUNTSIM)
      
      #Loop
      while(eps>0.01){
      
       #Keep the N-Nalf best particles
       y=cbind(theta,x,abs(x))
       y=y[order(y[,3]),]
       theta=y[,1]
       x=y[,2]
       theta=theta[1:(N-Nalf)] 
       x=x[1:(N-Nalf)]
       
       #New threshold level
       eps=max(abs(x))
       
       #Adjust std deviation of proposal
       sigma=2*sd(theta) 
       
       iacc=0
       thetac=NULL
       xc=NULL


       #Simulation of Nalpha particles
       for(i in 1:Nalf){
         t=sample(runif(1),c(0,cumsum(rep(1/length(theta),length(theta)))))  #Sample a particle from the sample composed of the N-Nalf best particles
         thetat=theta[t]
         xt=x[t]
         #We move R times the particles
         for(k in 1:R){
           thetatt=thetat+rnorm(1)*sigma
           xtt=ToyEx(thetatt,1)
           if(abs(xtt)<eps & abs(thetatt)<10){
             thetat=thetatt
             xt=xtt
             iacc=iacc+1
           }
         }
       
         thetac=c(thetac,thetat)
         xc=c(xc,xt)
       }

       
       COUNTSIM=COUNTSIM+Nalf*R
       
       #We merge the two samples to obtain a sample of size N 
       theta=c(theta,thetac)
       x=c(x,xc)
       
       
       acc=iacc/(R*Nalf)                #Acceptance rate
       R=trunc(log(c)/log(1-acc))+1     #New R value
       
       NBEFFPART=c(NBEFFPART,length(table(theta)))
       NbSim=c(NbSim,COUNTSIM)
       EPS=c(EPS,eps)
       THETA=c(THETA,list(theta))
       Acc=c(Acc,acc)
      
  } 
       
  L=list(THETA=THETA,Acc=Acc,EPS=EPS,NbSim=NbSim,NBEFFPART=NBEFFPART)
       
}