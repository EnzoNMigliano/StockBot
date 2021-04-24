#####################################
## StockBot - Moving Average Trader Version 2.0
#####################################


# libraries needed

#require(tidyverse) # we will not utilize the tidyverse in the moving average boy since it will be running in Ubuntu 16
require(jsonlite)



#########################################################
## START OF GLOBAL FUNCTIONS ## Functions will be separated by dots

waiting.random.facts <- function(vector){ # developed to entertain the user while they wait for the market to open
  
  your_time <- (format(Sys.time(), "%X", TZ = 'EST'))
  
  random_fact_random_index <- runif(1, min = 1, max = length(vector))
  
  cat("StockBot Faster Trader 2.0vTM is waiting till the market is open", "\n", your_time, "\n", "\n",
      "Random Fact of the day:", vector[random_fact_random_index], "\n", "\n" )
  
} # end of waiting.random.facts

is.holiday <- function(){ # checks if today's date is a weekday
  
  holidays <- c("2021-02-15",
                "2021-04-02",
                "2021-05-31",
                "2021-07-05")
  
  for(i in 1:length(holidays)){  
    if(as.character(Sys.Date()) == holidays[i]){
      
      return(TRUE)
      
    }else{
      
      return(FALSE)
      
    }
    
  }
  
} # end of is.holiday

is.weekday <- function(){ # checks if today's date is a weekday
  
  Sys.setenv(TZ='EST')
  
  todays_date <- weekdays(Sys.Date())
  
  if(todays_date == "Saturday" | todays_date == "Sunday"){
    
    is_weekday <- FALSE
    
  }else{
    
    is_weekday <- TRUE
    
  }
  
  return(is_weekday)
  
} # end of is.weekday

is.market.open <- function(){
  
  time_EST_now <- (format(Sys.time(), "%X", TZ = 'EST'))
  
  bolean <- FALSE
  
  market_open <- c("09:30:01 AM",
                   "09:30:02 AM",
                   "09:30:03 AM",
                   "09:30:04 AM",
                   "09:30:05 AM",
                   "09:30:06 AM",
                   "09:30:07 AM",
                   "09:30:08 AM",
                   "09:30:09 AM",
                   "09:30:10 AM",
                   "09:30:11 AM",
                   "09:30:12 AM",
                   "09:30:13 AM",
                   "09:30:14 AM",
                   "09:30:15 AM",
                   "09:30:16 AM",
                   "09:30:17 AM",
                   "09:30:18 AM",
                   "09:30:19 AM",
                   "09:30:20 AM",
                   "09:30:21 AM",
                   "09:30:22 AM",
                   "09:30:23 AM",
                   "09:30:24 AM",
                   "09:30:25 AM",
                   "09:30:26 AM",
                   "09:30:27 AM",
                   "09:30:28 AM",
                   "09:30:29 AM",
                   "09:30:30 AM",
                   "09:30:31 AM",
                   "09:30:32 AM",
                   "09:30:33 AM",
                   "09:30:34 AM",
                   "09:30:35 AM",
                   "09:30:36 AM",
                   "09:30:37 AM",
                   "09:30:38 AM",
                   "09:30:39 AM",
                   "09:30:40 AM",
                   "09:30:41 AM",
                   "09:30:42 AM",
                   "09:30:43 AM",
                   "09:30:44 AM",
                   "09:30:45 AM",
                   "09:30:46 AM",
                   "09:30:47 AM",
                   "09:30:48 AM",
                   "09:30:49 AM",
                   "09:30:50 AM",
                   "09:30:51 AM",
                   "09:30:52 AM",
                   "09:30:53 AM",
                   "09:30:54 AM",
                   "09:30:55 AM",
                   "09:30:56 AM",
                   "09:30:57 AM",
                   "09:30:58 AM",
                   "09:30:59 AM")
  
  for(i in 1:length(market_open)){
    if(time_EST_now %in% market_open[i]){
      
      bolean <- TRUE
      
    }else{
      
      
      
    }
    
  }
  
  return(bolean)
  
} # end of is.market.open

is.wrap.up.time <- function(){
  
  time_EST_now <- (format(Sys.time(), "%X", TZ = 'EST'))
  
  bolean <- FALSE
  
  wrap.up.time <- c("03:53:00 PM",
                    "03:53:01 PM",
                    "03:53:02 PM",
                    "03:53:03 PM",
                    "03:53:04 PM",
                    "03:53:05 PM",
                    "03:53:06 PM",
                    "03:53:07 PM",
                    "03:53:08 PM",
                    "03:53:09 PM",
                    "03:53:10 PM",
                    "03:53:11 PM",
                    "03:53:12 PM",
                    "03:53:13 PM",
                    "03:53:14 PM",
                    "03:53:15 PM",
                    "03:53:16 PM",
                    "03:53:17 PM",
                    "03:53:18 PM",
                    "03:53:19 PM",
                    "03:53:20 PM",
                    "03:53:21 PM",
                    "03:53:22 PM",
                    "03:53:23 PM",
                    "03:53:24 PM",
                    "03:53:25 PM",
                    "03:53:26 PM",
                    "03:53:27 PM",
                    "03:53:28 PM",
                    "03:53:29 PM",
                    "03:53:30 PM",
                    "03:53:31 PM",
                    "03:53:32 PM",
                    "03:53:33 PM",
                    "03:53:34 PM",
                    "03:53:35 PM",
                    "03:53:36 PM",
                    "03:53:37 PM",
                    "03:53:38 PM",
                    "03:53:39 PM",
                    "03:53:40 PM",
                    "03:53:41 PM",
                    "03:53:42 PM",
                    "03:53:43 PM",
                    "03:53:44 PM",
                    "03:53:45 PM",
                    "03:53:46 PM",
                    "03:53:47 PM",
                    "03:53:48 PM",
                    "03:53:49 PM",
                    "03:53:50 PM",
                    "03:53:51 PM",
                    "03:53:52 PM",
                    "03:53:53 PM",
                    "03:53:54 PM",
                    "03:53:55 PM",
                    "03:53:56 PM",
                    "03:53:57 PM",
                    "03:53:58 PM",
                    "03:53:59 PM",
                    "03:54:00 PM",
                    "03:54:01 PM",
                    "03:54:02 PM",
                    "03:54:03 PM",
                    "03:54:04 PM",
                    "03:54:05 PM",
                    "03:54:06 PM",
                    "03:54:07 PM",
                    "03:54:08 PM",
                    "03:54:09 PM",
                    "03:54:10 PM",
                    "03:54:11 PM",
                    "03:54:12 PM",
                    "03:54:13 PM",
                    "03:54:14 PM",
                    "03:54:03 PM",
                    "03:54:16 PM",
                    "03:54:17 PM",
                    "03:54:18 PM",
                    "03:54:19 PM",
                    "03:54:20 PM",
                    "03:54:21 PM")
  
  
  
  
  for(i in 1:length(wrap.up.time)){
    if(time_EST_now %in% wrap.up.time[i]){
      
      bolean <- TRUE
      
    }else{
      
      
    }
    
  }
  
  return(bolean)
  
} # end of is.wrap.up.time



vector.comparison <- function(vec1, vec2){ # this function will be utilized to check for erros in the in buying and selling stocks and for the time to open and close the market
  
  bolean <- vec1 == vec2
  
  count <- 0
  
  for(i in 1:length(bolean)){
    
    if(bolean[i] == TRUE){
      
      count <- count + 1
      
    }else{
      
      count <- count + -1
      
    }
    
  }
  
  if(count == length(bolean)){
    
    return(TRUE)
    
  }else{
    
    return(FALSE)
    
  }
  
} #end of vector.comparison



non.na.positions.locator <- function(vector){
  
  
  positions <- c()
  
  j <- 1
  
  for(i in 1:length(vector)){
    
    if(is.na(vector[i]) == FALSE){
      
      positions[j] <- i
      
      j <- j + 1
      
    }
    
    
    
    
    
  }
  
  return(positions)
  
} # end of non.na.position.locator


even.positions <- function(vector){
  
  
  even <- c()
  
  j <- 1
  
  for(i in 1:length(vector)){
    
    if(i %% 2 == 0){
      
      even[j] <- i
      
      j <- j + 1
      
      
    }else{
      
      
      
    }
    
    
    
  }
  
  return(even)
  
} # end of even.position



odd.positions <- function(vector){
  
  
  odd <- c()
  
  j <- 1
  
  for(i in 1:length(vector)){
    
    if(i %% 2 == 0){
      
      
    }else{
      
      odd[j] <- i
      
      j <- j + 1
      
    }
    
    
    
  }
  
  return(odd)
  
} # end of odd.positions


last.row <- function(dataframe){ # this function will be used together with the historical data from tiingo, by getting the last 
  
  
  number_of_observations <- nrow(dataframe)
  
  last_row <- dataframe[number_of_observations, ]
  
  return(last.row)
  
} # End of last.row



two.minimum.positions <- function(vector){ # this function returns the positions where the lowest values  are in given vector
  
  minimum_positions <- c()
  
  
  for(i in 1:length(vector)){
    
    if(is.na(vector[i]) == TRUE){
      
      vector[i] <- Inf
      
    }
  }
  
  j <- 1
  
  while(length(minimum_positions) <= 1){
    
    i <- 1
    
    lowest_value <- min(vector)
    
    repeat{
      
      if(vector[i] == lowest_value){
        
        minimum_positions[j] <- i
        
        vector[i] <- Inf
        
        j <- j + 1
        
        break
      }
      
      i <- i + 1
    }
    
    
    
  }
  
  return(minimum_positions)
  
} # end of two.minimum.positions




two.maximun.positions <- function(vector){ # this function returns the positions where the highest values  are in given vector
  
  maximun_positions <- c()
  
  
  for(i in 1:length(vector)){
    
    if(is.na(vector[i]) == TRUE){
      
      vector[i] <- -Inf
      
    }
  }
  
  j <- 1
  
  while(length(maximun_positions) <= 1){
    
    i <- 1
    
    highest_value <- max(vector)
    
    repeat{
      
      if(vector[i] == highest_value){
        
        maximun_positions[j] <- i
        
        vector[i] <- -Inf
        
        j <- j + 1
        
        break
      }
      
      i <- i + 1
    }
    
    
    
  }
  
  return(maximun_positions)
  
} # end of two.maximun.positions


na.positions <- function(vector){
  
  
  positions <- c()
  
  
  j <- 1
  
  for(i in 1:length(vector)){
    
    if(is.na(vector[i])){
      
      positions[j] <- i
      
      j <- j + 1
      
    }
    
    
  }
  
  return(positions)
  
} # end of na.positions


arrange.desc <- function(data_frame, column_name){
  
  
  vector_with_data <- data_frame[ , column_name]
  
  vector_sorted <- sort(vector_with_data, decreasing = TRUE)
  
  vector_positions_in_desc_order <- c(1:length(vector_with_data))
  
  j <- 1
  
  i <- 1
  
  k <- 1
  
  repeat{
    
    if(vector_sorted[i] == vector_with_data[j]){
      
      vector_positions_in_desc_order[k] <- j
      
      
      j <- 1
      
      
      k <- k + 1
      
      i <- i + 1
    }  
    
    if(i == length(vector_with_data)){
      
      
      break
    }
    
    j <- j + 1  
    
    
    
    
  }  
  
  
  
  
  
  
  
  data_final_frame <- data_frame[vector_positions_in_desc_order, ]
  
  
  
  
  return(data_final_frame)
  
  
} # end of arrange.desc we are using this function because ubunto 16 does not support tidyverse






## END OF GLOBAL FUNCTIONS
#########################################################





#################################################################
## START OF GLOBAL VARIABLES ## VAriables will be separated by underscores

global_repeat <- 0 # This variable is the one that will guide the bot through the day, we will start with zero and for then and on it will be automatized

bank_hold <- FALSE

random_facts <- c("The moon has moonquakes.", 
                  "Your nostrils work one at a time.",
                  "A chef's toque contains 100 folds",
                  "Cotton candy was invented by a dentist",
                  "Marie Curie is the only person to earn a Nobel prize in two different sciences.",
                  "Kids ask 300 questions a day.",
                  "There's a decorated war hero dog.",
                  "Water makes different pouring sounds depending on its temperature.") #This variable will contain variables to entertain the user while the user wait till the market is open


tiingo_token <- "" # This will be the variable for the Tiingo token


key_big_data_api <- "petit" # this will be the variable with the key for the big data for all


base <-  "https://bigdataforall.com/stocks/?key=" # this will the base path to buy or sell stocks in the api


base_tiingo <- "https://api.tiingo.com/iex/"


vector_tickers_done <- c() # this will have the stocks that were bough and sold 5 times


vector_tickers <- c("acb", "spot","mik", "msft","roku","anik","tsla", "keys")



vector_tickers_bench <- c("pfpt", "sdog","thd", "apls","vtwo", "var","phg","anet", "isrg","pcg", "well",
                          "play","apd","cone", "eix",
                          "alk","alv","hsbc", "dpz","bkr", "stz","awi","dri", "casy","lii","spsc", "chkp","el", "lulu","pld", "mktx","amzn","mtn", "dal")

ticker_bank <- "bpy" # this will be the stock that we are going to by at the end of the day so we do not lose the money in the account # this is a stable stock


base_data <- list() # list with the historical data of the stocks


times_the_bot_runned <- 0 # counts how many time the bot has runned in a day


money_account <- 22500/8 # We are dividing the money equally into 8 accounts


master_account <- c(money_account, money_account, money_account, money_account, money_account, money_account, money_account, money_account) # The account of money used through the day


reamining_account_money <- c(0, 0, 0, 0, 0, 0, 0, 0)


bougth_tickers <- c(NA, NA, NA, NA, NA, NA, NA, NA) # this vector will contain the tickers we have invested


price_we_bought <-c(NA, NA, NA, NA, NA, NA, NA, NA) # this will contain the values of the prices the stocks were bought 


quantity_we_bought <- c() # this will contatin the values of the quantity we are buying 


number_of_bs_transactions <- c(0,0,0,0,0,0,0,0) # this will count how many times we bougth and sold a stock if a stock has 5 it will be moved to the at vector_tickers_done


error <- utf8ToInt("Error") # this variable will be utilized to check for errors with the bigdata for all API


starting_money_account <- c(2815.5, 2815.5, 2815.5, 2815.5, 2815.5, 2815.5, 2815.5, 2815.5) # this will keep track how much money each stock started to see the profit by the end of the day


profit_tickers_done <- c() # this vector will store the profit of each ticker that is done through the day



## END OF THE GLOBAL VARIEBLES
#################################################################





###################################################
## StockBot - Fast Trader Version 2.0 - SOURCE CODE


repeat{
  
  
  if(global_repeat == 0){ #The beginning of a day of trade
    
    is_weekday <- is.weekday()
    
    is_holiday <- is.holiday()
    
    is_market_open <- is.market.open()
    
    if(is_weekday == TRUE && is_holiday == FALSE && is_market_open == TRUE){
      
      today_date <- Sys.Date() # This will be the variable utilized in the transactions through the day
      
      repeat{ # daily repeat for trade hours
        
        wrap_up_time <- is.wrap.up.time()
        
        if(wrap_up_time == TRUE){ # We will wrap up, meaning, sell stocks and then buy the bank stock
          
          position_to_sell <- non.na.positions.locator(bougth_tickers)
          
          second_position_to_sell <- 2
          
          number_of_even_positions <- length(even.positions(position_to_sell))
          
          times_even <- 1
          
          for(i in odd.positions(position_to_sell)){ # here we sell the odd ones 
            
            quantity_to_sell <- quantity_we_bought[position_to_sell[i]]
            
            url <- paste(base, key_big_data_api, "&tiingo_key=", tiingo_token, "&request=sell&symbol=", vector_tickers[position_to_sell[i]], "&quantity=", quantity_to_sell, sep="") # this is will be url to buy the stocks
            
            
            receipt <- (utf8ToInt(read_json(url)$description)[1:5])
            
            if(vector.comparison(receipt, error) == TRUE){
              
              # We need to figure out how to handle errors
              
            }else{
              
              cat("StockBot is selling:", vector_tickers[position_to_sell[i]], "\n", "\n")
              
              url <- paste(base_tiingo, vector_tickers[position_to_sell[i]] ,"/prices?","token=", tiingo_token, "&startDate=", today_date, "&resampleFreq=1min", "&format=csv", sep="")
              
              new_data <- last.row(read.csv(url))    
              
              current_price[position_to_sell[i]] <- new_data$close  
              
              profit <- quantity_to_sell*current_price[position_to_sell[i]]
              
              master_account[position_to_sell[i]] <- profit + reamining_account_money[position_to_sell[i]]
              
              bougth_tickers[positions_to_buy[i]] <- NA
              
              number_of_bs_transactions[position_to_sell[i]] <- number_of_bs_transactions[position_to_sell[i]] + 1
              
            }
            
            if(times_even <= number_of_even_positions){ # here we sell the even ones
              
              
              quantity_to_sell <- quantity_we_bought[position_to_sell[second_position_to_sell]]
              
              url <- paste(base, key_big_data_api, "&tiingo_key=", tiingo_token, "&request=sell&symbol=", vector_tickers[position_to_sell[second_position_to_sell]],"&quantity=", quantity_to_sell, sep="") # this is will be url to buy the stocks
              
              
              receipt <- (utf8ToInt(read_json(url)$description)[1:5])
              
              if(vector.comparison(receipt, error) == TRUE){
                
                # We need to figure out how to handle errors
                
              }else{
                
                cat("StockBot is selling:", vector_tickers[position_to_sell[second_position_to_sell]], "\n", "\n")
                
                url <- paste(base_tiingo, vector_tickers[position_to_sell[second_position_to_sell]] ,"/prices?","token=", tiingo_token, "&startDate=", today_date, "&resampleFreq=1min", "&format=csv", sep="")
                
                new_data <- last.row(read.csv(url))    
                
                current_price[position_to_sell[second_position_to_sell]] <- new_data$close 
                
                profit <- quantity_to_sell*current_price[position_to_sell[second_position_to_sell]]
                
                master_account[position_to_sell[second_position_to_sell]] <- profit + reamining_account_money[position_to_sell[second_position_to_sell]]
                
                bougth_tickers <- bougth_tickers[-positions_to_buy[second_position_to_sell]]
                
                number_of_bs_transactions[position_to_sell[second_position_to_sell]] <- number_of_bs_transactions[position_to_sell[second_position_to_sell]] + 1
                
              }
              
              second_position_to_sell <- second_position_to_sell + 2
              
              times_even <- 1 + times_even 
              
            }
            
            Sys.sleep(60)
            
          }
          
          # buy one stock that will keep your money for the next day
          sum_of_account <- sum(master_account) # We need to have a variable that will store all the money 
          
          cat("StockBot is buying the last stock of the day", "\n",
              "StockBot final account money was of $", sum_of_account, "\n")
          
          comparing_account <- sum_of_account - 100000
          
          if(comparing_account >= 0){
            
            cat("StockBot period profit was $",  comparing_account, ":)", "\n")
            
          }else{
            
            cat("StockBot period loss was $",  comparing_account, ":(","\n")
            
          }
          
          cat("StockBot is securing the money by buying BPY", "\n", "\n")
          
          # We need to buy the bank_ticker when that happens code still missing
          
          url <- paste("https://api.tiingo.com/iex/",ticker_bank,"/prices?token=",tiingo_token,"&startDate=", today_date, "&resampleFreq=1min&format=csv", sep = "" )
          
          
          buying_bank_ticker <- last.row(read.csv(url))
          
          price_of_bank <- buying_bank_ticker$close[1]
          
          quantity_to_buy_bank <- (sum_of_account%/%price_of_bank) - 1
          
          
          url <- paste(base, key_big_data_api, "&tiingo_key=", tiingo_token, "&request=buy&symbol=", ticker_bank,"&quantity=", quantity_to_buy_bank, sep="") # this is will be url to buy the stocks
          
          transaction <- read_json(url)
          
          
          
          
          receipt <- (utf8ToInt(transaction$description)[1:5])
          
          
          if(vector.comparison(receipt, error) == TRUE){
            
            
            cat("StockBot was unable to buy the bank stock", "\n", "\n")
            
            # We need to figure out how to handle errors
            
          }else{
            
            quantity_to_buy_bank <- transaction$quantity
            
            charity <- sum_of_account - (quantity_to_buy_bank * price_of_bank)
            
            cat("StockBot was able to buy the bank stock", "\n",
                "$", charity, "was given to the Big Data for All charity fund", ":)","\n", "\n")
            
          }
          
          
          bank_hold <- TRUE #This indicates we have the money saved in the stocks for baking
          
          global_repeat <- 1 #This indicates we are going to perform post market analysis
          
          
          break
          
          
        }else if(length(vector_tickers) == 0){
          
          sum_of_account <- sum(master_account) # We need to have a variable that will store all the money 
          
          cat("StockBot is buying the last stock of the day", "\n",
              "StockBot final account money was of $", sum_of_account, "\n")
          
          comparing_account <- sum_of_account - 100000
          
          if(comparing_account >= 0){
            
            cat("StockBot period profit was $",  comparing_account, ":)", "\n")
            
          }else{
            
            cat("StockBot period loss was $",  comparing_account, ":(","\n")
            
          }
          
          cat("StockBot is securing the money by buying BPY", "\n", "\n")
          
          # We need to buy the bank_ticker when that happens code still missing
          
          url <- paste("https://api.tiingo.com/iex/",ticker_bank,"/prices?token=",tiingo_token,"&startDate=", today_date, "&resampleFreq=1min&format=csv", sep = "" )
          
          buying_bank_ticker <- last.row(read.csv(url))
          
          price_of_bank <- buying_bank_ticker$close[1]
          
          quantity_to_buy_bank <- (sum_of_account%/%price_of_bank) - 1
          
          
          url <- paste(base, key_big_data_api, "&tiingo_key=", tiingo_token, "&request=buy&symbol=", ticker_bank,"&quantity=", quantity_to_buy_bank, sep="") # this is will be url to buy the stocks
          
          transaction <- read_json(url)
          
          receipt <- (utf8ToInt(transaction$description)[1:5])
          
          
          if(vector.comparison(receipt, error) == TRUE){
            
            
            cat("StockBot was unable to buy the bank stock", "\n", "\n")
            
            # We need to figure out how to handle errors
            
          }else{
            
            quantity_to_buy_bank <- transaction$quantity
            
            charity <- sum_of_account - (quantity_to_buy_bank * price_of_bank)
            
            cat("StockBot was able to buy the bank stock", "\n",
                "$", charity, "was given to the Big Data for All charity fund", ":)","\n", "\n")
            
          }
          # we need to create a condition for the day two so the money is equally distributed at the acounts (this in the updating part)
          
          bank_hold <- TRUE #This indicates we have the money saved in the stocks for baking
          
          global_repeat <- 1 #This sets up the post market update
          
          break
          
        }else{ #Here is where the trade day start
          
          if(bank_hold == TRUE){ # We start by asking if we have any bank stocks bought if yes we sell it to start the day
            
            quantity_to_sell <- quantity_to_buy_bank
            
            url <- paste(base, key_big_data_api, "&tiingo_key=", tiingo_token, "&request=sell&symbol=", ticker_bank,"&quantity=", quantity_to_sell, sep="") # this is will be url to sell the stocks
            
            transaction <- read_json(url)
            
            receipt <- (utf8ToInt(transaction$description)[1:5])
            
            if(vector.comparison(receipt, error) == TRUE){
              
              cat("StockBot hopes you never see this :)", "\n",
                  "if you do call 0800-000-000", "\n", "\n")
              # We need to figure out how to handle errors
              
            }else{
              
              # the variable is called buying_bank_tickers but we are actually selling it :)
              
              url <- paste("https://api.tiingo.com/iex/",ticker_bank,"/prices?token=",tiingo_token,"&startDate=", today_date, "&resampleFreq=1min&format=csv", sep = "" )
              
              buying_bank_ticker <- last.row(read.csv(url))
              
              
              
              
              price_of_bank <- transaction$price
              
              total_for_the_master_account <- (quantity_to_sell * price_of_bank) - money_lost_punishment
              
              each_position_vector_master_account <- total_for_the_master_account/8
              
              for(i in 1:length(master_account)){
                
                master_account[i] <- each_position_vector_master_account
                
              }
              
              starting_money_account <- master_account 
              
              cat("StockBot has all the money in the master account for the day", "\n", "\n")
              
            }
            
            bank_hold <- FALSE #This indicates we no longer have the money saved in the stocks for baking
            
          } # End of bank_hold == TRUE
          
          # The operations above were for closing hours initializing the day now we will starting trading for the day
          
          if(times_the_bot_runned == 0){
            
            cat("StockBot is performing the first market search of the day...","\n", "\n") 
            
            for(i in 1:length(vector_tickers)){
              
              
              
              url <- paste(base_tiingo, vector_tickers[i] ,"/prices?","token=", tiingo_token, "&startDate=", today_date, "&resampleFreq=1min", "&format=csv", sep="")
              
              base_data[[i]]<- last.row(read.csv(url))
              
            } # this closes the for loop to get the new data from the stocks
            
            times_the_bot_runned <- times_the_bot_runned + 1
            
          } else if(times_the_bot_runned <= 4){      # this closes the condiditonal if times_the_bot_runned == 0  and opens the new statemtn for the conditional  
            
            cat("StockBot is waiting for enough data points...","\n", "\n")
            
            for(i in 1:length(vector_tickers)){
              
              
              
              url <- paste(base_tiingo, vector_tickers[i] ,"/prices?","token=", tiingo_token,  "&startDate=", today_date, "&resampleFreq=1min", "&format=csv", sep="")
              
              new_data <- last.row(read.csv(url))    
              
              old_data <- base_data[[i]]
              
              base_data[[i]] <- rbind(old_data, new_data)    
              
            } # this closes the for loop to get the new data from the stocks
            
            
            
            times_the_bot_runned <- times_the_bot_runned + 1 # this will increment up to 6 times and then go to the next conditional
            
          }else{ # this closes the conditional from the the algo has sufficinet observations to make decisions (meaning the algo is already running)  
            
            old_moving_average <- c() # creating a tempporary vector to store the old moving average
            
            new_moving_average <- c() # creating a temporary vector to store the new moving average
            
            
            current_price <- c()
            
            cat("StockBot is updating the data...", "\n", "\n")
            
            for(i in 1:length(base_data)){
              
              old_moving_average[i] <- sum((base_data[[i]])[ , "close"])/5
              
            } # This closes the old moving average
            
            
            for(i in 1:length(vector_tickers)){
              
              
              url <- paste(base_tiingo, vector_tickers[i] ,"/prices?","token=", tiingo_token, "&startDate=", today_date, "&resampleFreq=1min", "&format=csv", sep="")
              
              new_data <- last.row(read.csv(url))    
              
              current_price[i] <- new_data$close       
              
              old_data <- base_data[[i]]
              
              base_data[[i]] <- (rbind(old_data, new_data))[2:6, ] 
              
              new_moving_average[i] <-  sum((base_data[[i]])[ , "close"])/5    
              
              
            } # end of for(i in 1:length(vector_tickers))
            
            
            cat("StockBot is analyzing trading opportunities...", "\n", "\n")
            
            if(length(non.na.positions.locator(bougth_tickers)) == 0){                    # starting the conditionals to sell if is zero it means we are completely out of the market
              
              moving_average_minus_current_price <-  current_price - new_moving_average
              
              positions_to_buy <- two.minimum.positions(moving_average_minus_current_price)
              
              if(moving_average_minus_current_price[positions_to_buy[1]] < 0){
                
                
                quantity_to_buy <- master_account[positions_to_buy[1]]%/%current_price[positions_to_buy[1]]
                
                
                url <- paste(base, key_big_data_api, "&tiingo_key=", tiingo_token, "&request=buy&symbol=", vector_tickers[positions_to_buy[1]],"&quantity=", quantity_to_buy, sep="") # this is will be url to buy the stocks
                
                transaction <- read_json(url)
                
                receipt <- (utf8ToInt(transaction$description)[1:5])
                
                if(vector.comparison(receipt,error) == TRUE){
                  
                  cat("Error in buying", vector_tickers[positions_to_buy[1]], "\n", "\n")
                  
                  global_repeat <- 2
                  
                  break
                  
                }else{
                  
                  cat("StockBot is buying:", vector_tickers[positions_to_buy[1]], "\n", "\n")
                  
                  remainder_from_transction <- master_account[positions_to_buy[1]] - (quantity_to_buy * current_price[positions_to_buy[1]])
                  
                  quantity_we_bought[positions_to_buy[1]] <- transaction$quantity
                  
                  
                  reamining_account_money[positions_to_buy[1]] <- remainder_from_transction
                  
                  
                  price_we_bought[positions_to_buy[1]] <- transaction$price
                  
                  
                  bougth_tickers[positions_to_buy[1]] <- vector_tickers[positions_to_buy[1]]
                  
                  
                  
                  
                  if(moving_average_minus_current_price[positions_to_buy[2]] < 0){
                    
                    
                    quantity_to_buy <- master_account[positions_to_buy[2]]%/%current_price[positions_to_buy[2]]
                    
                    url <- paste(base, key_big_data_api, "&tiingo_key=", tiingo_token, "&request=buy&symbol=", vector_tickers[positions_to_buy[2]],"&quantity=", quantity_to_buy, sep="") # this is will be url to buy the stocks
                    
                    
                    transaction <- read_json(url)
                    
                    receipt <- (utf8ToInt(transaction$description)[1:5])
                    
                    
                    if(vector.comparison(receipt,error) == TRUE){
                      
                      cat("Error in buying", vector_tickers[positions_to_buy[2]], "\n", "\n")
                      
                      
                      
                      global_repeat <- 2
                      
                      break
                      
                    }else{
                      
                      cat("StockBot is buying:", vector_tickers[positions_to_buy[2]], "\n", "\n")
                      
                      remainder_from_transction <- master_account[positions_to_buy[2]] - (quantity_to_buy * current_price[positions_to_buy[2]])
                      
                      
                      quantity_we_bought[positions_to_buy[2]] <- transaction$quantity
                      
                      
                      reamining_account_money[positions_to_buy[2]] <- remainder_from_transction
                      
                      
                      price_we_bought[positions_to_buy[2]] <- transaction$price
                      
                      
                      bougth_tickers[positions_to_buy[2]] <- vector_tickers[positions_to_buy[2]] 
                      
                    }                                                                                             
                    
                  }
                  
                }
                
              }else{
                
                cat("No stock(s) with a feasible windown to buy at the moment... StockBot apologies for the inconvinience :)", "\n", "\n")
                
              }
              
              
            }else{ # if the length is not equal to zero it means that we bougth a ticker
              
              selling_opportunity  <- price_we_bought - current_price
              
              position_to_sell <- two.minimum.positions(selling_opportunity)
              
              if(selling_opportunity[position_to_sell[1]] <= 0 && is.na(selling_opportunity[position_to_sell[1]]) == FALSE){
                
                quantity_to_sell <- quantity_we_bought[position_to_sell[1]]
                
                url <- paste(base, key_big_data_api, "&tiingo_key=", tiingo_token, "&request=sell&symbol=", vector_tickers[position_to_sell[1]],"&quantity=", quantity_to_sell, sep="") # this is will be url to buy the stocks
                
                transaction <- read_json(url)
                
                receipt <- (utf8ToInt(transaction$description)[1:5])
                
                if(vector.comparison(receipt, error) == TRUE){
                  
                  cat("Error in selling", vector_tickers[position_to_sell[1]], "\n", "\n")
                  
                  
                  
                  global_repeat <- 2
                  
                  break
                  
                }else{
                  
                  cat("StockBot is selling:", vector_tickers[position_to_sell[1]], "\n", "\n")
                  
                  profit <- quantity_to_sell*transaction$price
                  
                  master_account[position_to_sell[1]] <- profit + reamining_account_money[position_to_sell[1]]
                  
                  bougth_tickers[position_to_sell[1]] <- NA
                  
                  number_of_bs_transactions[position_to_sell[1]] <- number_of_bs_transactions[position_to_sell[1]] + 1
                  
                  price_we_bought[position_to_sell[1]] <- NA
                  
                  
                  
                  position_transactions <- two.maximun.positions(number_of_bs_transactions) # we need to get the highest ones in the number_of_bs_transactions
                  
                  
                  
                  if(number_of_bs_transactions[position_transactions[1]] <= 4){ # then use the highest ones for this nexcompditions
                    
                    cat("No stock(s) with a feasible windown to sell at the moment... StockBot apologies for the inconvinience :)", "\n", "\n")
                    
                    position_vector_done <- length(vector_tickers_done) + 1 # this gives the position for placing the tickers that were done for the day (5 plus transactions)
                    
                    profit_tickers_done[position_vector_done] <- (master_account[position_transactions[1]] - starting_money_account[position_transactions[1]]) # gets the profit
                    
                    starting_money_account[position_transactions[1]] <- master_account[position_transactions[1]] # update the starting money in the account for the next stock
                    
                    vector_tickers_done[position_vector_done] <- vector_tickers[position_transactions[1]] # move vector that has done 10 transactions to the done vector
                    
                    vector_tickers[position_transactions[1]] <- vector_tickers_bench[length(vector_tickers_bench)] # updaates the vector ticker
                    
                    number_of_bs_transactions[position_transactions[1]] <- 0
                    
                    vector_tickers_bench <- vector_tickers_bench[-(length(vector_tickers_bench))] # updaates the vector bench 
                    
                    url <- paste(base_tiingo, vector_tickers[position_transactions[1]] ,"/prices?","token=", tiingo_token, "&startDate=",today_date, "&resampleFreq=1min", "&format=csv", sep="")
                    
                    new_data <- (read.csv(url))
                    
                    base_data[[position_transactions[1]]] <- new_data[(length(new_data) - 5):length(new_data)] # check this
                    
                    
                  }
                  
                  if(selling_opportunity[position_to_sell[2]] <= 0 && is.na(selling_opportunity[position_to_sell[2]]) == FALSE){  
                    
                    
                    quantity_to_sell <- quantity_we_bought[position_to_sell[2]]
                    
                    url <- paste(base, key_big_data_api, "&tiingo_key=", tiingo_token, "&request=sell&symbol=", vector_tickers[position_to_sell[2]],"&quantity=", quantity_to_sell, sep="") # this is will be url to buy the stocks
                    
                    transaction <- read_json(url)
                    
                    receipt <- (utf8ToInt(transaction$description)[1:5])
                    
                    
                    if(vector.comparison(receipt, error) == TRUE){
                      
                      cat("Error in selling", vector_tickers[position_to_sell[2]], "\n", "\n")
                      
                      global_repeat <- 2
                      
                      break
                      
                    }else{
                      
                      cat("StockBot is selling:", vector_tickers[position_to_sell[2]], "\n", "\n")
                      
                      profit <- quantity_to_sell*transaction$price
                      
                      master_account[position_to_sell[2]] <- profit + reamining_account_money[position_to_sell[2]]
                      
                      bougth_tickers[position_to_sell[2]] <- NA
                      
                      number_of_bs_transactions[position_to_sell[2]] <- number_of_bs_transactions[position_to_sell[2]] + 1
                      
                      price_we_bought[position_to_sell[2]] <- NA
                      
                      moving_average_minus_current_price <-  current_price - new_moving_average
                      
                      positions_to_buy <- two.minimum.positions(moving_average_minus_current_price)
                      
                      
                      
                      
                      if(number_of_bs_transactions[position_transactions[2]] <= 4){
                        
                        position_vector_done <- length(vector_tickers_done) + 1 # this gives the position for placing the tickers that were done for the day (5 plus transactions)
                        
                        profit_tickers_done[position_vector_done] <- ( master_account[position_transactions[2]] - starting_money_account[position_transactions[2]])
                        
                        starting_money_account[position_transactions[2]] <- master_account[position_transactions[2]]  
                        
                        vector_tickers_done[position_vector_done] <- vector_tickers[position_transactions[2]]
                        
                        vector_tickers[position_transactions[2]] <- vector_tickers_bench[length(vector_tickers_bench)]
                        
                        number_of_bs_transactions[position_transactions[2]] <- 0
                        
                        vector_tickers_bench <- vector_tickers_bench[-(length(vector_tickers_bench))] 
                        
                        url <- paste(base_tiingo, vector_tickers[position_transactions[2]] ,"/prices?","token=", tiingo_token, "&startDate=",today_date, "&resampleFreq=1min", "&format=csv", sep="")
                        
                        new_data <- (read.csv(url))
                        
                        base_data[[position_transactions[2]]] <- new_data[(length(new_data) - 5):length(new_data)]
                      }
                      
                      
                      
                      if(selling_opportunity[position_to_sell[1]] > 0 && is.na(selling_opportunity[position_to_sell[1]]) == FALSE) { # check this conditional  selling_opportunity[position_to_sell[2]] < 0  if we couldnt buy x we sell y
                        
                        if(moving_average_minus_current_price[positions_to_buy[1]] < 0 && is.na(bougth_tickers[positions_to_buy[1]]) == TRUE){
                          
                          
                          quantity_to_buy <- master_account[positions_to_buy[1]]%/%current_price[positions_to_buy[1]]
                          
                          
                          url <- paste(base, key_big_data_api, "&tiingo_key=", tiingo_token, "&request=buy&symbol=", vector_tickers[positions_to_buy[1]],"&quantity=", quantity_to_buy, sep="") # this is will be url to buy the stocks
                          
                          transaction <- read_json(url)
                          
                          receipt <- (utf8ToInt(transaction$description)[1:5])
                          
                          quantity_to_buy <- transaction$quantity
                          
                          
                          if(vector.comparison(receipt,error) == TRUE){
                            
                            cat("Error in buying", vector_tickers[positions_to_buy[1]], "\n", "\n")
                            
                            global_repeat <- 2
                            
                            break
                            
                          }else{
                            
                            cat("StockBot is buying:", vector_tickers[positions_to_buy[1]], "\n", "\n")
                            
                            remainder_from_transction <- master_account[positions_to_buy[1]] - (quantity_to_buy * transaction$price)
                            
                            quantity_we_bought[positions_to_buy[1]] <- quantity_to_buy
                            
                            
                            reamining_account_money[positions_to_buy[1]] <- remainder_from_transction
                            
                            
                            price_we_bought[positions_to_buy[1]] <- transaction$price
                            
                            
                            bougth_tickers[positions_to_buy[1]] <- vector_tickers[positions_to_buy[1]]
                            
                            
                            if(selling_opportunity[position_to_sell[2]] > 0 && is.na(selling_opportunity[position_to_sell[2]]) == FALSE){  # check this conditional  selling_opportunity[position_to_sell[2]] < 0  if we couldnt buy x we sell y
                              
                              if(moving_average_minus_current_price[positions_to_buy[2]] < 0 && is.na(bougth_tickers[positions_to_buy[2]]) == TRUE){
                                
                                
                                quantity_to_buy <- master_account[positions_to_buy[2]]%/%current_price[positions_to_buy[2]]
                                
                                url <- paste(base, key_big_data_api, "&tiingo_key=", tiingo_token, "&request=buy&symbol=", vector_tickers[positions_to_buy[2]],"&quantity=", quantity_to_buy, sep="") # this is will be url to buy the stocks
                                
                                
                                transaction <- read_json(url)
                                
                                receipt <- (utf8ToInt(transaction$description)[1:5])
                                
                                quantity_to_buy <- transaction$quantity
                                
                                
                                if(vector.comparison(receipt,error) == TRUE){
                                  
                                  cat("Error in buying", vector_tickers[positions_to_buy[2]], "\n", "\n")
                                  
                                  global_repeat <- 2
                                  
                                  break
                                  
                                }else{
                                  
                                  cat("StockBot is buying:", vector_tickers[positions_to_buy[2]], "\n", "\n")
                                  
                                  remainder_from_transction <- master_account[positions_to_buy[2]] - (quantity_to_buy * transaction$price)
                                  
                                  
                                  quantity_we_bought[positions_to_buy[2]] <- quantity_to_buy
                                  
                                  
                                  reamining_account_money[positions_to_buy[2]] <- remainder_from_transction
                                  
                                  
                                  price_we_bought[positions_to_buy[2]] <- transaction$price
                                  
                                  
                                  bougth_tickers[positions_to_buy[2]] <- vector_tickers[positions_to_buy[2]] 
                                  
                                  
                                  
                                }                                                                                             
                                
                              }
                              
                            }
                            
                          }
                          
                        }else{
                          
                          cat("No stock(s) with a feasible windown to buy at the moment... StockBot apologies for the inconvinience :)", "\n", "\n")
                          
                        }
                        
                      } # closing  selling_opportunity[position_to_sell[2]] > 0
                      
                    } # this is closing the last sellling
                    
                  } # this is closing selling_opportunity[position_to_sell[2]] < 0
                  
                } # this is closing vector.comparison(receipt, error) == TRUE
                
                
              }else if(length(non.na.positions.locator(bougth_tickers)) < 8){
                
                cat("No stock(s) with a feasible windown to sell at the moment... StockBot apologies for the inconvinience :)", "\n",
                    "Trying to seek for a buying windown" ,"\n", "\n")
                
                positions_still_open_to_buy <- na.positions(bougth_tickers)
                
                moving_average_minus_current_price <-  current_price - new_moving_average
                
                positions_still_open <- 1
                
                for(i in 1:length(moving_average_minus_current_price)){
                  
                  if(i == positions_still_open_to_buy[positions_still_open]  && is.na(positions_still_open_to_buy[positions_still_open]) == FALSE){
                    
                    
                    positions_still_open <- positions_still_open + 1
                    
                  }else{
                    
                    moving_average_minus_current_price[i] <- Inf
                    
                    
                  }
                  
                  
                }
                
                
                
                positions_to_buy <-two.maximun.positions(moving_average_minus_current_price)
                
                
                if(moving_average_minus_current_price[positions_to_buy[1]] < 0){
                  
                  
                  quantity_to_buy <- master_account[positions_to_buy[1]]%/%current_price[positions_to_buy[1]]
                  
                  
                  url <- paste(base, key_big_data_api, "&tiingo_key=", tiingo_token, "&request=buy&symbol=", vector_tickers[positions_to_buy[1]],"&quantity=", quantity_to_buy, sep="") # this is will be url to buy the stocks
                  
                  
                  transaction <- read_json(url)
                  
                  receipt <- (utf8ToInt(transaction$description)[1:5])
                  
                  quantity_to_buy <- transaction$quantity
                  
                  if(vector.comparison(receipt,error) == TRUE){
                    
                    cat("Error in buying", vector_tickers[positions_to_buy[1]], "\n", "\n")
                    
                    global_repeat <- 2
                    
                    break
                    
                  }else{
                    
                    cat("StockBot is buying:", vector_tickers[positions_to_buy[1]], "\n", "\n")
                    
                    remainder_from_transction <- master_account[positions_to_buy[1]] - (quantity_to_buy * transaction$price)
                    
                    quantity_we_bought[positions_to_buy[1]] <- quantity_to_buy
                    
                    
                    reamining_account_money[positions_to_buy[1]] <- remainder_from_transction
                    
                    
                    price_we_bought[positions_to_buy[1]] <- transaction$price
                    
                    
                    bougth_tickers[positions_to_buy[1]] <- vector_tickers[positions_to_buy[1]]
                    
                    
                    if(length(non.na.positions.locator(bougth_tickers)) < 8){
                      
                      if(moving_average_minus_current_price[positions_to_buy[2]] < 0){
                        
                        
                        quantity_to_buy <- master_account[positions_to_buy[2]]%/%current_price[positions_to_buy[2]]
                        
                        url <- paste(base, key_big_data_api, "&tiingo_key=", tiingo_token, "&request=buy&symbol=", vector_tickers[positions_to_buy[2]],"&quantity=", quantity_to_buy, sep="") # this is will be url to buy the stocks
                        
                        transaction <- read_json(url)
                        
                        receipt <- (utf8ToInt(transaction$description)[1:5])
                        
                        quantity_to_buy <- transaction$quantity
                        
                        if(vector.comparison(receipt,error) == TRUE){
                          
                          cat("Error in buying", vector_tickers[positions_to_buy[2]], "\n", "\n")
                          
                          global_repeat <- 2
                          
                          break
                          
                        }else{
                          
                          cat("StockBot is buying:", vector_tickers[positions_to_buy[2]], "\n", "\n")
                          
                          remainder_from_transction <- master_account[positions_to_buy[2]] - (quantity_to_buy * transaction$price)
                          
                          
                          quantity_we_bought[positions_to_buy[2]] <- quantity_to_buy
                          
                          
                          reamining_account_money[positions_to_buy[2]] <- remainder_from_transction
                          
                          
                          price_we_bought[positions_to_buy[2]] <- transaction$price
                          
                          
                          bougth_tickers[positions_to_buy[2]] <- vector_tickers[positions_to_buy[2]] 
                          
                        }                                                                                             
                        
                      }
                      
                    }
                    
                  }
                  
                }
                
              }else{
                
                cat("No stock(s) with a feasible windown to sell nor to buy at the moment... StockBot apologies for the inconvinience :)", "\n", "\n")
                
              } # this is closing selling_opportunity[position_to_sell[1]] < 0 
              
              
              
            } # this is closing  # if the length is not equal to zero it means that we bougth a ticker
            
            
          } # end of this closes the conditional from the the algo has sufficinet observations to make decisions (meaning the algo is already running)
          
        } # end of else #here is where the trade day start
        
        Sys.sleep(60)
        
      } # end of # daily repeat for trade hours
      
      
    }else{
      
      waiting.random.facts(random_facts)
      
    }
    
    
    
  }else if(global_repeat == 1){ # The post market analysis
    
    
    # Here you are going to do our the post market analysis for the next day
    
    
    # getting to know if we were penalized :(
    
    times_successful_transactions <- sum(number_of_bs_transactions) + (10*length(vector_tickers_done))
    
    
    ## setting the conditionals for the penalties
    
    if(times_successful_transactions >= 250){
      
      cat("Dale! StockBot made more than 250 transactions", "\n", "\n")
      
      money_lost_punishment <- 0
      
    }else{
      
      number_of_transacitons_missed <- 250 - times_successful_transactions
      
      money_lost_punishment <- number_of_transacitons_missed * 100
      
      cat(" :( StockBot made less than 250 sucessful transactions...", "\n", "\n")
      
      cat("StockBot made", times_successful_transactions, "transactions", "\n", "\n")
      
      cat("StockBot is calculating the punishment...", "\n", "\n")
      
      cat("The punishment will be of $", money_lost_punishment, "\n", "\n")
      
      
      
      # We ahve to come back here when figure how to buy the bank stock (DONE)
      
    }
    ## chosing the best stocks for the next day  
    Sys.sleep(10)
    
    cat("StockBot is calculating the best stocks of the day...", "\n", "\n")
    
    if(length(profit_tickers_done == 0)){
      
      profit_tickers_done <- NA
      
    }
    
    
    analysis_data <- as.data.frame(cbind(vector_tickers_done,profit_tickers_done)) 
    
    
    analysis_data <- arrange.desc(analysis_data, "profit_tickers_done")
    
    
    #analysis_data <- analysis_data %>% arrange(desc(profit_tickers_done)) we are utilizng our own function 
    
    
    
    if(nrow(analysis_data) == 42){ # conditionals to reset the vector_tickers series 
      
      vector_tickers <- (analysis_data$vector_tickers_done)[1:8]
      
      vector_tickers_bench <- (analysis_data$vector_tickers_done)[9:42]  ##Move the best stocks to the main vector and push back the stocks that performed bad to the bench
      
      vector_tickers_done <- c() 
      
    }else if(nrow(analysis_data) == 8){
      
      temp_vector <- vector_tickers
      
      temp_vector[length(temp_vector):32] <- vector_tickers_bench
      
      vector_tickers_bench <- temp_vector
      
      rm(temp_vector)
      
      vector_tickers <- (analysis_data$vector_tickers_done)[1:8]
      
      vector_tickers_done <- c()
      
    }else if(nrow(analysis_data) < 42 && nrow(analysis_data) > 8){
      
      
      temp_vector <- vector_tickers
      
      vector_tickers <- (analysis_data$vector_tickers_done)[1:8]
      
      temp_vector[length(temp_vector):(length(temp_vector) + length(vector_tickers_bench))] <- vector_tickers_bench 
      
      vector_tickers_bench <- temp_vector
      
      vector_tickers_done <- c()
      
    }else{
      
      temp_vector <- vector_tickers
      
      temp_vector[length(temp_vector):(length(temp_vector)+length(vector_tickers_bench))] <- vector_tickers_bench
      
      vector_tickers_bench <- temp_vector
      
      rm(temp_vector)
      
      need_to_complete_ticker_vector <- 8 - length(vector_tickers_done)
      
      vector_tickers[1:length(vector_tickers_done)] <- vector_tickers_done
      
      vector_tickers[length(vector_tickers):8] <-  vector_tickers_bench[(length(vector_tickers_bench)-need_to_complete_ticker_vector):length(vector_tickers_bench)]              
      
      vector_tickers_bench <- vector_tickers_bench[-((length(vector_tickers_bench)- need_to_complete_ticker_vector):length(vector_tickers_bench))]
      
      vector_tickers_done <- c()
      
    }
    
    
    
    # resetting all the data  
    
    Sys.sleep(10)
    
    cat("StockBot is reseting global variables for the next day...", "\n", "\n")
    
    reamining_account_money <- c(0, 0, 0, 0, 0, 0, 0, 0)
    
    number_of_bs_transactions <- c(0,0,0,0,0,0,0,0)
    
    times_the_bot_runned <- 0
    
    bougth_tickers <- c(NA, NA, NA, NA, NA, NA, NA, NA) 
    
    price_we_bought <-c(NA, NA, NA, NA, NA, NA, NA, NA) 
    
    quantity_we_bought <- c()
    
    profit_tickers_done <- c()
    
    base_data <- list()
    
    
    
    ## setting up for the next market opening
    
    
    
    cat("StockBot closed hours market update... DONE!", "\n", "\n")
    
    
    global_repeat <- 0
    
  }else{ # The safe mode
    
    #  the safe mode when a error happens
    
    Sys.sleep(60)
    
    cat("You are in safe mode, please remain calm StockBot is doing everything possible to secure your money",
        "\n", "\n")
    
    
    if(length(non.na.positions.locator(bougth_tickers)) < 8){
      
      
      sum_of_account <- sum(master_account) - 1000
      
      
    }else{
      
      position_to_sell <- non.na.positions.locator(bougth_tickers)
      
      second_position_to_sell <- 2
      
      number_of_even_positions <- length(even.positions(position_to_sell))
      
      times_even <- 1
      
      for(i in odd.positions(position_to_sell)){ # here we sell the odd ones 
        
        url <- paste(base_tiingo, vector_tickers[position_to_sell[i]] ,"/prices?","token=", tiingo_token, "&startDate=", today_date, "&resampleFreq=1min", "&format=csv", sep="")
        
        new_data <- last.row(read.csv(url))    
        
        current_price[position_to_sell[i]] <- new_data$close  
        
        j <- 1
        
        while(j * current_price[position_to_sell[i]] < 1000){
          
          j <- j + 1
          
        }
        
        quantity_to_sell <- quantity_we_bought[position_to_sell[i]] - j
        
        
        url <- paste(base, key_big_data_api, "&tiingo_key=", tiingo_token, "&request=sell&symbol=", vector_tickers[position_to_sell[i]], "&quantity=", quantity_to_sell, sep="") # this is will be url to buy the stocks
        
        
        receipt <- (utf8ToInt(read_json(url)$description)[1:5])
        
        if(vector.comparison(receipt, error) == TRUE){
          
          # We need to figure out how to handle errors
          
        }else{
          
          cat("StockBot is selling:", vector_tickers[position_to_sell[i]], "\n", "\n")
          
          profit <- quantity_to_sell*current_price[position_to_sell[i]]
          
          master_account[position_to_sell[i]] <- profit + reamining_account_money[position_to_sell[i]]
          
          bougth_tickers[positions_to_buy[i]] <- NA
          
          number_of_bs_transactions[position_to_sell[i]] <- number_of_bs_transactions[position_to_sell[i]] + 1
          
        }
        
        if(times_even <= number_of_even_positions){ # here we sell the even ones
          
          
          url <- paste(base_tiingo, vector_tickers[position_to_sell[second_position_to_sell]] ,"/prices?","token=", tiingo_token, "&startDate=", today_date, "&resampleFreq=1min", "&format=csv", sep="")
          
          new_data <- last.row(read.csv(url))    
          
          current_price[position_to_sell[second_position_to_sell]] <- new_data$close 
          
          j <- 1
          
          while(j * current_price[position_to_sell[second_position_to_sell]] < 1000){
            
            j <- j + 1
            
          }
          
          quantity_to_sell <- quantity_we_bought[position_to_sell[second_position_to_sell]] - j
          
          
          
          url <- paste(base, key_big_data_api, "&tiingo_key=", tiingo_token, "&request=sell&symbol=", vector_tickers[position_to_sell[second_position_to_sell]],"&quantity=", quantity_to_sell, sep="") # this is will be url to buy the stocks
          
          
          receipt <- (utf8ToInt(read_json(url)$description)[1:5])
          
          if(vector.comparison(receipt, error) == TRUE){
            
            # We need to figure out how to handle errors
            
          }else{
            
            cat("StockBot is selling:", vector_tickers[position_to_sell[second_position_to_sell]], "\n", "\n")
            
            profit <- quantity_to_sell*current_price[position_to_sell[second_position_to_sell]]
            
            master_account[position_to_sell[second_position_to_sell]] <- profit + reamining_account_money[position_to_sell[second_position_to_sell]]
            
            bougth_tickers <- bougth_tickers[-positions_to_buy[second_position_to_sell]]
            
            number_of_bs_transactions[position_to_sell[second_position_to_sell]] <- number_of_bs_transactions[position_to_sell[second_position_to_sell]] + 1
            
          }
          
          second_position_to_sell <- second_position_to_sell + 2
          
          times_even <- 1 + times_even 
          
        }
        
        Sys.sleep(60)
        
      }
      
      
      ## sell all stocks with less a thounsad 8 thousand dollars 1000 from each + 1000 from the original error
      
      ### hwo to calculate the thousand current_price * times_the_quantity_we_bought >= 1000 (for loop keep increasing quantity until reach 1000 store i)
      ##quatity we bought   - the quantity of stocks to reach a thousnad = wuantity_to_sell 
      
      
      sum_of_account <- sum(master_account)
      
    }
    
    
    
    
    
    ## after we sold the stocks
    
    ## sum of the master account will be done in the previous conditionals
    
    url <- paste("https://api.tiingo.com/iex/",ticker_bank,"/prices?token=",tiingo_token,"&startDate=", today_date, "&resampleFreq=1min&format=csv", sep = "" )
    
    
    buying_bank_ticker <- last.row(read.csv(url))
    
    
    price_of_bank <- buying_bank_ticker$close[1]
    
    
    quantity_to_buy_bank <- sum_of_account%/%price_of_bank
    
    
    url <- paste(base, key_big_data_api, "&tiingo_key=", tiingo_token, "&request=buy&symbol=", ticker_bank,"&quantity=", quantity_to_buy_bank, sep="") # this is will be url to buy the stocks
    
    
    receipt <- (utf8ToInt(read_json(url)$description)[1:5])
    
    
    if(vector.comparison(receipt, error) == TRUE){
      
      
      cat("StockBot was unable to buy the bank stock", "\n", "\n")
      
      # We need to figure out how to handle errors
      
    }else{
      
      charity <- sum_of_account - (quantity_to_buy * price_of_bank)
      
      cat("StockBot Identified a malfunction! Saving the money for the day...", "\n", "\n")
      
      cat("StockBot was able to buy the bank stock", "\n",
          "$", charity, "was given to the Big Data for All charity fund", ":)","\n", "\n")
      
      cat("Entering in safe mode!", "\n", "\n")
    }
    
    
    
    global_repeat <- 1
    
  }
  
  
  Sys.sleep(15)
  
}


## StockBot - Moving Average Traeder Version 2.0 - END OF THE SOURCE CODE
#################################################################





## Copyrigth 2021 - Enzo Novi Migliano, Andrea Gonzales, and Raul Ramon - StockBot Team, Inc.
