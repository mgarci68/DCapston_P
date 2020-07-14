
library(shiny)
library(DT)

shinyUI(fluidPage(
        tags$head(
                tags$style(HTML("
                                @import url('//fonts.googleapis.com/css?family=Catamaran|Cabin:400,700');"
                ))
                ),
        
        titlePanel(h1("Word Prediction", align = "center",
                      style = "font-family: 'Verdana', cursive;
                      font-weight: 500; line-height: 1.1; 
                      color: #ffffff; font-weight: bold")
        ),
        tags$header(src='image2.png', align = "right"),
        
        sidebarLayout(
                sidebarPanel(
                        h4("Your Word", align = "center", style="font-family:'calibri'"),
                        tags$style("body{background-color:#6d1c78; color:brown;  }"),
                        
                        tags$textarea(id = 'str1', placeholder = 'Type', rows = 5, class='form-control', 
                                      style="box"),
                        tags$head(src='img1.png', align = "center")
                        
                ),
                
                mainPanel(
                        
                        
                        div(DT::dataTableOutput("table1"), style = "font-size: 110%; width: 100%; background: rgba(193,76,193,1); 
                            color: black; border: 1px solid black; table-layout: fixed; width:500px; border-radius: 7px"  )
                        )
                ),
        ## Footer
        hr(),
        
        
        tags$span(style="color:White", 
                  
                  tags$footer(
                          tags$p("Welcome and Predict your Word", style="font-size: large"),
                          tags$p("You can predict the Next word and associated Probability"),
                          tags$p("For further info please go and check this link")  , 
                          tags$a(
                                  href="https://github.com/mgarci68/DCapston_P",
                                  target="_blank",
                                  "https://github.com/mgarci68/DCapston_P"),
                          tags$p( " \n  "),
                          tags$p("Thank you and have a nice day", style="font-size: large"),
                          align = "Center")
        )
        
        ))