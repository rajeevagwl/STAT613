#' @author Rajeev Agrawal
#' @description This is the server logic of the Shiny web application

library(shiny)
library(plotly)

source("plots.R")

# Define server logic required to draw a histogram
function(input, output, session) {
    
    # output$txtout <- renderText({
    #     paste(input$txt, input$slider, format(input$date), sep = ", ")
    # })
    
    output$casesPlot <- renderPlotly({
        # Render a plot...non-reactive
        fig
    })
    
    output$deathsPlot <- renderPlotly({
        # Render a plot...non-reactive
        fig2
    })
    
    output$deaths2Plot <- renderPlotly({
        # Render a plot...non-reactive
        fig3
    })
    
    datasetInput <- reactive({
        switch(input$dataset,
               "Maryland" = mcd,
               "DC" = dccd,
               "Virginia" = vcd)
    })
    
    output$caption <- renderText({
        input$caption
    })
    
    output$view <- renderTable({
        head(datasetInput(), n = input$obs)
    })
    
    # output to download data
    output$downloadCsv <- downloadHandler(
        filename = function() {
            paste("COVID_data_", input$dataset, ".csv", sep="")
        },
        content = function(file) {
            if (input$dataset == "Maryland") {
                write.csv(mcd, file) 
            } else if (input$dataset == "DC") {
                write.csv(dccd, file)
            } else {
                write.csv(vcd, file)
            }
        }
    )
    
    
}


