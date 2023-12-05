library(shiny)
library(shinyWidgets)
library(shinythemes)
library(bslib)
library(shinydashboard)


fluidPage(
    theme = shinytheme("lumen"),
    HTML('<style>
       .box {
       border: 2px solid lightgrey;
       border-radius: 10px;
       box-shadow: 0px 0px 6px 1px lightgrey;
       padding: 5px;
       }
       </style>'),    
    titlePanel("California Avocado Data Dashboard (2015-2018)"),
    sidebarLayout(
        sidebarPanel(
            fluidRow(box("This app serves as a dashboard to view California avocado price and volume data across three years,
                        with the ability to filter among attributes such as avocado type, region, and date range. Simply 
                        click which avocado type you would like to view (organic vs conventional), choose your region of
                        California of interest, and select the time frame that you would like to view. This dataset spans 
                        from January 4th, 2015 to March 25th, 2018, with each data point/observation taken 7 days apart
                        from one another.",
                        width = 12)),
            br(),
            fluidRow(box(HTML("<p>The <a href='https://www.kaggle.com/datasets/neuromusic/avocado-prices'>dataset used</a> 
                                is sourced from Kaggle user Justin Kiggins, which is originally sourced from the
                                <a href='https://hassavocadoboard.com/'>Hass Avocado Board</a>.</p>"),
                         width = 12)),
            br(),
            radioButtons("type", "Select avocado type:",
                         choices = c("Organic" = "organic",
                                     "Conventional" = "conventional")),
            radioButtons("region", "Select which region to view:",
                         choices = c("Entire State" = "California", 
                                     "Los Angeles" = "LosAngeles", 
                                     "San Francisco" = "SanFrancisco", 
                                     "San Diego" = "SanDiego", 
                                     "Sacramento" = "Sacramento")),
            setSliderColor("#006d1d", 1),
            sliderInput("date", "Select date range to view:",
                        min = as.Date("2015-01-04", format = "%Y-%m-%d"),
                        max = as.Date("2018-03-25", format = "%Y-%m-%d"),
                        value = c(as.Date("2015-01-04", format = "%Y-%m-%d"),
                                  as.Date("2018-03-25", format = "%Y-%m-%d")),
                        step = 7)
        ),
        mainPanel(
                h3("Average Price Chart", align = "center"),
                box(
                        plotOutput("pricePlot"),
                        width = 12
                ),
                h3("Total Volume Chart", align = "center"),
                box(
                        plotOutput("volPlot"),
                        width = 12
                )
        )
    )
)

