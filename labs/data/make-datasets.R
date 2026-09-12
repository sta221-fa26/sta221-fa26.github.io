# scripts to prepare data sets for assignments

# avocado data set for Lab 02
library(tidyverse)
library(avocado)

# simplify region variable
hass_market <- hass_market |>
  mutate(
    region_simplified = case_when(
      region %in% c("California", "West") ~ "West",
      region %in% c("Plains", "Great Lakes") ~ "Midwest",
      region %in% c("South Central", "Southeast", "Midsouth") ~ "South",
      region == "Northeast" ~ "Northeast",
      TRUE ~ NA_character_
    )
  ) |>
#make units in thousands
  mutate(total_units_th = total_bulk_and_bags_units / 1000)

# rename variables 
avocado <- hass_market |>
  rename(region_original = region, 
         ) |>
  rename(region = region_simplified) |>
  select(region, market, week_ending, type, avg_selling_price, total_units_th)

# save data set
avocado |> 
  write_csv("labs/data/avocado.csv")




m <- lm(total_bulk_and_bags_units ~ region_simplified + type + avg_selling_price, data = hass_market)

tidy(m) |> View()

