source(file = "./Scripts/data_cleaning.R")
library(usmap)

combined_data %>% ggplot(aes(x=fmart_100k, y=Data_Value)) +
  geom_point() +
  geom_smooth(method='lm', formula= y~x) +
  facet_wrap(~ income_strat) +
  labs(x = "USDA Farmers Markets", 
         y ="Percent of Adult Population with Obesity", 
         title = "Obesity vs Farmers Markets")


combined_data %>% ggplot(aes(x=fmart_100k, y=Data_Value, color = income_strat)) +
  geom_point() +
  labs(x = "USDA Farmers Markets", 
       y ="Percent of Adult Population with Obesity", 
       title = "Obesity vs Farmers Markets",
       color = "Annual Income")

combined_data %>%
  mutate(state = as.character(State)) %>% 
  group_by(state) %>% 
  summarise(avg_obs = mean(Data_Value)) %>% View()
  plot_usmap(values ="avg_obs")
