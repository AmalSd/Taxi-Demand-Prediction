# Taxi Demand Prediction
This repository contains the code and hyper-parameters for the paper:

"Predicting taxi-passenger demand using streaming data, L. Moreira-Matias, J. Gama, M. Ferreira, J. Mendes-Moreira, and L. Damas, IEEE Transactions on Intelligent Transportation Systems 14 (2013), no. 3, 1393–1402”

Please cite this paper if you use the code in this repository as part of a published research project.

## Code Description
The code was developed under the R software (version 3.2.2)
In this repository, you find four R codes in this repository (three for the base-line modes namely the Time-Varying Poisson (TVP) model, the Weighted- Time-Varying Poisson model (WTVPP) and THE Autoregressive Integrated Moving Average (ARIMA) model/ the fourth one for the sliding window Ensemble)

### Input data format
The main goal of the paper is to predict taxi demand quantities at different taxi stands for a time horizon P=30 minutes based on historical record of the demand at these stands.

1.	The first step would be to create a discrete time series for the demand counts with an aggregation period of 30 minutes

2.	The first two base-line models (TVP and WTVP) characterize the demand with its occurrence period (period 1, period 2,…) in the day (with 30 minutes as aggregation period, we have 48 periods in the day) and also  with the day type ( Monday, Tuesday,…)
