####################################################
# Script: data_cleaning.r
# Author: Nathalie Murillo-Barahona
# Date: 2023/21/07
#---------------------------------------------------
# Change History:
####################################################

# Import Statements 
library(tidyverse)


# Read in data
raw_usda <- read_csv(file = "./Data/Farm_Mrkt_data.csv")
raw_cdc <- read_csv(file = "./Data/NPAO_Data.csv")
state_pop <- readxl::read_xlsx("./Data/PopulationReport.xlsx")

# Columns to remove from USDA data 
usda_drop <- c("FMID", "Website", "Facebook", "MarketName", "Twitter", "Youtube",
               "OtherMedia", "street", "city", "County", "zip", "Season1Date", "Season1Time",
               "Season2Date", "Season2Time", "Season3Date", "Season3Time", "Season4Date", 
               "Season4Time", "x", "y", "Location", "updateTime")

# Columns that need to be encoded as 0,1
columns_to_encode <- raw_usda[, c(24:58)] %>% colnames()


cln_tran_usda <- raw_usda %>% 
  # drop columns
  select(-usda_drop) %>% 
  # encode columns
  mutate(across(columns_to_encode, 
               function(x) ifelse(x == "Y", 1, 0)
               )
         ) %>%
  # removed row with NA values
  drop_na() %>% 
  # combined each states info into one row per state
  group_by(State) %>% 
  summarise(count_fmart = n(),
            # summing across state to get total count for indicator columns 
            across(columns_to_encode, 
                   function(x) sum(x), 
                   .names = "{.col}_count"),
            # calculating percent across state for indicator columns 
            across(columns_to_encode,
                   function(x) (sum(x)/count_fmart) * 100,
                   .names = "{.col}_percent")
  )
cdc_cols_drop <- c("YearStart"                  
                  ,"YearEnd"                   
                  ,"LocationAbbr"              
                  ,"Datasource"                 
                  ,"Class"                     
                  ,"Topic"                      
                  ,"Question"
                  ,"Data_Value_Unit" 
                  ,"Data_Value_Type"                 
                  ,"Data_Value_Alt"
                  ,"Data_Value_Footnote_Symbol" 
                  ,"Data_Value_Footnote"
                  ,"Total"                     
                  ,"Age(years)"                 
                  ,"Education"                  
                  ,"Gender"                    
                  ,"Income"
                  ,"Race/Ethnicity"
                  ,"GeoLocation"
                  ,"ClassID"
                  ,"TopicID"
                  ,"QuestionID"
                  ,"DataValueTypeID"            
                  ,"LocationID"
                  ,"StratificationCategory1"
                  ,"StratificationCategoryId1"  
                  ,"StratificationID1")

# Just pulling information on obesity column
cln_tran_cdc <- raw_cdc %>% 
  # Selected only question 37 
  filter(QuestionID == "Q037",
         StratificationCategory1 == "Income",
         YearStart == 2020,
         YearEnd == 2020,
         !LocationAbbr %in% c("GU", "PR", "DC", "US"),
         Stratification1 != "Data not reported"
         ) %>%
  # Dropped unwanted columns
  select(-cdc_cols_drop)



# Cleaning State Population data
cln_state_pop <- state_pop %>% 
  # Removing rows that aren't states
  slice(-1, -10, -53, -54, -55) %>% 
  # Removing columns from previous years population
  select(-2, -3, -4, -6, -7) %>% 
  # Renaming remaining columns 
  rename(State = Name, 
         Population_2020 = `Pop. 2020`) 
   

combined_data <- cln_tran_usda %>% 
  left_join(cln_state_pop, 
            by = "State") %>%
  left_join(cln_tran_cdc,
            by = c("State" = "LocationDesc")) %>%  
  filter(!is.na(Stratification1)) %>% 
  mutate(fmart_100k = count_fmart / (Population_2020 / 100000),
         income_strat = relevel(as.factor(Stratification1), ref = "Less than $15,000"))  

# Removing unused data sets 
remove(raw_cdc, raw_usda, state_pop, cln_state_pop, cln_tran_cdc, cln_tran_usda, 
       cdc_cols_drop, columns_to_encode, usda_drop)


  





            
            
            
           























