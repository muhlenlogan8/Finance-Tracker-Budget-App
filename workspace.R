library(readxl)
library(tidyr)
library(dplyr)

table <- read_excel("Financial Sheet.xlsx", 1) %>% drop_na(Month) %>% 
  mutate_at(c("Month"), as.integer)
table
