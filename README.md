# StockBot
StockBot is a automated high frequency stock trading bot 📊🤖

For this project we will assume that we are “algotraders” in a IEX stock market exchange game. We created algorithmic trading models that buy and sell stocks in the market automatically from a script running in our own EC2 instance. Our goal is to maximize our profit as a team to beat out all of the other hedge funds while trying to avoid getting penalties from the game’s rules. 

## Rules:

•	You must make at least 250 successful trades (buy/sell) per day. Any accounts below that threshold will be penalized after the market closes that day. The penalty will be $100 per missed transaction. So, if you only make 100 successful transactions in a day, you will be penalized $1,500 for the missing 150 transactions.

•	All trading is to be done between 9:30am-4pm.

•	You can only trade the same symbol 10 times per day.

•	At the close of each day's market, all non-invested balances with a positive amount will be set to $0.00. Therefore, to participate in the next trading day, you must sell shares before buying. 

•	Failed transactions will result in a $1,000 penalty.

We started our project by assigning the correct dates and times so that our code will run the hours and the days that the market is open, to do this correctly we had to set the times to eastern time zone so our code will be in the same time zone as the tiingo stock market. To make the wait a little bit more entertaining we created a function that will show random facts we looked up while we are waiting for the market to open. After setting our starting money value which was $100,000 and the stocks we were going to work with, we built a loop that will start by buying one specific stock, and then it will start the process of buying and selling our main list of stocks selected according to its previous stocks value, meaning that it will buy the stocks with lower value and keep or sell the ones with higher values. We are setting different strategies for each team member to test out which one of them will have the best results. The strategies we choose are: 

## Candlestick Method:
In this bot we utilized the candles to seek for trends in the date. We would record the previous closing point and the current closing point. If the current closing point was higher than the last closing point. If not we would wait. We would only sell if the price we bought was lower than the current price

## Normalization min-max:
By doing min-max normalization we will normalize the data and for every feature the minimum value gets transformed into a 0, the maximum value gets transformed into a 1, and every other value gets transformed into a decimal between 0 and 1. Our goal is to use normalization is to transform features to be on a similar scale. This will improve the performance and training stability of the model to help us decide which stock is will result will be better to buy or sell according to its value. 

## Moving average:
It will be our backward-looking indicator and it will rely on past price data to try to predict future averages of the stocks.
We created a function as an “in case of emergency” called ticker_bank that will buy a stock that we assigned to it at the end of the day, so we do not get penalized and lose the money that we have in the account. The stock chosen was bpy because it is a stable and safe to use for this purpose. The reason for calculating the moving average of a stock is to help smooth out the price data by creating a constantly updated average price. By calculating the moving average, the impacts of random, short-term fluctuations on the price of a stock over a specified time-frame are mitigated. A simple moving average (SMA) is a calculation that takes the arithmetic mean of a given set of prices over the specific number of days in the past. Exponential moving averages (EMA) is a weighted average that gives greater importance to the price of a stock on more recent days.

## Results
Taking into consideration the final profit, amount of penalties, and final debt, our candlestick method was the strategy that performed the best. 

**The libraries required in R are the following:**
Tidyverse – install.packages(tidyverse)
Jsonlite – install.packages(jsonlite)

To run this script please make sure that the packages are properly installed and your enviroment is clean to avoid overwritten functions.  

## Team members:
1. Enzo Migliano
2. Raul Ramon
3. Andrea Gonzalez
