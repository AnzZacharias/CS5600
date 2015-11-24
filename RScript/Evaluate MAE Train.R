#R function for the evaluating mean absolute error of training data with SVM RBF.

svm.rbf.mae.train = function(model.list, data) {
  
  n = nrow(data)
  noOfModels = length(model.list)
  mae = rep(0,noOfModels)
  err.train = rep(0,n)
  for(i in 1 :noOfModels){
    model = svm(model.list[[i]], data = data)
    predicted = predict(model, data)
    for(j in 1 :n){
      err.train[[j]] = abs(predicted[[j]] -data$Adj_Close[[j]])
    }
    mae[[i]] = mean(err.train)
  }
   mae
} 

#R function for the evaluating mean absolute error of training data with SVM linear.

svm.linear.mae.train = function(model.list, data) {
  
  n = nrow(data)
  noOfModels = length(model.list)
  mae = rep(0,noOfModels)
  err.train = rep(0,n)
  for(i in 1 :noOfModels){
    model = svm(model.list[[i]], data = data, kernel = "linear")
    predicted = predict(model, data)
    for(j in 1 :n){
      err.train[[j]] = abs(predicted[[j]] -data$Adj_Close[[j]])
    }
    mae[[i]] = mean(err.train)
  }
   mae
}
#R function for the evaluating mean absolute error of training data with linear regression.

linear.mae.train = function(model.list, data) {
  
  n = nrow(data)
  noOfModels = length(model.list)
  mae = rep(0,noOfModels)
  err.train = rep(0,n)
  for(i in 1 :noOfModels){
    model = lm(model.list[[i]], data = data)
    predicted = predict(model, data)
    for(j in 1 :n){
      err.train[[j]] = abs(predicted[[j]] -data$Adj_Close[[j]])
    }
    mae[[i]] = mean(err.train)
  }
   mae
}



