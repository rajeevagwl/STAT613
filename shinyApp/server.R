#
# This is the server logic of a Shiny web application.

library(shiny)
library(shinythemes)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    output$txtout <- renderText({
        paste(input$txt, input$slider, format(input$date), sep = ", ")
    })
    output$table <- renderTable({
        head(cars, 4)
    })
}
)

