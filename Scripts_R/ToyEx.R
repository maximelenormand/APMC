ToyEx=function(theta,nb_rep){   #Theta: vector of particles
                                #nb_rep: Number of realisation of theta with the toy example
                                #Give nb_rep realisations for each particle of the vector theta 
  n=length(theta)
  X=NULL
  for(i in 1:nb_rep){
    x=rep(0,n)
    u=runif(n)
    a=which(u<0.5)
    b=which(u>=0.5)
    na=length(a)
    nb=length(b)
    x[a]=theta[a]+rnorm(na)
    x[b]=theta[b]+rnorm(nb)*(1/10)
	  X=rbind(X,as.numeric(x))
	}  
  X
}                                                    
