#' @author Rajeev Agrawal
#' @description This is the server logic of the Shiny web application

library(shiny)
source("tidy.R")

# Define server logic
function(input, output, session) {
    
    level_selectInput <- reactive({
        switch(input$level_select,
               "DC, Maryland and Virginia" = "All",
               "Maryland" = "MD",
               "DC" = "DC",
               "Virginia" = "VA")
    })
    
    output$casesPlot <- renderPlotly({
        
        # Render a reactive plot
        if (level_selectInput() == "All") {
            mvdccd1 <- mvdccd
        } else {
            mvdccd1 <- mvdccd %>%
                filter(state == level_selectInput())
        }
        
        p <- mvdccd1 %>%
            filter(date <= input$range_date[2],
                   date >= input$range_date[1]) %>%
            ggplot(aes(x = Date, y = `Monthly cases`)) +
            geom_path(aes(color = state)) +
            geom_point(aes(color = state)) +
            ggtitle("New monthly COVID-19 cases") + 
            labs(x = "", y = "Monthly Covid-19 cases" ) +
            theme_igray() +
            theme(plot.title = element_text(hjust = 0.5))
        
        ggplotly(p)
    })
    
    output$deathsPlot <- renderPlotly({
        
        # Render a reactive plot
        if (level_selectInput() == "All") {
            mvdccd1 <- mvdccd
        } else {
            mvdccd1 <- mvdccd %>%
                filter(state == level_selectInput())
        }
        
        p2 <- mvdccd1 %>%
            filter(date <= input$range_date[2],
                   date >= input$range_date[1]) %>%
            ggplot(aes(x = Date, y = `Monthly deaths`)) +
            geom_path(aes(color = state)) +
            geom_point(aes(color = state)) +
            ggtitle("New monthly COVID-19 deaths") + 
            labs(x = "", y = "Monthly Covid-19 deaths" ) +
            theme_igray() +
            theme(plot.title = element_text(hjust = 0.5))
        
        ggplotly(p2)
    })
    
    output$deaths2Plot <- renderPlotly({
        
        # Render a reactive plot
        if (level_selectInput() == "All") {
            mvdccd1 <- mvdccd
        } else {
            mvdccd1 <- mvdccd %>%
                filter(state == level_selectInput())
        }
        
        p3 <- mvdccd1 %>%
            filter(date <= input$range_date[2],
                   date >= input$range_date[1]) %>%
            ggplot(aes(x = date, y = totaldeaths)) +
            geom_line(aes(color = state)) +
            ggtitle("Cumulative Covid-19 deaths") +
            labs(x = "Date", y = "Total deaths") +
            theme_igray() +
            theme(plot.title = element_text(hjust = 0.5))
        
        ggplotly(p3)
    })
    
    datasetInput <- reactive({
        switch(input$dataset,
               "Maryland" = mcd,
               "DC" = dccd,
               "Virginia" = vcd)
    })
    
    #Create caption
    output$caption <- renderText({
        input$caption
    })
    
    #Generate a summary of the dataset
    output$summary <- renderPrint({
        dataset <- datasetInput()
        dataset %>%
            select(date, death, deathIncrease, positive, positiveIncrease) %>%
            summary()
    })
    
    #Show the first "n" observations
    output$view <- renderTable({
        head(datasetInput(), n = input$obs)
    })
    
    #Download dataset
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


