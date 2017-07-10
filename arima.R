#Function to calculate the model order (p,d,q) using auto.arima function from forecast package

calculaModeloArima<-function(timeseries,th=14*48)
{

  #if th<15 days, produce warning
  if (length(timeseries)<th)
  {
    print(length(timeseries))
    print(th)
    print("WARNING: The supplied series has a size smaller than expected !!!")
  }
  
  #Select the model
  fit <- tryCatch(auto.arima(timeseries,allowdrift=FALSE,seasonal = FALSE), error=function(e) e)
  if (is.list(fit))
  {
    arma<-fit$arma
    myOrder<-c(arma[1],arma[6],arma[2])
    if (is.vector(myOrder) && length(myOrder)==3)
    {
      if ((myOrder[1]==4 && myOrder[2]==0 && myOrder[3]==4) || (myOrder[1]==0 && myOrder[2]==0 && myOrder[3]==0) || (myOrder[1]==4 && myOrder[2]==0 && myOrder[3]==3) || (myOrder[1]==3 && myOrder[2]==0 && myOrder[3]==3) || (myOrder[1]==2 && myOrder[2]==1 && myOrder[3]==2) || (myOrder[1]==5 && myOrder[2]==0 && myOrder[3]==4)|| (myOrder[1]==5 && myOrder[2]==0 && myOrder[3]==3) || length(myOrder[myOrder>4])>0)
        myOrder=c(2,0,2)
    }
    else
      myOrder=c(2,0,2)
  }
  else
  {
    print("WARNING: Could not determine the model !!! (P, d, q) = (2.0.2)!!!")
    myOrder=c(2,0,2)
  }
  
  return (myOrder)
}


#calculate_arima_pred : generate one predicted times series value  for a considered period 'per'
# in a considered day 'day', using arima model and 'ndays' as number of day in the training period

#Output=one predicted times series value

#Input= *timeseies=time series values ( contains both train + test values)
#       *ndays:number of days used for the training period/Our case Train 2 weeks = 14 days
#       * day :Considred day  for which we want to get the predictions
#       * n: number of periods in the day / our case P=30 min --> n=48 periods
#       * per: considred period in the day
#       * O: arima order used for the prediction (calculated using calculaModeloArima)

calculate_arima_pred=function(timeseries, ndays,n,day,o,per){
  datapred=timeseries[(per+n*(day-1)):((ndays*n)+(per-1)+n*(day-1))]
  r <- tryCatch(round(predict(arima(datapred,order=o ), n.ahead =1)$pred), error=function(e) e)
  if (is.numeric(r))
  {if(r<0){r=0}else{r=(r)}}else{r=0}
  return(r)
}

#calculate_arima_pred : generate one predicted times series value  for a considered period 'per'
# in a considered day 'day', using arima model and 'ndays' as number of day in the training period

#Output=one predicted times series value

#Input= *timeseies=time series values ( contains both train + test values)
#       *ndays:number of days used for the training period/Our case Train 2 weeks = 14 days
#       * day :Considred day  for which we want to get the predictions
#       * n: number of periods in the day / our case P=30 min --> n=48 periods


calculate_arima_pred_day=function(timeseries, ndays,n,day){
  
  
  ts_train=timeseries[(1+n*(day-1)):((ndays*n)+n*(day-1))]
  o=calculaModeloArima(ts_train)
  
  r=sapply(1:n, function(x) calculate_arima_pred(timeseries, ndays,n,day,o,x))
  return(r)
}



