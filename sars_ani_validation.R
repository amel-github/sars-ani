# SARS-ANI: A Global Open Access Dataset of Reported SARS-CoV-2 Events in Animals
# Script to perform technical validation


######################## Prepare the R environment: install tools (packages) ########################

install.packages("dplyr")
install.packages("stringr")
install.packages ("taxize")
install.packages("rentrez")
install.packages("plyr")
library(dplyr)
library(stringr)
library (taxize) 
library (rentrez)
library (plyr) 

########################### Set working directory to source file location ###########################

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))


############################ Codes for Quality Control & Data Cleaning ##############################

# Import the dataset
sars_df <- read.csv("sars_ani_data.csv", encoding="UTF-8") 


##########  GENERAL DATA CHECK ########## 

# Look at the first lines of the dataset
head (sars_df)

# Print column names
colnames(sars_df)

# Check that the data in each column uses consistent coding and check potential typos
unique(sars_df$primary_source)
unique(sars_df$secondary_source)
unique(sars_df$host_com_orig)
unique(sars_df$host_sci_orig)
unique(sars_df$host_com_res)
unique(sars_df$host_sci_res)
unique(sars_df$host_colloq)
unique(sars_df$host_sci_spec_res)
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


##########  CHECK DATES  ########## 

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



##########  TAXONOMIC VALIDATION ########## 

# Set the API key for the NCBI for a single R session 
## See how getting NCBI API key value: https://ncbiinsights.ncbi.nlm.nih.gov/2017/11/02/new-api-keys-for-the-e-utilities/
## See how using API key: https://cran.r-project.org/web/packages/rentrez/vignettes/rentrez_tutorial.html
set_entrez_key("XXXXXX") # enter your own API key
# Confirm it is available
Sys.getenv("ENTREZ_KEY")


# Resolve taxonomic names - scientific names (check misspelling)
# Using the Global Names Resolver (GNR) service provided by the Encyclopedia of Life http://resolver.globalnames.org/.
# The prefered data source is set to the National Center for Biotechnology Information (NCBI) https://www.ncbi.nlm.nih.gov/  
### First remove "NS" from the list of Latin names
list_sci <- unique(sars_df$host_sci_orig)[!unique(sars_df$host_sci_orig) %in% "NS"] # remove the "NS" from the list
gnr_res_sci <- gnr_resolve (sci  = list_sci, preferred_data_sources = "4") 
#View(gnr_res_sci)

# Extract taxonomic names which scores >= 0.98
resolved_sci <- gnr_res_sci %>%
  filter (score >= 0.98)
# View(resolved_sci)


# Identify unique combination of host names (as extracted from the source and as resolved against the NCBI backbone)
unique_combi <- sars_df %>%
  distinct(host_com_orig, host_sci_orig, host_com_res, host_sci_res) 


# Left join gnr_resolved scientific names
# Retrieve scientific names from English names (use host_com_orig to retrieve host_sci_res)
# Using the National Center for Biotechnology Information (NCBI) https://www.ncbi.nlm.nih.gov/  
host_res_1 <- unique_combi  %>% 
  left_join(resolved_sci, by = c("host_sci_orig" = "submitted_name")) %>% # add list of scientific names checked for misspelling using gnr_resolve
  select (!c(user_supplied_name, data_source_title, score)) %>% # removed unused column
  mutate (validate_sci_from_com_orig = comm2sci(com = host_com_orig, db = "ncbi") ) # retrieve scientific names from the common names provided in the source
# choose Neogale vison for "mink"
# choose western gorilla for gorilla

#View(host_res_1)

# Identify NCBI-resolved scientific names based on information provided in the source (common and scientific name)
host_res_2 <- host_res_1 %>%
  mutate(ncbi_sci_res = ifelse(validate_sci_from_com_orig == "character(0)", matched_name, validate_sci_from_com_orig))
#View(host_res_2)


# Retrieve English common names from scientific names (use host_sci_orig to retrieve host_com_res)
# Using the National Center for Biotechnology Information (NCBI) https://www.ncbi.nlm.nih.gov/
host_res_3 <- host_res_2 %>%
  mutate (ncbi_com_res = sci2comm(sci = ncbi_sci_res, db = "ncbi") )
#View(host_res_3)


# Validate host_sci_res with ncbi_sci_res (compare and find differences)
# Validate host_com_res with validate_com_from_sci_res
# Create Boolean vectors to check difference
host_res_4 <- host_res_3 %>%
  mutate (sars_ani_sci_valid = ifelse(ncbi_sci_res == host_sci_res, TRUE, FALSE))%>%
  mutate (sars_ani_com_valid = ifelse(ncbi_com_res == host_com_res, TRUE, FALSE))%>%
# Identify names to check manually
  filter (sars_ani_sci_valid == FALSE | sars_ani_com_valid == FALSE)
View(host_res_4)

# When common and scientific names are not resolved at this point, we will resolve them manually in the NCBI Taxonomy checker (https://www.ncbi.nlm.nih.gov/taxonomy/).


# Retrieve higher taxonomic names (family)
# Using the National Center for Biotechnology Information (NCBI) https://www.ncbi.nlm.nih.gov/  
ncbi_res_vec <- unname(unlist(host_res_3$ncbi_sci_res)) # get the vector of resolved scientific names
ncbi_res_vec <- ncbi_res_vec[!is.na(ncbi_res_vec)]  # remove NA
families_res <- tax_name( sci =  ncbi_res_vec, get = "family", db = "ncbi") 
families_res 

# Retrieve from ITIS the taxonomic serial numbers (TSN) of a taxon for which we have a doubt 
## Example of the dog
mynames <- c( "Canis familiaris", "Canis lupus familiaris", "Canis lupus")
tsn <- get_tsn (mynames)                               
ldply (tsn, itis_acceptname) 




##########  SEARCH FOR DUPLICATE EVENTS  ########## 

# Identification of duplicate events (i.e., unique event reported multiple time).
# Reports are flagged as duplicate when the geolocation information (i.e., country, subnational administration, city, specific location), species (common and Latin names), sex, symptoms, date of report or confirmation  (summarized as "Date_1"), number of cases, number of deaths, number of susceptible, tests conducted, outcome, and relationship to another event ("related_ID") were identical. 
duplicate <- sars_df %>%
  mutate (Date = if_else(
    date_confirmed %in% c( "NS", NA,""), date_reported , date_confirmed)) %>%
  mutate (Date = if_else(
    Date %in% c( "NS", NA,""), date_published, Date))  %>% 
  mutate(across(where(is.character), str_trim)) %>% 
  group_by(country_name, subnational_administration, city, location_detail, host_sci_res, host_com_res, sex, age, symptoms, number_cases, number_deaths, number_susceptible, test, test_2, test_3, outcome, Date, related_ID) %>% 
  tally() %>%
  filter(n>1)

duplicate

# Print the table to investigate duplicates
write.csv(duplicate, file="duplicate.csv", row.names = F)


