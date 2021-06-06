#' @author Rajeev Agrawal, Alexander Zakrzeski
#' @description STAT613 Shiny app - Tidy data

library(tidyverse)
library(zoo)
library(ggthemes)
library(plotly)

mcd = read_csv("./data/MarylandCovidData.csv", col_types = cols(date = col_date(format = "%m/%d/%y")))
vcd = read_csv("./data/VirginiaCovidData.csv", col_types = cols(date = col_date(format = "%m/%d/%y")))
dccd = read_csv("./data/DCCovidData.csv", col_types = cols(date = col_date(format = "%m/%d/%y")))

mvdccd <- rbind(mcd, vcd, dccd)

#Get only the Year-Month
mvdccd <- transform(mvdccd, Date = as.yearmon(date))

#Get the range of dates
mvdccd$date %>% 
  range() ->
  date_range

#Get total monthly cases and monthly deaths
mvdccd <- mvdccd %>%
  select(date, Date, state, positive, positiveIncrease, death, deathIncrease,
         recovered, totalTestResults) %>%
  rename(totalcases = positive, newcases = positiveIncrease,
         totaldeaths = death, deathsperday = deathIncrease, 
         totaltests = totalTestResults) %>%
  replace(is.na(.), 0) %>%
  group_by(Date, state) %>%
  mutate(`Monthly cases` = sum(newcases),
         `Monthly deaths` = sum(deathsperday))

