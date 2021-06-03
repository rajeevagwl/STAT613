library(readr)
library(dplyr)
library(stringr)
library(ggplot2)

mcd = read_csv("Maryland Covid Data.csv")
vcd = read_csv("Virginia Covid Data.csv")
dccd = read_csv("DC Covid Data.csv")

mvdccd = rbind(mcd, vcd, dccd)

mcd1 = mcd%>%
  select(date, state, positive, positiveIncrease, death, deathIncrease,
         recovered, totalTestResults)%>%
  rename(totalcases = positive, newcases = positiveIncrease,
         totaldeaths = death, deathsperday = deathIncrease, 
         totaltests = totalTestResults)%>%
  replace(is.na(.), 0)%>%
  mutate(recovered = if_else(recovered < 26, 0, recovered))

str_left_right = function(string, m, n) {
  left = substr(string, 1, m)
  right = substr(string, nchar(string) - (n - 1), nchar(string))
  both = paste(left, right)
}

mcd1$date = str_left_right(mcd1$date, 2, 3)
mcd1$date = str_replace_all(mcd1$date , " /", "")
mcd1$date = str_replace_all(mcd1$date , "1020", "10/20")
mcd1$date = str_replace_all(mcd1$date , "1120", "11/20")
mcd1$date = str_replace_all(mcd1$date , "1220", "12/20")

mcd1$date  = as.factor(mcd1$date)

mcd2 = mcd1%>%
  group_by(date)%>%
  summarise(mnmcases = sum(newcases))%>%
  arrange(factor(date, levels = date
                 [c(6, 8, 9, 10, 11, 12, 13, 2, 3, 4, 1, 5, 6)], 
                  desc(mnmcases)))


mcd2$Count = 1:13
ggplot(data = mcd2, mapping = aes(x = Count, y = mnmcases)) +
  geom_path(color = "black") +
  geom_point(color = "blue") +
  ggtitle("Monthly Covid-19 Cases") +
  theme(plot.title = element_text(hjust = 0.5)) + 
  labs(x = "Months", y = "Monthly Covid-19 Cases" ) +
  scale_x_continuous(breaks = c(1,4,7,10,13), labels = c(" Mar. 2020",
                                                         "Jun. 2020", 
                                                         "Sep. 2020", 
                                                         "Dec. 2020", 
                                                         "Mar. 2021"))

mcd3 = mcd1%>%
  group_by(date)%>%
  summarise(deathspermonth = sum(deathsperday))%>%
  arrange(factor(date, levels = date
                 [c(6, 8, 9, 10, 11, 12, 13, 2, 3, 4, 1, 5, 6)], 
                 desc(deathspermonth)))

STBG = ggplot(data = mcd3, aes(x = "", y = deathspermonth, fill = date))+
  geom_bar(width = 0.5, stat = "identity") +
  labs(x = "Months", y = "Monthly Covid-19 Deaths" ) 
STBG

Pie = STBG + coord_polar("y", start=0) 
Pie

ggplot(data = mcd1, mapping = aes(x = newcases, y = deathsperday)) +
  geom_point(color = "black") +
  ggtitle("Covid-19 Scatter Plot") +
  theme(plot.title = element_text(hjust = 0.5)) +
  labs(x = "Deaths Per Day", y = "New Cases Per Day") +
  geom_smooth(method = lm, se = FALSE) 
