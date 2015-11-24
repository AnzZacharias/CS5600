#R function for evaluating the accuracy of SVM with RBF kernel

svm.rbf.accuracy = function(form, traindata,validdata) {
  
  model = svm(form, data = traindata)
  predicted = predict(model, newdata = validdata)
  p = length(predicted)
  differ = rep(0,p)
  good = 0
  bad = 0
  for(i in 1:p){
    differ[i] = ((abs(validdata$Adj_Close[i] - predicted[i]))/validdata$Adj_Close[i]) * 100
    if (differ[i] <= 1)
      good = good + 1
    else
      bad = bad + 1
  }
  (good/(good + bad)) * 100
} 

#R function for evaluating the accuracy of SVM with linear kernel

svm.linear.accuracy = function(form, traindata,validdata) {
  
  model = svm(form, data = traindata, kernel = "linear")
  predicted = predict(model, newdata = validdata)
  p = length(predicted)
  differ = rep(0,p)
  good = 0
  bad = 0
  for(i in 1:p){
    differ[i] = ((abs(validdata$Adj_Close[i] - predicted[i]))/validdata$Adj_Close[i]) * 100
    if (differ[i] <= 1)
      good = good + 1
    else
      bad = bad + 1
  }
  (good/(good + bad)) * 100
} 

#R function for evaluating the accuracy with linear regression

linear.regression.accuracy = function(form, traindata,validdata) {
  
  model = lm(form, data = traindata)
  predicted = predict(model, newdata = validdata)
  p = length(predicted)
  differ = rep(0,p)
  good = 0
  bad = 0
  for(i in 1:p){
    differ[i] = ((abs(validdata$Adj_Close[i] - predicted[i]))/validdata$Adj_Close[i]) * 100
    if (differ[i] <= 1)
      good = good + 1
    else
      bad = bad + 1
  }
  (good/(good + bad)) * 100
} 

#R function for evaluating the accuracy logistic model

logistic.accuracy= function(form, traindata,validdata) {
  
  model = glm(form, data = traindata, family = 'binomial')
  predicted = predict(model, newdata = validdata)
  p = length(predicted)
  differ = rep(0,p)
  good = 0
  bad = 0
  for(i in 1:p){
    differ[i] = ((abs(validdata$Adj_Close[i] - predicted[i]))/validdata$Adj_Close[i]) * 100
    if (differ[i] <= 1)
      good = good + 1
    else
      bad = bad + 1
  }
  (good/(good + bad)) * 100
} 

#R command to search  the best cost parameter in SVM with linear kernel in e1071 library 

tuned = tune.svm(Adj_Close ~ Adj_Close_1 + Adj_Close_2+Adj_Close_3+Adj_Close_4+Adj_Close_5+VolChg2.1+VolChg3.2+VolChg4.3+VolChg5.4+High_5+Low_5+High_1+Low_1+IndexChg2.1+IndexChg3.2+IndexChg4.3+IndexChg5.4+High_4+Low_4+High_3+Low_3+High_2+Low_2, data = train.data, cost = 2^(-2:2),kernel = "linear")#R function for evaluating the accuracy of SVM with RBF kernel

svm.rbf.accuracy = function(form, traindata,validdata) {
  
  model = svm(form, data = traindata)
  predicted = predict(model, newdata = validdata)
  p = length(predicted)
  differ = rep(0,p)
  good = 0
  bad = 0
  for(i in 1:p){
    differ[i] = ((abs(validdata$Adj_Close[i] - predicted[i]))/validdata$Adj_Close[i]) * 100
    if (differ[i] <= 1)
      good = good + 1
    else
      bad = bad + 1
  }
  (good/(good + bad)) * 100
} 

#R function for evaluating the accuracy of SVM with linear kernel

svm.linear.accuracy = function(form, traindata,validdata) {
  
  model = svm(form, data = traindata, kernel = "linear")
  predicted = predict(model, newdata = validdata)
  p = length(predicted)
  differ = rep(0,p)
  good = 0
  bad = 0
  for(i in 1:p){
    differ[i] = ((abs(validdata$Adj_Close[i] - predicted[i]))/validdata$Adj_Close[i]) * 100
    if (differ[i] <= 1)
      good = good + 1
    else
      bad = bad + 1
  }
  (good/(good + bad)) * 100
} 

#R function for evaluating the accuracy with linear regression

linear.regression.accuracy = function(form, traindata,validdata) {
  
  model = lm(form, data = traindata)
  predicted = predict(model, newdata = validdata)
  p = length(predicted)
  differ = rep(0,p)
  good = 0
  bad = 0
  for(i in 1:p){
    differ[i] = ((abs(validdata$Adj_Close[i] - predicted[i]))/validdata$Adj_Close[i]) * 100
    if (differ[i] <= 1)
      good = good + 1
    else
      bad = bad + 1
  }
  (good/(good + bad)) * 100
} 

#R function for evaluating the accuracy logistic model

logistic.accuracy= function(form, traindata,validdata) {
  
  model = glm(form, data = traindata, family = 'binomial')
  predicted = predict(model, newdata = validdata)
  p = length(predicted)
  differ = rep(0,p)
  good = 0
  bad = 0
  for(i in 1:p){
    differ[i] = ((abs(validdata$Adj_Close[i] - predicted[i]))/validdata$Adj_Close[i]) * 100
    if (differ[i] <= 1)
      good = good + 1
    else
      bad = bad + 1
  }
  (good/(good + bad)) * 100
} 

#R command to search  the best cost parameter in SVM with linear kernel in e1071 library 

tuned = tune.svm(Adj_Close ~ Adj_Close_1 + Adj_Close_2+Adj_Close_3+Adj_Close_4+Adj_Close_5+VolChg2.1+VolChg3.2+VolChg4.3+VolChg5.4+High_5+Low_5+High_1+Low_1+IndexChg2.1+IndexChg3.2+IndexChg4.3+IndexChg5.4+High_4+Low_4+High_3+Low_3+High_2+Low_2, data = train.data, cost = 2^(-2:2),kernel = "linear")
