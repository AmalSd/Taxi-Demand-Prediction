


table_pr=function(m){  
  rownames(m) <- weekdays(as.Date(4,"1970-01-01",tz="GMT")+0:6)
  colnames(m)<-colnames(m, do.NULL = FALSE, prefix = "Period")
  m=as.table(m)
  return(m)
}



calculsum=function(z,np,n,liste){                   
  
  sapply(1:np,function(y) sum(sapply(1:n, function(x)liste[[x]][z,y])))
}


#Function returning predictions using Time-varying Poisson Model

#Input: n1: number of weeks considered in the train set
#       n2:number of weeks considered in the test set
#       n:number of periods in the day ( our case study 48 periods)

#       list_p: List of the historical demand stored 
#       in tables(rows: day of the week/ columns: day Period(our case P=30-->48 period))

#       list_a: List of the demand of the test set stored 
#       in tables(rows: day of the week/ columns: day Period(our case P=30-->48 period))
#       Same order of days  as list_p


#Output: vector of the predicted number of services


poisson_pred=function(n,n1,n2,list_p, list_a){  
  
  
  sum_past=lapply(1:7,function(x) calculsum(x,n,n1,list_p))
  
  sum_past <- table_pr(matrix(unlist(sum_past), ncol =n, byrow = TRUE))
  
  
  nbr_week=table_pr(matrix(n1, ncol = n, nrow = 7))
  
  
  
  p_1=round(sum_past/nbr_week)
  
  #updating the set of the historical demand for each week for the test set
  sum_past_list=lapply(1:(n2-1),function(x) sum_past-list_p[[x]]+list_a[[x]])
  
  poisson_list=lapply(1:n2,function(x) if(x==1){p_1}else{round(sum_past_list[[x-1]]/nbr_week)})
  
  pred_p=unlist(lapply(1:n2, function(x) as.vector(t(poisson_list[[x]]))))
  
  return(pred_p)
  
}



