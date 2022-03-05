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
mlr <- lm(ArrDelayMinutes ~ CarrierDelay + LateAircraftDelay, 
          data = aa_delays)
summary(mlr)
CarrierDelay <- c(10, 20, 30)
LateAircraftDelay <- c(20, 60, 30)
new_multidelay <- data.frame(CarrierDelay, LateAircraftDelay)
pred <- predict(mlr, newdata = new_multidelay, interval = "confidence")
pred
library(ggplot2)
ggplot(aa_delays, aes(x= DepDelayMinutes, y = ArrDelayMinutes)) + geom_point() +
  stat_smooth(method = "lm", col = "red")
linear_model <- lm(ArrDelayMinutes ~ DepDelayMinutes,
                   data = aa_delays)
plot(linear_model)
