library(DT)
## Code Testing


load("df_ug.RData",envir=.GlobalEnv)
load("df_bg.RData",envir=.GlobalEnv)
load("df_tg.RData",envir=.GlobalEnv)
load("df_qg.RData", envir=.GlobalEnv)

source("CleaningDt.R");

String_test <- "cant wait to"

jj <- Wd_pred(String_test)
datatable(jj)