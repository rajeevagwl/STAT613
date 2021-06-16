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
                      "In late 2019, cases of severe respiratory illness caused by a new type of coronavirus were reported across Wuhan, the capital of Hubei Province in the People's Republic of China. The disease is now commonly referred to as COVID-19. By January 2020, the virus had escaped the borders of China and the number of COVID-19 cases began to rise around the world. The COVID-19 pandemic has dramatically affected everyone's life in some way across the entire world. This global pandemic has made social distancing and wearing face masks in public the new norm. ",
                      tags$br(),tags$br(),
                      "Rajeev and Alex are both graduate students at American University in Washington D.C. Over the last year, they diligently tracked various metrics from the COVID Tracking Project regarding COVID-19 in the Washington metropolitan area. They closely monitored both the number of new daily cases and deaths over the past fifteen months in anticipation that each of these metrics would decline as fast as possible. Doing this inspired them to make an interactive web app using the shiny package in R so we could better visualize the different metrics. They created interactive time series plots for both monthly Covid-19 cases and deaths in Washington D.C, Maryland and Virginia. In addition, a frequency plot for the cumulative number of Covid-19 cases in the three areas over the fifteen month span was also produced. The three interactive data visualizations found under the Plots tab in the shiny app help to better understand the data from the COVID Tracking Project. All of the interactive data visualizations have slider bars so individuals can view the specific time period that they desire when viewing the specific data visualizations. Finally, an interactive table of descriptive statistics was also created under the Data tab to allow for the viewers of the shiny app to become even more well-acquainted with the Covid-19 data.",
                      tags$br(),tags$br(),tags$h4("Code"),
                      "The code used to generate this Shiny application is available on ",tags$a(href="https://github.com/rajeevagwl/STAT613/tree/main/shinyApp", "Github."),
                      tags$br(),tags$br(),tags$h4("Source"),
                      tags$b("The COVID Tracking Project at "), tags$i("The Atlantic:"), tags$br(),tags$br(), tags$a(href="https://covidtracking.com/data/download", "	
Data Download | The COVID Tracking Project"),
                      tags$br(),tags$br(), tags$b("Notice:")," The COVID Tracking Project has ended all data collection as of March 7, 2021. The data files are still available, but will only include data up to March 7, 2021. These CSV files contain daily data on the COVID-19 pandemic for the US and individual states.",
                      tags$br(),
                      
                      tags$br(),tags$h4("Authors"),
                      "Rajeev Agrawal, MS Data Science, American University",tags$br(),
                      "Alexander Zakrzeski, MS Applied Economics, American University",tags$br(),tags$br(),
                      tags$img(src = "AU_logo.png", width = "75px", height = "75px"),tags$br(),tags$br()
                    )
                    )
        )