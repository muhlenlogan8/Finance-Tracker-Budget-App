library(readxl)
library(tidyr)
library(dplyr)
library(formattable)

table <- read_excel("Financial Sheet.xlsx", 1) %>% drop_na(Month) %>%
  mutate_at("Month", as.integer) %>% mutate_at("Date", as.character) %>%
  mutate_at("Day", as.integer) %>% mutate_all(~replace(., is.na(.), values = ""))
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

currentbal <- table %>% mutate_at("Balance", as.double) %>% 
  select(., "Balance") %>% last()
incometodate <- table %>% mutate_at("Income", as.double) %>% 
  filter(., Category == "Income") %>% select(., "Income") %>% sum()
debitstodate <- table %>% mutate_at("Debits", as.double) %>% 
  filter(., Category != "Income") %>% select(., "Debits") %>% sum()
testtbl <- table %>% mutate_at("Debits", as.double) %>% 
  filter(., Category != "Income") %>% select(., "Debits")


table %>%
  mutate_at("Month", as.integer) %>% mutate_at("Date", as.character) %>%
  mutate_all(~replace(., is.na(.), values = "")) %>% mutate_at("Income", as.double) %>% 
  filter(., Category == "Income") %>% select(., "Income") %>% sum()

table %>%
  mutate_at("Month", as.integer) %>% mutate_at("Date", as.character) %>%
  mutate_all(~replace(., is.na(.), values = "")) %>% mutate_at("Debits", as.double) %>% 
  filter(., Category != "Income") %>% select(., "Debits") %>% sum()

library(ggplot2)
library(hrbrthemes)

plottable <- table %>% select("Date") %>% mutate_all(as.Date(format("%Y-%m-%d")))
ggplot(plottable, aes(1, 32)) +
  geom_line( color="#69b3a2", linewidth = 2, alpha = 1, linetype = 1) +
  ggtitle("Evolution of something")
  
library(googlesheets4)

read_sheet("https://docs.google.com/spreadsheets/d/1d8Ykj8NrxsxwRY5lWv1P372a9v1hbrAf/edit#gid=2139507055")

library(readxl)

data <- read_excel("Financial Sheet - Template.xlsx", 1) %>% slice(1:100)

library(writexl)

write_xlsx(data, "Financial Sheet - Templatetest.xlsx")
