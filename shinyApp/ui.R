#' @author Rajeev Agrawal, Alexander Zakrzeski
#' @description This is the user-interface definition of the Shiny web application. 

library(shiny)
source("tidy.R")

navbarPage(theme = "custom.css",
           title=HTML("<span><img style='margin-top:-15px; margin-left:-10px;' src='logo.png', height='50',width='200' /><b style='color:lightgray; font-size:20px; margin-right:10px'>Covid-19 in DC, Maryland and Virginia</b></span>"),
           tabPanel("Plots",
                    sidebarPanel(
                      span(tags$i(h5("Reported Covid-19 cases and deaths attributed to Covid-19 are subject to significant variation in policy and capacity between states.")), style="color:#045a8d"),tags$br(),
                      
                      selectInput(inputId = "level_select",
                                  label = "State(s):",   
                                  choices = c("DC, Maryland and Virginia", "DC", "Maryland", "Virginia"), 
                                  selected = c("DC, Maryland and Virginia"),
                                  multiple = FALSE),
                      tags$br(),
                      
                      sliderInput(inputId = "range_date",
                                  label = "Date range:",
                                  min = date_range[1],
                                  max = date_range[2],
                                  value=c(date_range[1], date_range[2]),
                                  timeFormat="%Y-%m-%d"
                                  ),
                      
                         tags$br(),
                      
                      "Select regions, plotting start date and plotting end date to update plots."
                      
                     ),
                     mainPanel(
                         tabsetPanel(
                             tabPanel("Covid-19 cases",
                                      plotlyOutput("casesPlot")
                             ),
                             tabPanel("Covid-19 deaths",
                                      plotlyOutput("deathsPlot")
                                      ),
                             tabPanel("Cumulative Covid-19 deaths", 
                                      plotlyOutput("deaths2Plot")
                                      )
                         )
                     )
            ),
            tabPanel("Data",
              # Sidebar panel for inputs ----
              sidebarPanel(
                
                # Input: Text for providing a caption ----
                textInput(inputId = "caption",
                          label = "Caption:",
                          value = "Data Summary"),
                
                # Input: Selector for choosing dataset ----
                selectInput(inputId = "dataset",
                            label = "Choose a dataset:",
                            choices = c("Maryland", "DC", "Virginia")),
                
                # Input: Numeric entry for number of obs
                numericInput(inputId = "obs",
                             label = "Number of observations to view:",
                             value = 10)
                
              ),
              mainPanel(
                
                # Output: Formatted text for caption
                h3(textOutput("caption", container = span)),
                # Output: Verbatim text for data summary
                verbatimTextOutput("summary", placeholder = TRUE),
                tags$style("#summary{ 
overflow-y:scroll; max-height: 200px}"),
                
                # Output: HTML table with requested number of observations
                tableOutput("view"),
                downloadButton("downloadCsv", "Download as CSV"),tags$br(),tags$br()
                
              )
                     ),
           tabPanel("About this app",
                    tags$div(
                      tags$br(),tags$h4("Background"), 
                      "In December 2019, cases of severe respiratory illness began to be reported across the city of Wuhan in China. 
                        These were caused by a new type of coronavirus, and the disease is now commonly referred to as COVID-19.
                        The number of COVID-19 cases started to escalate more quickly in mid-January and the virus soon spread beyond China's borders. 
                        This story has been rapidly evolving ever since, and each day we are faced by worrying headlines regarding the current state of the outbreak.",
                      tags$br(),tags$br(),
                      "In isolation, these headlines can be hard to interpret. 
                        How fast is the virus spreading? Are efforts to control the disease working? How does the situation compare with previous epidemics?
                        This site is updated daily based on data published by Johns Hopkins University. 
                        By looking beyond the headlines, we hope it is possible to get a deeper understanding of this unfolding pandemic.",
                      tags$br(),tags$br(),tags$h4("Code"),
                      "The code used to generate this Shiny application is available on ",tags$a(href="https://github.com/rajeevagwl/STAT613/tree/main/shinyApp", "Github."),
                      tags$br(),tags$br(),tags$h4("Source"),
                      tags$b("The COVID Tracking Project at "), tags$i("The Atlantic:"), tags$br(),tags$br(), tags$a(href="https://covidtracking.com/data/download", "	
Data Download | The COVID Tracking Project"),
                      tags$br(),tags$br(), tags$b("Notice:")," The COVID Tracking Project has ended all data collection as of March 7, 2021. The data files are still available, but will only include data up to March 7, 2021. These CSV files contain daily data on the COVID-19 pandemic for the US and individual states.",
                      tags$br(),
                      tags$br(),
                      
                      tags$br(),tags$h4("Authors"),
                      "Rajeev Agrawal, MS Data Science, American University",tags$br(),
                      "Alexander Zakrzeski, MS Applied Economics, American University",tags$br(),tags$br(),
                      tags$img(src = "AU_logo.png", width = "75px", height = "75px"),tags$br(),tags$br()
                    )
                    )
        )