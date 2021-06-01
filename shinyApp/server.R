#
# This is the server logic of a Shiny web application.

library(shiny)
library(shinythemes)

# Define server logic required to draw a histogram
function(input, output, session) {
    
    output$txtout <- renderText({
        paste(input$txt, input$slider, format(input$date), sep = ", ")
    })
    output$table <- renderTable({
        head(cars, 4)
    })
}


