# PLAN
# -- Install and load the necessary packages for this task
# TidyVerse & Janitor (data manipulations), Skimr (quick summarisation). 
#install.packages(c('tidyverse','janitor','skimr','readxl'))

library(tidyverse)
library(janitor)
library(skimr)
library(readxl)

#search()
# 1. Read in the Excel
ePCN <- read_excel("data/ePCN.xlsx", na = "")
#View(ePCN)

# 2. Explore the file
#head(ePCN, 20)
#names(ePCN)

print(paste('No. of rows:', nrow(ePCN)))
print(paste('No. of columns:', ncol(ePCN)))

#skim(ePCN)

# 3. Transform "something" in the file - remove rows with a close date
# Remove close date
# Change the dates to dates
#tabyl(ePCN$`Close Date`)

ePCN_open_only <- ePCN %>%
  filter(is.na(`Close Date`)) %>%
  mutate(`Open Date` = ymd(`Open Date`)) %>%
  select(`PCN Code`, `PCN Name`, `Open Date`)

print(paste('No. of rows after transformation:', nrow(ePCN_open_only)))
#View(ePCN_open_only)

# 4. Export the transform file.
write.csv(ePCN_open_only, "data/ePCN-update.csv", row.names = FALSE)

