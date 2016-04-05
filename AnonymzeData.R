library(dplyr)
library(tidyr)

setwd("/Users/cn/rcode/P3/")

trim <- function (x) gsub("^\\s+|\\s+$", "", x)

powerfactor_raw <- read.csv("data/backup/pf.csv")

voltage_raw <- read.csv("data/voltage_anon.csv")
substations <- read.csv("substations_list_anon.csv")

voltage_raw$substationName <- trim(voltage_raw$substationName)
voltage_raw$substationName <- toupper(voltage_raw$substationName)

substations$substationName <- toupper(substations$substationName)


powerfactor_new <- left_join(powerfactor_raw, substations, 
                                   by= c("station"))

powerfactor_new$substationName <- trim(powerfactor_new$substationName)
powerfactor_new$substationName <- toupper(powerfactor_new$substationName)

voltage_new <- left_join(voltage_raw, substations, 
                                   by= c("substationName"))

voltage_new[c("readdate","Voltage","prettyName","meter")]

powerfactor_new[c("ReadValue", "substationName", "name", "ReadDate")]

write.csv(powerfactor_new[c("ReadValue", "substationName", "name", "ReadDate")], 
          file = "pf_anon3.csv",row.names=FALSE)



write.csv(voltage_new[c("readdate","Voltage","prettyName","meter")], 
          file = "voltage_anon2.csv",row.names=FALSE)



