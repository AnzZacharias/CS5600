'''
Created on Nov 22, 2015
This program takes input from yahoo finance and Qunadl database and create a csvfile which contains previous week's features of 10 stocks as input. 
And generate an email with trading suggestions based on the machine learning model predictions.
PypeR Python interface is used to integrate with R.
@author: Anz Mary Zacharias
'''
from pyper import R
from yahoo_finance import Share
import csv
import smtplib
from bs4 import BeautifulSoup
import requests
import warnings
warnings.filterwarnings("ignore")
from datetime import timedelta
from math import log, fabs
import Quandl
from datetime import date
import operator

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
    

#Get the latest Dow Jones Index from yahoo finance website, if not available in Quandl database
def get_latest_dji():
    myurl = "http://finance.yahoo.com/q/cp?s=^DJI"
    html = requests.get(myurl).content
    soup = BeautifulSoup(html,"html.parser")
    dji_string = soup.find('span', attrs={'class':'time_rtq_ticker'}).text
    return dji_string.replace(',','')

#Get previous five day's stock price and volume from yahoo finance; stock index is read from Quandl
def readLast5DaysStockPrice():
    with open('stock_features.csv', 'w') as csvfile:
        fieldnames = ['Stock', 'Adj_Close_1','High_1', 'Low_1'
                      ,'Adj_Close_2','High_2', 'Low_2','VolChg2_1','IndexChg2_1'
                      ,'Adj_Close_3','High_3', 'Low_3','VolChg3_2','IndexChg3_2'
                      ,'Adj_Close_4','High_4', 'Low_4','VolChg4_3','IndexChg4_3'
                      ,'Adj_Close_5','High_5', 'Low_5','VolChg5_4','IndexChg5_4']
        writer = csv.DictWriter(csvfile, lineterminator='\n', fieldnames=fieldnames)
        writer.writeheader()
    
        dow_code = 'BCB/UDJIAD1'
        dji_index = []
        j = 0
        while (j < 10):
            ticker = Share(stock_dict.get(j))
            i = 0
            stock_price = []
            current_date = date.today()
            fmt = '%Y-%m-%d'
            while( i < 5):
                if (ticker.get_historical(current_date.strftime(fmt), current_date.strftime(fmt)) == []):
                    current_date = current_date - timedelta(days=1)
                else:
                    stock_price += ticker.get_historical(current_date.strftime(fmt), current_date.strftime(fmt))
                    if(j == 0):
                        if(i == 0 and Quandl.get(dow_code, trim_start=current_date, trim_end=current_date, authtoken="T246AaoCUiwSyz1C4Vfe").values.tolist() == []):
                            dji_index.append(get_latest_dji())
                        else:
                            dji_index.append(Quandl.get(dow_code, trim_start=current_date, trim_end=current_date, authtoken="T246AaoCUiwSyz1C4Vfe").values.tolist()[0][0])
                                
                    current_date = current_date - timedelta(days=1)
                    i = i + 1    
            AbVolChg2_1 = int(stock_price[1].get('Volume')) - int(stock_price[0].get('Volume'))  
            VolChg2_1 = log(AbVolChg2_1,2)  if AbVolChg2_1 > 0 else -1*log(fabs(AbVolChg2_1),2)
            AbVolChg3_2 = int(stock_price[2].get('Volume')) - int(stock_price[1].get('Volume'))  
            VolChg3_2 = log(AbVolChg3_2,2)  if AbVolChg3_2 > 0 else -1*log(fabs(AbVolChg3_2),2)                        
            AbVolChg4_3 = int(stock_price[3].get('Volume')) - int(stock_price[2].get('Volume'))  
            VolChg4_3 = log(AbVolChg4_3,2)  if AbVolChg4_3 > 0 else -1*log(fabs(AbVolChg4_3),2)                        
            AbVolChg5_4 = int(stock_price[4].get('Volume')) - int(stock_price[3].get('Volume'))  
            VolChg5_4 = log(AbVolChg5_4,2)  if AbVolChg5_4 > 0 else -1*log(fabs(AbVolChg5_4),2)        
            writer.writerow({'Stock': stock_dict.get(j)
                         ,'Adj_Close_1' : stock_price[0].get('Adj_Close'),'High_1' : stock_price[0].get('High'),'Low_1' : stock_price[0].get('Low') 
                         ,'Adj_Close_2' : stock_price[1].get('Adj_Close'),'High_2' : stock_price[1].get('High'),'Low_2' : stock_price[1].get('Low')
                         ,'VolChg2_1': VolChg2_1,'IndexChg2_1': (float(dji_index[1]) - float(dji_index[0])) 
                         ,'Adj_Close_3' : stock_price[2].get('Adj_Close'),'High_3' : stock_price[2].get('High'),'Low_3' : stock_price[2].get('Low')
                         ,'VolChg3_2': VolChg3_2,'IndexChg3_2': (dji_index[2] - dji_index[1]) 
                         ,'Adj_Close_4' : stock_price[3].get('Adj_Close'),'High_4' : stock_price[3].get('High'),'Low_4' : stock_price[3].get('Low')
                         ,'VolChg4_3': VolChg4_3,'IndexChg4_3': (dji_index[3] - dji_index[2]) 
                         ,'Adj_Close_5' : stock_price[4].get('Adj_Close'),'High_5' : stock_price[4].get('High'),'Low_5' : stock_price[4].get('Low')
                         ,'VolChg5_4': VolChg5_4,'IndexChg5_4': (dji_index[4] - dji_index[3]) 
                         }) 
    
            j = j+1
#Stock feature file is passed to the model and the email with the predicted price is sent
def runModel():    
    with open('stock_features.csv') as csvfile:
        reader = csv.DictReader(csvfile)
        stock_current_day = dict()
        for row in reader:
            stock_current_day[row['Stock']] = row['Adj_Close_1']

    r = R()
    r('library(e1071)')
#     r('model <- readRDS(\'svmlinear_model.rds\')')
    r('model <- readRDS(\'linear_model.rds\')')
    r('days5_data = read.csv(\"stock_features.csv\",header = T)')
    r('predict_stockprice = predict(model,newdata = days5_data)')
    predicted_price = r.predict_stockprice
    
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
    password = 'XXXXXXXXXX'
    server = smtplib.SMTP('smtp.gmail.com:587')
    server.ehlo()
    server.starttls()
    server.login(username,password)
    server.sendmail(fromaddr, toaddrs, msg)
    server.quit()
    print("Stock recommendations sent by email.")

def main():
    readLast5DaysStockPrice()
    runModel()
        
if __name__ == "__main__": main()


    

