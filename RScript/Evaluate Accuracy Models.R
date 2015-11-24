#R function for the evaluating accuracy of SVM RBF models with a set of formulas passed

svm.rbf.accuracy.models = function(formlist, traindata,validdata ) {
  
  n = length(formlist)
  model.accuracy = rep(0,n)
  
  for(i in 1:n){
    model.accuracy[i] = svm.rbf.accuracy(formlist[[i]],traindata,validdata)
  }
  model.accuracy
}
 
#R function for the evaluating accuracy of SVM linear models with a set of formulas passed

svm.linear.accuracy.models = function(formlist, traindata,validdata ) {
  
  n = length(formlist)
  model.accuracy = rep(0,n)
  
  for(i in 1:n){
    model.accuracy[i] = svm.linear.accuracy(formlist[[i]],traindata,validdata)
  }
  model.accuracy
} 

#R function for the evaluating accuracy of linear models with a set of formulas passed

linear.regression.accuracy.models = function(formlist, traindata,validdata ) {
  
  n = length(formlist)
  model.accuracy = rep(0,n)
  
  for(i in 1:n){
    model.accuracy[i] = linear.regression.accuracy(formlist[[i]],traindata,validdata)
  }
  model.accuracy
} 

#R function for the evaluating accuracy of logistic models with a set of formulas passed

logistic.accuracy.models = function(formlist, traindata,validdata ) {
  
  n = length(formlist)
  model.accuracy = rep(0,n)
  
  for(i in 1:n){
    model.accuracy[i] = logistic.accuracy(formlist[[i]],traindata,validdata)
  }
  model.accuracy
} 
