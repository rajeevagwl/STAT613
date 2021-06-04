#
# This is the user-interface definition of a Shiny web application. 

library(shiny)

navbarPage(theme = "custom.css",
           title=HTML("<span><img style='margin-top:-15px; margin-left:-10px;' src='logo.png', height='50',width='200' /><b style='color:lightgray; font-size:20px; margin-right:10px'>Covid-19 in DC, Maryland and Virginia</b></span>"),
           tabPanel("Maryland",
                    sidebarPanel(
                         fileInput("file", "File input:"),
                         textInput("txt", "Text input:", "general"),
                         sliderInput("slider", "Slider input:", 1, 100, 30),
                         tags$h5("Default actionButton:"),
                         actionButton("action", "Search"),
                         
                         tags$h5("actionButton with CSS class:"),
                         actionButton("action2", "Action button", class = "btn-primary")
                     ),
                     mainPanel(
                         tabsetPanel(
                             tabPanel("Tab 1",
                                      h4("Scatter plot"),
                                      plotlyOutput("scatterPlot")
                             ),
                             tabPanel("Tab 2",
                                      h4("Table"),
                                      tableOutput("table"),
                                      
                                      h1("Header 1"),
                                      h2("Header 2"),
                                      h3("Header 3"),
                                      h4("Header 4"),
                                      h5("Header 5")
                                      ),
                             tabPanel("Tab 3", "This panel is intentionally left blank")
                         )
                     )
            ),
            tabPanel("DC", "This panel is intentionally left blank"),
            tabPanel("Virginia", "This panel is intentionally left blank")
        )