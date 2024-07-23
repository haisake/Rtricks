#Purpose: Create a script to pivot fat tables to long tables.
#Author: Hans aisake
#Date Created: 2024-07-22

#required packages for data loading and manipulation
require(openxlsx)
require(dplyr)
require(tidyr)

#load in data
wd <- "//fraserhealth.org/dfs/GlobalApps/HBA/Service and Product Requests/DevOps85131-CSP 2.0/DevOps84629 - Model revamp/02 Working Files/LTC model/For Storyboard Deck"
setwd( wd)

f <- "RUG X YYYYQQ - OO and Affiliates modified.xlsx"
wb <- loadWorkbook( xlsxFile = f)
s <- sheets(wb)
y <- NULL


for(ii in 1:length(s)){
  x <- read.xlsx(xlsxFile = f, sheet = ii, detectDates = TRUE)
  x$lable <- s[ii]
  x <- x %>% pivot_longer(cols = colnames(x)[c(-1,-length(colnames(x)))], names_to = "var", values_to = "value")

  if (ii == 1 ){
    y <- x
  }else {
    y <- union(y,x)
  }
}

write.csv(x  =y, file = "reshaped_categories.csv")




