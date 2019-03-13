sample=function(U,I){  #U: vector of random number
                       #I: vector of a cumulative sum of weights
    R=U
    for(i in 1:(length(I)-1)){
      R[U>=I[i] & U<I[i+1]]=i
    }
    R[U==1]=length(I)-1
    R
}                                             