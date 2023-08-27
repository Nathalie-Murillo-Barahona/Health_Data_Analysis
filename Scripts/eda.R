source(file = "./Scripts/data_cleaning.R")

summary(combined_data)

combined_data %>%
  group_by(Stratification1) %>%
  summarise(Correlation = cor(count_fmart, Data_Value, use="complete.obs"))

lm <- lm(Data_Value ~ income_strat * count_fmart, data = combined_data)

summary(lm)

relevel()

#Commiting this work to orgin