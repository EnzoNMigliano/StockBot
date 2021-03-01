# StockBot
StockBot is a automated high frequency stock trading bot 📊🤖

For this project we will assume that we are “algotraders” in a IEX stock market exchange game. We created algorithmic trading models that buy and sell stocks in the market automatically from a script running in our own EC2 instance. Our goal is to maximize our profit as a team to beat out all of the other hedge funds while trying to avoid getting penalties from the game’s rules. 

**Rules:**
•	You must make at least 250 successful trades (buy/sell) per day. Any accounts below that threshold will be penalized after the market closes that day. The penalty will be $100 per missed transaction. So, if you only make 100 successful transactions in a day, you will be penalized $1,500 for the missing 150 transactions.

•	All trading is to be done between 9:30am-4pm.

•	You can only trade the same symbol 10 times per day.

•	At the close of each day's market, all non-invested balances with a positive amount will be set to $0.00. Therefore, to participate in the next trading day, you must sell shares before buying. 

•	Failed transactions will result in a $1,000 penalty.

We started our project by assigning the correct dates and times so that our code will run the hours and the days that the market is open, to do this correctly we had to set the times to eastern time zone so our code will be in the same time zone as the tiingo stock market. To make the wait a little bit more entertaining we created a function that will show random facts we looked up while we are waiting for the market to open. After setting our starting money value which was $100,000 and the stocks we were going to work with, we built a loop that will start by buying one specific stock, and then it will start the process of buying and selling our main list of stocks selected according to its previous stocks value, meaning that it will buy the stocks with lower value and keep or sell the ones with higher values. We are setting different strategies for each team member to test out which one of them will have the best results. The strategies we choose are: 

**Candlestick Method:** With the use of 4 candles, we will try to predict the values of the stocks selected for the next couple of hours.

**Normalization min-max:** By doing min-max normalization we will normalize the data and for every feature the minimum value gets transformed into a 0, the maximum value gets transformed into a 1, and every other value gets transformed into a decimal between 0 and 1. 

**Moving average:** It will be our backward-looking indicator and it will rely on past price data to try to predict future averages of the stocks.
We created a function as an “in case of emergency” called ticker_bank that will buy a stock that we assigned to it at the end of the day, so we do not get penalized and lose the money that we have in the account. The stock chosen was bpy because it is a stable and safe to use for this purpose. 
Project Effectiveness: Include brief highlights of your project's effectiveness with key statistics and visualizations.

**The libraries required in R are the following:**
Tidyverse – install.packages(tidyverse)
Jsonlite – install.packages(jsonlite)
Team members: List the members of the team.
Enzo Migliano
Raul
Andrea Gonzalez
