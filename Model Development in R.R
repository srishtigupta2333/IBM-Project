## This is a R script on Model Development in R
library(tidyverse)
library(dplyr)
library(readr)
airline_data <- read_csv("Data/lax_to_jfk/lax_to_jfk.csv")
aa_delays <- airline_data %>%
  filter(CarrierDelay != "NA",
         Reporting_Airline == "AA")
linear_model <- lm(ArrDelayMinutes ~ DepDelayMinutes, data = aa_delays)
summary(linear_model)
# Creating a new never seen data to predict the values
new_depdelay <- data.frame(
  DepDelayMinutes = c(12, 19, 24))
pred <- predict(linear_model, newdata = new_depdelay, interval = "confidence")
pred

## checking
