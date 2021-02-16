library(readxl)
library(tidyr)
library(dplyr)
library(xts)

familystarts_raw <- readr::read_csv("~/mojchart/data-raw/familystarts.csv")

familystarts <- familystarts_raw %>%
  mutate(across(where(is.character), ~na_if(., '-'))) %>%
  fill(Year) %>%
  filter(Year >= 2011) %>%
  filter(!is.na(Quarter)) %>%
  mutate(across(!Quarter, as.numeric)) %>%
  unite("year_qtr", Year:Quarter) %>%
  pivot_longer(cols = `Children Act - public law`:`Total cases started`, names_to = "case_type", values_to = "count") %>%
  mutate(year_qtr = as.yearqtr(year_qtr, format = "%Y_Q%q")) %>%
  mutate(case_type = as.factor(case_type))

usethis::use_data(familystarts, overwrite = TRUE)
