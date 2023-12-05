library(shiny)
library(tidyverse)

function(input, output, session){
        
        data <- read.csv("avocado.csv") %>% janitor::clean_names()
        
        df <- reactive({
                data %>%
                filter(type == input$type) %>%
                filter(region == input$region) %>%
                filter(between(as.Date(date), input$date[1], input$date[2]))
        })
        
        
        output$pricePlot <- renderPlot({
                df() %>%
                ggplot(aes(x = as.Date(date), y = average_price)) +
                geom_line(color = "#006d1d", size = 0.8) +
                theme_linedraw() +
                labs(x = "Date", y = "Average Price (USD)") +
                scale_y_continuous(labels = scales::dollar_format())
        })
        
        output$volPlot <- renderPlot({
                df() %>%
                ggplot(aes(x = as.Date(date), y = total_volume)) +
                geom_line(color = "#006d1d", size = 0.8) +
                theme_linedraw() +
                labs(x = "Date", y = "Total Volume (Avocados sold)") +
                scale_y_continuous(labels = scales::label_comma())
        })
}
