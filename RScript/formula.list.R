formula.list = function(){
  formula.list = list()
  formula.list[[1]] = Adj_Close ~ Adj_Close_1 
  formula.list[[2]] = Adj_Close ~ Adj_Close_1 +Adj_Close_2
  formula.list[[3]] = Adj_Close ~ Adj_Close_1 + Adj_Close_2+Adj_Close_3
  formula.list[[4]] = Adj_Close ~ Adj_Close_1 + Adj_Close_2+Adj_Close_3+Adj_Close_4
  formula.list[[5]] = Adj_Close ~ Adj_Close_1 + Adj_Close_2+Adj_Close_3+Adj_Close_4+Adj_Close_5
  formula.list[[6]] = Adj_Close ~ Adj_Close_1 + Adj_Close_2+Adj_Close_3+Adj_Close_4+Adj_Close_5+High_5
  formula.list[[7]] = Adj_Close ~ Adj_Close_1 + Adj_Close_2+Adj_Close_3+Adj_Close_4+Adj_Close_5+High_5+Low_5
  formula.list[[8]] = Adj_Close ~ Adj_Close_1 + Adj_Close_2+Adj_Close_3+Adj_Close_4+Adj_Close_5+High_5+Low_5+High_1+Low_1
  formula.list[[9]] = Adj_Close ~ Adj_Close_1 + Adj_Close_2+Adj_Close_3+Adj_Close_4+Adj_Close_5+VolChg2.1+VolChg3.2+VolChg4.3+VolChg5.4+IndexChg5.1+High_5+Low_5+High_1+Low_1
  formula.list[[10]] = Adj_Close ~ Adj_Close_1 + Adj_Close_2+Adj_Close_3+Adj_Close_4+Adj_Close_5+VolChg2.1+VolChg3.2+VolChg4.3+VolChg5.4+IndexChg5.1+High_5+Low_5+High_1+Low_1+Stock
  formula.list[[11]] = Adj_Close ~ Adj_Close_1 + Adj_Close_2+Adj_Close_3+Adj_Close_4+Adj_Close_5 +Volume_5+Volume_4+Volume_3+Volume_2+Volume_1
  formula.list[[12]] = Adj_Close ~ Adj_Close_1 + Adj_Close_2+Adj_Close_3+Adj_Close_4+Adj_Close_5+VolChg2.1+VolChg3.2+VolChg4.3+VolChg5.4+High_5+Low_5+High_1+Low_1+IndexChg2.1+IndexChg3.2+IndexChg4.3+IndexChg5.4+High_4+Low_4+High_3+Low_3+High_2+Low_2
  formula.list[[13]] = Adj_Close ~ Adj_Close_1 + Adj_Close_2+Adj_Close_3+Adj_Close_4+Adj_Close_5+VolChg2.1+VolChg3.2+VolChg4.3+VolChg5.4+High_5+Low_5+High_1+Low_1+IndexChg2.1+IndexChg3.2+IndexChg4.3+IndexChg5.4+High_4+Low_4+High_3+Low_3+High_2+Low_2+Stock
  formula.list[[14]] = Adj_Close ~ Adj_Close_1 + Adj_Close_2+Adj_Close_3+Adj_Close_4+Adj_Close_5 +DJI_Close_1+DJI_Close_2+DJI_Close_3+DJI_Close_4+DJI_Close_5+Volume_5+Volume_4+Volume_3+Volume_2+Volume_1
  formula.list
}
