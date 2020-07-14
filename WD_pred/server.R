library(shiny)
library(DT)



load("df_ug.RData",envir=.GlobalEnv)
load("df_bg.RData",envir=.GlobalEnv)
load("df_tg.RData",envir=.GlobalEnv)
load("df_qg.RData", envir=.GlobalEnv)


source("WD_pred-R.R", local = TRUE)
source("CleaningDt.R", local = TRUE)

shinyServer(function(input, output){
        
        strs <- reactive({
                
                Wd_pred(input$str1)
                
                
        })
        output$table1 <- DT::renderDataTable(strs())
        
})