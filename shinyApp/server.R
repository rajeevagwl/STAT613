#' @author Rajeev Agrawal
#' @description This is the server logic of the Shiny web application

library(shiny)

source("plots.R")

# Define server logic required to draw a histogram
function(input, output, session) {
    
    output$txtout <- renderText({
        paste(input$txt, input$slider, format(input$date), sep = ", ")
    })
    
    output$table <- renderTable({
        head(cars, 4)
    })
    
    output$scatterPlot <- renderPlotly({
        # Render a scatter plot...non-reactive
        fig_scatter
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
}


