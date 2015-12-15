'''
Created on Nov 22, 2015

This program takes a csvfile which contains previous week's features of 10 stocks as input. 
And generate an email with trading suggestions based on the machine learning model predictions.
PypeR Python interface is used to integrate with R.

Version 2 - Modified email format on Dec 14,2015
@author: Anz Mary Zacharias
'''
from pyper import R
import csv
import smtplib
import operator

def main():

#Read input csv file    
    with open('Dec4.data.csv') as csvfile:
        reader = csv.DictReader(csvfile)
        stock_current_day = dict()
        for row in reader:
            stock_current_day[row['Stock']] = row['Adj_Close_1']
            
#Predict the next day price based on the model chosen
    r = R()
    r('library(e1071)')
#   Call SVM  model 
    r('model <- readRDS(\'svmlinear_model.rds\')')
#   Call linear regression model    
#    r('model <- readRDS(\'linear_model.rds\')')
    r('days5_data = read.csv(\"Dec4.data.csv\",header = T)')
    r('predict_stockprice = predict(model,newdata = days5_data)')
    predicted_price = r.predict_stockprice
    
#Define dictinary of stocks in the portfolio.    
    stock_dict = {
                0: 'XOM'
                ,1 : 'CVX'
                ,2 : 'SLB'
                ,3 : 'APC'
                ,4 : 'EOG'
                ,5 : 'OXY'
                ,6 : 'COP'
                ,7 : 'VLO'
                ,8 : 'PXD'
                ,9 : 'TSO'
            }
    email_body = ""
    percent_change = {}
    i = 0
    while (i < 10):
        current_price = stock_current_day.get(stock_dict.get(i))  
        change_expected = (float(predicted_price[i])-float(current_price))*100/float(current_price)
        percent_change.update({stock_dict.get(i): change_expected})
#Email content in 'Buy' or 'Sell' format        
#         if (change_expected) >= 2:
#             trade_rec = 'Buy'
#         elif (change_expected) <= -2:
#             trade_rec = 'Sell'
#         else:
#             trade_rec = 'Keep'

#         stock_rec = "Stock:" + stock_dict.get(i) + " Trade_Recommendation: " + trade_rec + '\n'
#         email_body += stock_rec
        i += 1
#Processing email content in the form of predicted percentage change   
    j = 0         
    sorted_percent_change = sorted(percent_change.items(), key=operator.itemgetter(1),reverse=True)  
    while(j < 10):
        stock_rec = "Stock:" + sorted_percent_change[j][0] + " Predicted percentage change: " + str(sorted_percent_change[j][1]) + '\n'
        email_body += stock_rec
        j += 1
        
#Send email to the destination   Use the email address for source and destination      
    fromaddr = 'usums.cs5600@gmail.com'
    toaddrs  = ['usums2015.cs5600@gmail.com']
    msg = "\r\n".join([
      "From: usums.cs5600@gmail.com",
      "To: usums2015.cs5600@gmail.com",
      "Subject: Oil Stocks Trade Recommendations",
      "",
      email_body
      ])
    username = 'usums.cs5600@gmail.com'
    password = 'XXXXXXXX'
    server = smtplib.SMTP('smtp.gmail.com:587')
    server.ehlo()
    server.starttls()
    server.login(username,password)
    server.sendmail(fromaddr, toaddrs, msg)
    server.quit()
    print("Stock recommendations sent by email.")
if __name__ == "__main__": main()


    

