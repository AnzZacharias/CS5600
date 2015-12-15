Two Python programs are there in this directory. 
StockNextDayTradingAssistant takes cdv files as input. Example: Dec1.data.csv
StockNextDayTradingAssistant_dailyjob is supposed to run daily. It takes the input from yahoo finance and Quandl database and create stock_features.csv file. Both programs are integrated with R, and the output is sent to the destination email address provided.

R and PypeR need to be installed for running StockNextDayTradingAssistant.
R, PypeR,Yahoo finance, Beautiful Soup, Pandas, numpy and Quandl need to be installed for StockNextDayTradingAssistant_dailyjob.