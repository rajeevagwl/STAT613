#' @author Rajeev Agrawal, Alexander Zakrzeski
#' @description STAT613 - Shiny app plots

library(readr)
library(tidyverse)
library(stringr)
library(plotly)
library(ggthemes)
library(zoo)

mcd = read_csv("./data/MarylandCovidData.csv", col_types = cols(date = col_date(format = "%m/%d/%y")))
vcd = read_csv("./data/VirginiaCovidData.csv", col_types = cols(date = col_date(format = "%m/%d/%y")))
dccd = read_csv("./data/DCCovidData.csv", col_types = cols(date = col_date(format = "%m/%d/%y")))

mvdccd <- rbind(mcd, vcd, dccd)

#Get only the Year-Month
mvdccd <- transform(mvdccd, Date = as.yearmon(date))

mvdccd <- mvdccd %>%
  select(date, Date, state, positive, positiveIncrease, death, deathIncrease,
         recovered, totalTestResults) %>%
  rename(totalcases = positive, newcases = positiveIncrease,
         totaldeaths = death, deathsperday = deathIncrease, 
         totaltests = totalTestResults) %>%
  replace(is.na(.), 0)

#Get total monthly cases and monthly deaths
mvdccd <- mvdccd %>%
  group_by(Date, state) %>%
  mutate(`Monthly cases` = sum(newcases),
         `Monthly deaths` = sum(deathsperday))

#Get plotly plots
p <- mvdccd %>%
  ggplot(aes(x = Date, y = `Monthly cases`)) +
  geom_path(aes(color = state)) +
  geom_point(aes(color = state)) +
  ggtitle("New monthly COVID-19 cases in DC, MD and VA") + 
  labs(x = "", y = "Monthly Covid-19 cases" ) +
  theme_igray() +
  theme(plot.title = element_text(hjust = 0.5))

fig <- ggplotly(p)
fig

p2 <- mvdccd %>%
  ggplot(aes(x = Date, y = `Monthly deaths`)) +
  geom_path(aes(color = state)) +
  geom_point(aes(color = state)) +
  ggtitle("New monthly COVID-19 deaths in DC, MD and VA") + 
  labs(x = "", y = "Monthly Covid-19 deaths" ) +
  theme_igray() +
  theme(plot.title = element_text(hjust = 0.5))

fig2 <- ggplotly(p2)
fig2

# Pie = STBG + coord_polar("y", start=0) 
# Pie

p3 <- mvdccd %>%
  ggplot(aes(x = date, y = totaldeaths)) +
  geom_line(aes(color = state)) +
  ggtitle("Cumulative Covid-19 deaths in DC, MD and VA") +
  labs(x = "Date", y = "Total deaths") +
  theme_igray() +
  theme(plot.title = element_text(hjust = 0.5))

fig3 <- ggplotly(p3)
fig3
