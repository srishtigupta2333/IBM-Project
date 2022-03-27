#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(gridExtra)


# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$p1 <- renderPlot({ # Histogram Plot 
      })
    output$p2 <- renderPlot ({ #Box Plot goes here
      })
    output$p3 <- renderPlot ({ #Scatter plot goes here
    })
    output$p4 <- renderPlot ({ #Pie Chart  goes here
    })
    })
