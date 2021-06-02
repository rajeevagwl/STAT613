library(readr)
library(dplyr)

# Load in the csv file using the readr package

mcd = read_csv(".data/MarylandCovidData.csv")
vcd = read_csv(".data/VirginiaCovidData.csv")
dccd = read_csv(".data/DCsCovidData.csv")

# Merge the data sets vertically using the rbind function

mvdccd = rbind(mcd, vcd, dccd)

# Use the dplyr package to clean and wrangle data
# Just the Maryland data set

mcd1 = mcd%>%
  select(date, state, positive, positiveIncrease, death, deathIncrease,
         recovered, totalTestResults)%>%
  rename(totalcases = positive, newcases = positiveIncrease,
         totaldeaths = death, deathsperday = deathIncrease, 
         totaltests = totalTestResults)%>%
  replace(is.na(.), 0)%>%
  mutate(recovered = if_else(recovered < 26, 0, recovered))
