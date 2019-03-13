APMC=function(N,alf,paccmin){

      source("sample.R")
      source("ToyEx.R")

      p=round(N*alf)          #Sample size
      EPS=NULL                #Tolerance level
      X=NULL                  #Simulations
      ACC=NULL                #Acceptance rate 
      THETA=NULL              #Particles      
      W=NULL                  #Importance weights

      
      #Initialization
      theta=as.numeric(runif(N,-10,10))
      x=as.numeric(ToyEx(theta,1))
      w=as.numeric(rep(1,N))
      
      #Determination of the tolerance level
      y=cbind(theta,x,abs(x),w)
      y=y[order(y[,3]),]
      eps=y[p,3]
      
      #Keep the Nalf best particles
      theta=y[1:p,1]
      x=y[1:p,2]
      w=y[1:p,4]
      
      ##Adjust std of proposal
      sigma=sqrt(2*((sum(w*theta^2)/sum(w))-((sum(w*theta)/sum(w))^2))/(1-sum((w/sum(w))^2)))
      

      EPS=c(EPS,eps)
      THETA=c(THETA,list(theta))
      W=c(W,list(w))
      ACC=c(ACC,1)
      COUNTSIM=N
      

      #Main loop
      while(ACC[length(ACC)]>paccmin){    #While the acceptance rate is larger than the stopping criterion  
      
       #Sample N-Nalf particles from the previous weighted sample
       t=sample(runif(N-p),c(0,cumsum(w)/sum(w)))
       xo=x[t]
       thetao=theta[t]
       
       #Move each particle with the proposal
       thetan=thetao+rnorm(N-p)*sigma
       xn=ToyEx(thetan,1)
       b=(abs(thetan)>10)|(abs(xn)>eps)
       thetat=c(theta,thetan*(1-b)+thetao*b)
       xt=c(x,xn*(1-b)+xo*b)
       rmp=c(rep(1,p),2*(1-b)) 
       b=1-b
       acc=sum(b)
       COUNTSIM=c(COUNTSIM,COUNTSIM[length(COUNTSIM)]+N-p)
      
       #Compute the associated weights
       wt=NULL
       for(i in (1+p):N){
          wt=c(wt,((1/20)/sum((w/sum(w))*((1/(sqrt(2*pi)*sigma))*exp(-0.5*((thetat[i]-theta)/sigma)^2)))))
       }
       wt[rmp[(p+1):N]==0]=0
       wt=c(w,wt)

       xt=as.numeric(xt)
       thetat=as.numeric(thetat)
       wt=as.numeric(wt)

       xt=xt[rmp>0]
       thetat=thetat[rmp>0]
       wt=wt[rmp>0]
       rmp=rmp[rmp>0]
       
       #Determination of the tolerance level
       y=cbind(thetat,xt,abs(xt),wt,rmp)
       y=y[order(y[,3]),]
       eps=y[p,3]
       
       #Keep the Nalf best particles       
       theta=y[1:p,1]
       x=y[1:p,2]
       w=y[1:p,4]
       rmp=y[1:p,5]
       
       #Adjust std deviation of proposal       
       sigma=sqrt(2*((sum(w*theta^2)/sum(w))-((sum(w*theta)/sum(w))^2))/(1-sum((w/sum(w))^2)))
       
       EPS=c(EPS,eps)
       W=c(W,list(w))
       THETA=c(THETA,list(theta))
       ACC=c(ACC,acc/(N-p))
              
     }

    L=list(THETA=THETA,ACC=ACC,W=W,EPS=EPS,COUNTSIM=COUNTSIM)
}