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
raw_cdc <- read_csv(file = "./Data/NPAO_Data.csv")


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
         !LocationAbbr %in% c("GU", "PR", "DC", "US"),
         Stratification1 != "Data not reported"
         ) %>%
  # Dropped unwanted columns
  select(-cdc_cols_drop) %>% 
  mutate(income_strat = relevel(as.factor(Stratification1), ref = "Less than $15,000"),
         income_ordinal = case_when(income_strat == "Less than $15,000" ~ 1,
                                    income_strat == "$15,000 - $24,999" ~ 2,
                                    income_strat == "$25,000 - $34,999" ~ 3,
                                    income_strat == "$35,000 - $49,999" ~ 4,
                                    income_strat == "$50,000 - $74,999" ~ 5,
                                    income_strat == "$75,000 or greater" ~ 6))
# write clean data for PBI VIZ 
write_csv(cln_tran_cdc, file = "./Data/clean_cdc.csv")





  





            
            
            
           























