library(shiny)
library(DT)



load("D:/Coursera/DataScience Spe/Capston Project/DCapston_P/df_ug.RData",envir=.GlobalEnv)
load("D:/Coursera/DataScience Spe/Capston Project/DCapston_P/df_bg.RData",envir=.GlobalEnv)
load("D:/Coursera/DataScience Spe/Capston Project/DCapston_P/df_tg.RData",envir=.GlobalEnv)
load("D:/Coursera/DataScience Spe/Capston Project/DCapston_P/df_qg.RData", envir=.GlobalEnv)

source("CleaningDT.R")
source("WD_pred-R.R")

shinyServer(function(input, output){
        
        strs <- reactive({
                
                Wd_pred(input$str1)
                
                
        })
        output$table1 <- DT::renderDataTable(strs())
        
})