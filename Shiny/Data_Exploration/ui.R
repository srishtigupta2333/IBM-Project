#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)

# Get categorical variables list in the data set
categorical_variables <- c("cyl", "vs", "am", "gear", "carb")


# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel(title = div(img(src = "shiny.png", height = 50, width = 100), 
                           "Data Exploration With Shiny")),
    
    ## Sidebar layout

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
          h3("Explore mtcars"),
          # Input 1
          varSelectInput("continuous_variable", "Select Continuous Variable",
                        data = select(mtcars, -categorical_variables), selected = "cyl"),
          #Input 2
          varSelectInput("categorical_variable", "Select Categorical Variable",
                         data = mtcars[categorical_variables], selected = "cyl"),
          #Input 3
          sliderInput("bins", "Histogram: Number of Bins", min = 2, max = 30, 
                      value = 10),
          #Add Plot Guide
          h4("Plot Variable Map Guide"),
          p("Miles per Gallon = mpg", br(),
            "Displacement (cu in,) = disp", br(),
            "Gross Horsepower = hp")),
        mainPanel(
          tabsetPanel(
            tabPanel("Plots for Observing Data Trend",
                     plotOutput("p1"),
                     plotOutput("p2")),
            tabPanel("Plots for Observing Data Correlation",
                     plotOutput("p3")),
            tabPanel("Plots for Observing Inner Subivision Value",
                     plotOutput("p4"))
            ))
        )))


