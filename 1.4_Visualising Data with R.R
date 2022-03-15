install.packages("ggplot2")
install.packages("leaflet")
library(ggplot2)
library(leaflet)
library(readxl)
library(tidyverse)
library(readr)
library(dplyr)
## using in built dataset mtcars ##
mtcars
## making simple bar charts using qplot() function ##
## adding color and border using fill and color option ##
qplot(mtcars$cyl,
      geom = "bar", 
      fill = I("blue"),
      color = I("red"))

## adding x and y axis info and title to plot
qplot(mtcars$cyl,
      geom = "bar", 
      fill = I("red"),
      color = I("black"),
      xlab = "Cylinders",
      ylab = "No. of Vehicles",
      main = "Cylinder in mtcars")

## making histogram to display horsepower in our dataset
qplot(mtcars$hp,
      geom = "histogram",
      binwidth = 25,
      color = I("black"),
      fill = I("blue"),
      xlim = c(50, 350),
      xlab = "Horsepower",
      ylab = "NO. of cars",
      main = "Histogram")
## using xlim function to define the limit of value on x axis ##
## using binwidth to define the length of bins on x-axis ##

qplot(mtcars$hp,
      geom = "histogram",
      binwidth = 25,
      color = I("black"),
      xlim = c(50, 350),
      xlab = "Horsepower",
      ylab = "NO. of cars",
      main = "Histogram",
      alpha = I(0))
## using alpha to completely remove the color ##    

## creating Pie Charts ##

##transforming bar charts into pie charts ##
##changing cyl values in data to factor of 2, 4 or 6 ##
mtcars <- mtcars %>% 
  mutate(cyl_factor = as.factor(cyl))
## plotting this chart using ggplot function ##
ggplot(data = mtcars,
       aes(x = cyl_factor,
           fill = cyl_factor)) +
  geom_bar(position = "dodge")

## alternately stacked bar charts ##
ggplot(data = mtcars,
       aes(x = " ",
           fill = cyl_factor)) +
  geom_bar(position = "stack")

## converting stacked bar charts into pie charts using coord_polar function ##

ggplot(data = mtcars,
       aes(x = " ",
           fill = cyl_factor)) +
  geom_bar(position = "stack") +
coord_polar(theta = "y") +
theme_minimal()

## changing color palette of the chart ##
ggplot(data = mtcars,
       aes(x = " ",
           fill = cyl_factor)) +
  geom_bar(position = "stack") +
  coord_polar(theta = "y") +
  scale_fill_brewer(palette = "Dark2")

## check ##
## creating scatter plots ##
qplot(mpg, wt, data = mtcars)
ggplot(mtcars,
       aes(x = mpg,
           y = wt)) + geom_point(shape = 1)

## filled circles ##
qplot(mpg, wt, data = mtcars)
ggplot(mtcars,
       aes(x = mpg,
           y = wt)) + geom_point(shape = 19)
## three variable ##
mtcars$cyl_factor <- factor(mtcars$cyl)
ggplot(mtcars,
       aes(x = mpg,
           y = wt,
           shape = cyl_factor)) +
  geom_point()

## changing color of the points ##
ggplot(mtcars,
       aes(x = mpg,
           y = wt)) + geom_point(shape = 19, color = "blue")
## changing color in 3 variables ##
ggplot(mtcars,
       aes(x = mpg,
           y = wt,
           color = cyl)) +
  geom_point(shape = 19)

## different colors as factor variables ##
ggplot(mtcars,
       aes(x = mpg,
           y = wt,
           color = cyl_factor)) +
  geom_point(shape = 19) 

## changing legend ##
ggplot(mtcars,
       aes(x = mpg,
           y = wt,
           color = cyl_factor)) +
  geom_point(shape = 19) + labs(color = "Cylinders") + xlab("Miles Per Gallon") +
  ylab("Weight") + ggtitle("Scatterplot")

## Line Charts using EUStockMarkets Data Set ##
View(EuStockMarkets)
## Converting into a data frame ##
EuStockDF <- as.data.frame(EuStockMarkets)
EuStockDF$Date <- as.numeric(time(EuStockMarkets))
head(EuStockDF)
## creating Line Plots usine geom_line function ##
ggplot(EuStockDF, aes(x = Date, y = SMI)) + 
  geom_line() + 
  labs(y = "Closing Price of Switzerland (SMI) stock index") +
  ggtitle("Line Chart of SMI from 1980")
## Making Stacked Line Charts for various Index ##
library(broom)
tidy_stocks <- tidy(EuStockMarkets) %>%
  rename(Date = index,
         Stock_index = series,
         Price = value)
head(tidy_stocks)
## here first four entries in tidy_stock is the first row in EuStockMarkets Data set ##

## creating multiple  line plots ##

ggplot(tidy_stocks, aes(x = Date, y = Price)) + 
  geom_line(aes(color = Stock_index)) + 
  ggtitle("EuStockMarkets 1980-1999")

## creating box plots ##
qplot(factor(cyl), mpg,
      data = mtcars,
      geom = "boxplot")
## creating box plots using ggplot ##
cars <- ggplot(mtcars,
               aes(factor(cyl),
                   mpg)) 
cars + geom_boxplot()

## customizing plots ##
## making more pleasing and informative charts ##
ggplot(mtcars, 
       aes(x = wt, 
           y = mpg)) + 
  geom_point(aes(color = factor(cyl))) +
  labs(
    x = "Weight (1000 lbs)",
    y = "Miles/(US) gallon",
    color = "Cylinders",
    title = "Mileage by Weight and Cylinders",
    subtitle = "Source: 1974 Motor Trend US Magazine")

## adding text to data points in plot ##
ggplot(mtcars, 
       aes(x = wt, 
           y = mpg)) + 
  geom_point(aes(color = factor(cyl))) +
  geom_text(aes(label = rownames(mtcars)))

## adjusting text in plot ##
ggplot(mtcars, 
       aes(x = wt, 
           y = mpg)) + 
  geom_point(aes(color = factor(cyl))) +
  geom_text(aes(label = rownames(mtcars)), 
            check_overlap = TRUE, hjust = "inward")

## Custom Annotations ##
ggplot(mtcars, 
       aes(x = mpg,)) +
  geom_histogram(bins = 10) +
  labs(x = "Miles/US gallon",
       y = "Count",
       title = "Distribution of Miles/gallon") +
  geom_vline(aes(xintercept = 19.2), color = "Red") +
  annotate(geom = "text",
           label = "Median = 19.2",
           x = 20,
           y = 6.8,
           hjust = 0,
           color = "red") +
  geom_hline(aes(yintercept = 7), color = "Blue") +
  annotate(geom = "text",
           label = "Maximum Count",
           x = 11.5,
           y = 6.8,
           hjudt = 0,
           color = "Blue")

