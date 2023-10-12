library(readxl)
library(tidyr)
library(dplyr)
library(formattable)

table <- read_excel("Financial Sheet.xlsx", 1) %>% drop_na(Month) %>% 
  mutate_at(c("Month"), as.integer)
table


table %>% mutate_at("Month", as.integer) %>% mutate_at("Date", as.character) %>% 
  mutate_at("Income", ~replace(., is.na(.), values = "")) %>% 
formattable(., list (
  Income = formatter(.tag = "span", style = x ~ ifelse(
    !is.na(x),
    style(color = "green"), NA)),
  Debits = formatter(.tag = "span", style = x ~ ifelse(
    !is.na(x),
    style(color = "red"), NA)))
)
))
