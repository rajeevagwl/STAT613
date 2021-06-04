#' @author Rajeev Agrawal
#' @description This is the user-interface definition of the Shiny web application. 

library(shiny)
library(plotly)

navbarPage(theme = "custom.css",
           title=HTML("<span><img style='margin-top:-15px; margin-left:-10px;' src='logo.png', height='50',width='200' /><b style='color:lightgray; font-size:20px; margin-right:10px'>Covid-19 in DC, Maryland and Virginia</b></span>"),
           tabPanel("Plots",
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
                             tabPanel("Scatter Plot",
                                      plotlyOutput("scatterPlot")
                             ),
                             tabPanel("Time Series Plot",
                                      h4("Table"),
                                      tableOutput("table"),
                                      
                                      h1("Header 1"),
                                      h2("Header 2"),
                                      h3("Header 3"),
                                      h4("Header 4"),
                                      h5("Header 5")
                                      ),
                             tabPanel("Bar Chart", "This panel is intentionally left blank")
                         )
                     )
            ),
            tabPanel("DC", "This panel is intentionally left blank"),
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
                             value = 16)
                
              ),
              mainPanel(
                
                # Output: Formatted text for caption
                h3(textOutput("caption", container = span)),
                
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
                      "Code and input data used to generate this Shiny mapping tool are available on ",tags$a(href="https://github.com/rajeevagwl/STAT613/tree/main/shinyApp", "Github."),
                      tags$br(),tags$br(),tags$h4("Sources"),
                      tags$b("2019-COVID cases: "), tags$a(href="https://github.com/CSSEGISandData/COVID-19/tree/master/csse_covid_19_data/csse_covid_19_time_series", "Johns Hopkins Center for Systems Science and Engineering github page,")," with additional information from the ",tags$a(href="https://www.who.int/emergencies/diseases/novel-coronavirus-2019/situation-reports", "WHO's COVID-19 situation reports."),
                      " In previous versions of this site (up to 17th March 2020), updates were based solely on the WHO's situation reports.",tags$br(),
                      tags$b("US state-level case data: "), tags$a(href="https://github.com/nytimes/covid-19-data", "New York Times github page,"),
                      tags$b("2003-SARS cases: "), tags$a(href="https://www.who.int/csr/sars/country/en/", "WHO situation reports"),tags$br(),
                      tags$b("2009-H1N1 confirmed deaths: "), tags$a(href="https://www.who.int/csr/disease/swineflu/updates/en/", "WHO situation reports"),tags$br(),
                      tags$b("2009-H1N1 projected deaths: "), "Model estimates from ", tags$a(href="https://journals.plos.org/plosmedicine/article?id=10.1371/journal.pmed.1001558", "GLaMOR Project"),tags$br(),
                      tags$b("2009-H1N1 cases: "), tags$a(href="https://www.cdc.gov/flu/pandemic-resources/2009-h1n1-pandemic.html", "CDC"),tags$br(),
                      tags$b("2009-H1N1 case fatality rate: "), "a systematic review by ", tags$a(href="https://www.ncbi.nlm.nih.gov/pubmed/24045719", "Wong et al (2009)"), "identified 
                        substantial variation in case fatality rate estimates for the H1N1 pandemic. However, most were in the range of 10 to 100 per 100,000 symptomatic cases (0.01 to 0.1%).
                        The upper limit of this range is used for illustrative purposes in the Outbreak comarisons tab.",tags$br(),
                      tags$br(),tags$h4("Authors"),
                      "Rajeev Agrawal, MS Data Science, American University",tags$br(),
                      "Alexander Zakrzeski, MS Applied Economics, American University",tags$br(),tags$br(),
                      tags$img(src = "AU_logo.png", width = "75px", height = "75px"),tags$br(),tags$br()
                    )
                    )
           
        )