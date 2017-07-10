



table_pr=function(m){  
  rownames(m) <- weekdays(as.Date(4,"1970-01-01",tz="GMT")+0:6)
  colnames(m)<-colnames(m, do.NULL = FALSE, prefix = "Period")
  m=as.table(m)
  return(m)
}


calculwsum=function(n,z,num,w,l){
  sapply(1:n, function(y) round(sum(sapply(1:num, function(x)l[[x]][z,y]*w[num-x+1]))/sum(w[1:num]))
  )
}

#Size of Memory for W.Poisson Model 



#Function returning predictions using Time-varying Poisson Model

#Input: n1: number of weeks considered in the train set
#       n2:number of weeks considered in the test set
#       n:number of periods considred in one day (48 our case)

#       list_p: List of the historical demand stored 
#       in tables(rows: day of the week/ columns: day Period(our case P=30-->48 period))

#       list_a: List of the demand of the test set stored 
#       in tables(rows: day of the week/ columns: day Period(our case P=30-->48 period))
#       Same order of days  as list_p
#       w/num= size of memory considered for W.POISSON Model 
#       Consult the paper Part III.B eq(5)
#Example
alpha=0.4  #user_defined variable


we= sapply(1:20, function(y)alpha*(1-alpha)^(y-1))
num=max(which(weight> 0.01))

#Output: vector of the predicted number of services




wpoisson_pred=function(n,n1,n2,num,w,list_p,list_a){  
  
  
  list_p2=lapply(1: num, function(x) list_p[[n1-num+x]])
  
  pdemand_list=append(list_p2,list_a)
  
  
  #updating the set of the historical demand for each week for the test set
  up_pdemand_list=lapply(1:n2, function(x)pdemand_list[x:(num-1+x)])
  
  
  wpoisson_list=lapply(1:n2, function(y) table_pr(matrix(unlist(lapply(1:7,
                                                                       function(x) calculwsum (n,x,num,w,up_pdemand_list[[y]]))), ncol = n, byrow = TRUE)))
  
  pred_wp=unlist(lapply(1:n2, function(y) as.vector(t(wpoisson_list[[y]]))))
  
  
  return(pred_wp)
  
}
