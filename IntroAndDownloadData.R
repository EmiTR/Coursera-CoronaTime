install.packages('BatchGetSymbols')
install.packages('quantmod')
install.packages('forecast')
install.packages('fma')

library(BatchGetSymbols)
library(quantmod)
library(forecast)
#Loading data
sp500 <- GetSP500Stocks()
SnP500 <- sp500[,c(1,2,4)]
rm(sp500)

#Choosing data
Micron <- getSymbols("MU", source="yahoo", auto.assign=FALSE,return.class="xts", from = "2015-07-07")[,6]
Tesla <- getSymbols("TSLA", source="yahoo", auto.assign=FALSE,return.class="xts", from = "2015-07-07")[,6]
prices <- data.frame(Micron, Tesla)

#Visualizing
tsmicron <- ts(Micron) #convert the data into a time series data
plot(index(Micron),tsmicron, type = "l") #use index() to get the dates on the x axis when plotting a time series data

#taking out the differences in prices, might be handy for ARIMA
microndiff <- diff(tsmicron)

# When plotting the moving average functions, we have to be careful to adjust for the missing information. If we chose a 50 MA, we will
# have no data for the first 50 data points. To adjust for this, we add 50 to the date index to shift the x axis by 50 days as shown
# below. We also remove the last 50 days as we won’t have the moving average data for the same 
  
ma1 <- ma(tsmicron, 50)
plot(ma1)
plot(head(index(Micron)+50,-50), na.omit(ma1), type = "l")

