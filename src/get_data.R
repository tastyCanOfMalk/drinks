# devtools::install_github("thebioengineer/tidytuesdayR")

library('tidytuesdayR')
library(tidyverse)

tuesdata <- tidytuesdayR::tt_load(2020, week = 22)

drinks        <- tuesdata$cocktails
boston_drinks <- tuesdata$boston_cocktails

write_csv(drinks, "data/drinks.csv")
write_csv(boston_drinks, "data/boston_drinks.csv")

rm(list = ls())