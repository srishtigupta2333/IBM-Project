library(tidyverse)
library(readr)
airline_data <- read_csv("lax_to_jfk.csv")
select(airline_data, c(Month, DayOfWeek, Reporting_Airline))
filter(airline_data, Reporting_Airline == "AA")
airline_data %>%
  select(Month, DayOfWeek, Reporting_Airline) %>%
  filter(Reporting_Airline == "AA")
glimpse(airline_data)
airline_data %>%
  group_by(Reporting_Airline) %>%
  summarise(avg_delay = mean(ArrDelay,na.rm = TRUE))
head(airline_data)
airline_data %>%
  add_row("Month" = 11, .before = 1)
airline_data$Month
#counting missing values in a data column
airline_data %>% 
  summarise(count = sum(is.na(CarrierDelay)))
#counting missing values in all columns
airline_data %>%
  map(~sum(is.na(.)))
#dropping specific rows of empty data
airline_data[-c(2,4,6), ]
airline_data[ ,-c(2,4,6)]
carrier_delays <- airline_data%>%
  drop_na(CarrierDelay)
carrier_delays
dim(carrier_delays)
dim(airline_data)
#replacing the missing values in 5 columns
relace_nas <- airline_data %>%
  replace_na(list(
    CarrierDelay = 0,
    WeatherDelay = 0,
    NASDelay = 0,
    SecurityDelay = 0,
    LateAircraftDelay = 0
  ))
#separate columns for day, month and year in Flight Date column
date_airline <- airline_data %>%
  separate(FlightDate, sep = "-",
           into = c("year", "month", "day"))
# data type of date_airline
date_airline %>%
  select(year, month, day) %>%
  mutate_all(type.convert) %>%
  mutate_if(is.character, as.numeric)
#checking the range of values in a column
range(airline_data$ArrDelay)
#normalising data by dividing the value by the maximum in that column
head(airline_data$ArrDelay)
simple_scale <- airline_data$ArrDelay / max(airline_data$ArrDelay)
head(simple_scale)
#using minmax scale
minmax_scale <- (airline_data$ArrDelay - min(airline_data$ArrDelay)) /
  (max(airline_data$ArrDelay) - min(airline_data$ArrDelay))
head(minmax_scale)
#using Z-scale
z_scale <- (airline_data$ArrDelay - mean(airline_data$ArrDelay)) / 
  sd(airline_data$ArrDelay)
head(z_scale)
#Binning - putting values of ArrDelay into four bins/ranges by using ntile
binning <- airline_data %>%
  mutate(quantile_rank = ntile(airline_data$ArrDelay, 4))
#converting a column into 8 columns based on the value with 1 for data and 0 for rest
reporting_columns <- airline_data %>%
  mutate(dummy = 1) %>% #column with single value
  spread(key = Reporting_Airline, #column to spread
         value = dummy, fill = 0) %>%
  slice(1:5)
reporting_arrdelay_columns <- airline_data %>% 
  spread(key = Reporting_Airline,
         value = ArrDelay)
summary_airline_delays <- airline_data %>%
  group_by(Reporting_Airline) %>%
  summarise(mean = mean(ArrDelayMinutes, na.rm = TRUE),
            std_dev = sd(ArrDelayMinutes, na.rm = TRUE))
summary_airline_delays
airline_data %>%
  count(Reporting_Airline)

#New commit
