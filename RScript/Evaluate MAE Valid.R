svm.rbf.mae.valid = function(model.list, train.data,valid.data) {
  
  n = nrow(valid.data)
  noOfModels = length(model.list)
  mae = rep(0,noOfModels)
  err.valid = rep(0,n)
  for(i in 1 :noOfModels){
    model = svm(model.list[[i]], data = train.data)
    predicted = predict(model, valid.data)
    
    for(j in 1 :n){
      err.valid[[j]] = abs(predicted[[j]] - valid.data$Adj_Close[[j]])
    }
    mae[[i]] = mean(err.valid)
  }
  mae
} 

svm.linear.mae.valid = function(model.list, train.data,valid.data) {
  
  n = nrow(valid.data)
  noOfModels = length(model.list)
  mae = rep(0,noOfModels)
  err.valid = rep(0,n)
  for(i in 1 :noOfModels){
    model = svm(model.list[[i]], data = train.data, kernel = "linear")
    predicted = predict(model, valid.data)
    
    for(j in 1 :n){
      err.valid[[j]] = abs(predicted[[j]] - valid.data$Adj_Close[[j]])
    }
    mae[[i]] = mean(err.valid)
  }
  mae
} 

linear.mae.valid = function(model.list, train.data,valid.data) {
  
  n = nrow(valid.data)
  noOfModels = length(model.list)
  mae = rep(0,noOfModels)
  err.valid = rep(0,n)
  for(i in 1 :noOfModels){
    model = lm(model.list[[i]], data = train.data)
    predicted = predict(model, valid.data)
    
    for(j in 1 :n){
      err.valid[[j]] = abs(predicted[[j]] - valid.data$Adj_Close[[j]])
    }
    mae[[i]] = mean(err.valid)
  }
  mae
} 

rpart.mae.valid = function(model.list, train.data,valid.data) {
  
  n = nrow(valid.data)
  noOfModels = length(model.list)
  mae = rep(0,noOfModels)
  err.valid = rep(0,n)
  for(i in 1 :noOfModels){
    model = rpart(model.list[[i]], data = train.data)
    predicted = predict(model, valid.data)
    
    for(j in 1 :n){
      err.valid[[j]] = abs(predicted[[j]] - valid.data$Adj_Close[[j]])
    }
    mae[[i]] = mean(err.valid)
  }
  mae
} 

