# SARS-ANI: A Global Open Access Dataset of Reported SARS-CoV-2 Events in Animals
# Script to perform technical validation


######################## Prepare the R environment: install tools (packages) ########################

install.packages("dplyr")
install.packages("stringr")
library(dplyr)
library(stringr)


########################### Set working directory to source file location ###########################

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))


############################ Codes for Quality Control & Data Cleaning ##############################

# Import the dataset
sars_df <- read.csv("sars_ani_data.csv", encoding="UTF-8") 


# Look at the first lines of the dataset
head (sars_df)

# Print column names
colnames(sars_df)

# Check that the data in each column uses consistent coding and check potential typos
unique(sars_df$primary_source)
unique(sars_df$secondary_source)
unique(sars_df$species)
unique(sars_df$latin_name)
unique(sars_df$family)
unique(sars_df$epidemiological_unit)
unique(sars_df$sex)
unique(sars_df$country_name)
unique(sars_df$country_iso3)
unique(sars_df$subnational_administration)
unique(sars_df$city)
unique(sars_df$location_detail)
unique(sars_df$date_confirmed)
unique(sars_df$date_reported)
unique(sars_df$date_published)
unique(sars_df$test)
unique(sars_df$test_2)
unique(sars_df$test_3)
unique(sars_df$sampling_type)
unique(sars_df$sampling_type_2)
unique(sars_df$sampling_type_3)
unique(sars_df$negative_test)
unique(sars_df$negative_sampling_type)
unique(sars_df$reason_for_testing)
unique(sars_df$symptoms)
unique(sars_df$outcome)
unique(sars_df$living_conditions)
unique(sars_df$source_of_infection)
unique(sars_df$variant)
unique(sars_df$control_measures)
unique(sars_df$related_to_other_entries)
unique(sars_df$number_cases)
unique(sars_df$number_susceptible)
unique(sars_df$number_tested)
unique(sars_df$age)

# Create a column "Date" where Date = confirmed when confirmed is given and Date = reported if date confirmed is missing and Date = published if the two others are missing
# Remove trailing and leading whitespace
sars_df <- sars_df %>%
  mutate (Date = if_else(
    date_confirmed %in% c( "NS", NA,""), date_reported , date_confirmed)) %>%
  mutate (Date = if_else(
    Date %in% c( "NS", NA,""), date_published, Date)) %>%
  mutate(across(where(is.character), str_trim)) 

# check that we have a date for each event
length(which(sars_df$Date == "NS"))
length(which(is.na(sars_df$Date)))
# the results should be zero --> all records have a date assigned with the rule confirmed > reported > published


# Identification of duplicate events (i.e., unique event reported multiple time).
# Reports are flagged as duplicate when the geolocation information (i.e., country, subnational administration, city, specific location), species (common and Latin names), sex, symptoms, date of report or confirmation  (summarized as "Date_1"), number of cases, number of deaths, number of susceptible, tests conducted, outcome, and relationship to another event ("related_ID") were identical. 
duplicate <- sars_df %>%
  mutate (Date = if_else(
    date_confirmed %in% c( "NS", NA,""), date_reported , date_confirmed)) %>%
  mutate (Date = if_else(
    Date %in% c( "NS", NA,""), date_published, Date))  %>% 
  mutate(across(where(is.character), str_trim)) %>% 
  group_by(country_name, subnational_administration, city, location_detail, latin_name, species, sex, age, symptoms, number_cases, number_deaths, number_susceptible, test, test_2, test_3, outcome, Date, related_ID) %>% 
  tally() %>%
  filter(n>1)

duplicate

# Print the table to investigate duplicates
write.csv(duplicate, file="duplicate.csv", row.names = F)


