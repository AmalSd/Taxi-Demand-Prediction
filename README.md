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

2.	The first two base-line models (TVP and WTVP) characterize the demand with its occurrence period (period 1, period 2,…) in the day (with 30 minutes as aggregation period, we have 48 periods in the day) and also  with the day type ( Monday, Tuesday,…). Therefore, one way for the implementation would be to construct a list of tables for the demand. Each table contains n1 columns indicating the day period (n1=48 for our case) and n2 rows for the day of the weeks (n2=7). We end up by having  a list of n table  where n is the number of weeks of  the recorded data 


### Remarks:
1.	For the WTVP, alpha is a  user-defined parameter that can be set using a grid search over a set of values in over [0; 1] with a chosen step size /  The size of memory ( i.e. number of week in the training set) is fixed using the  equation (9) in  the experimental set-up section in the paper.

2.	For the sliding-window ensemble, the size of the window H is also a user-defined parameter that can be set using a	 grid search  over the values (1; 2; 4; 8; 10) for example.


You can test the methodology using this public taxi data set available on the bellow link:

https://archive.ics.uci.edu/ml/datasets/Taxi+Service+Trajectory+-+Prediction+Challenge,+ECML+PKDD+2015 


If you need further explanations or want to ask question about the paper or the code, please do not hesitate to contact us :

Dr. Luis Moreira-Matias

luis.moreira.matias@gmail.com

luis.matias@neclab.eu

Tel. +49 6221 4342 261/
Mobile +49 163 2751 744

&   

Amal SAADALLAH

amalsaadalah@gmail.com

amal.saadallah@cs.tu-dortmund.de

Tel. +49 (0)231 755-6490

Mobile +49 (0)163 1414460
