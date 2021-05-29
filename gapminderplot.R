#' @description STAT613: HW2 - Q1 gapminderplot
#' @author Rajeev Agrawal, Alexander Zakrzeski
#'

library(tidyverse)
source("stat613_HW2_Q1.R")

gapminder1 %>%
  ggplot(aes(x = country, y = lifeExp, fill = country)) +
  geom_bar(stat = "identity") +
  coord_flip()
  