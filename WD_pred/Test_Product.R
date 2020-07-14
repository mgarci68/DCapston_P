library(DT)
## Code Testing


load("D:/Coursera/DataScience Spe/Capston Project/DCapston_P/df_ug.RData",envir=.GlobalEnv)
load("D:/Coursera/DataScience Spe/Capston Project/DCapston_P/df_bg.RData",envir=.GlobalEnv)
load("D:/Coursera/DataScience Spe/Capston Project/DCapston_P/df_tg.RData",envir=.GlobalEnv)
load("D:/Coursera/DataScience Spe/Capston Project/DCapston_P/df_qg.RData", envir=.GlobalEnv)

source("CleaningDt.R");

String_test <- "cant wait to"

jj <- Wd_pred(String_test)
datatable(jj)