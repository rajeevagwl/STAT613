#' @description STAT613: HW2 - Q1
#' @author Rajeev Agrawal, Alexander Zakrzeski
#' 

library(tidyverse)
library(gapminder)

data("gapminder")  #Load gapminder table

gapminder1 <- gapminder %>%
  filter(continent == "Americas",
         year == 1997) %>%
  mutate(logpop = log(pop)) %>%
  arrange(desc(lifeExp))

gapminder1
