####################################################
# Script: eda.r
# Author: Nathalie Murillo-Barahona
# Date: 12/30/2023
#---------------------------------------------------
# Change History:
####################################################

source(file = "./Scripts/data_cleaning.R")
source(file = "./Scripts/helper_functions.R")

# Look at summary statistics for Obesity rate in adults by income level 
summary_stats <- cln_tran_cdc %>% 
  expand_by_weight("Sample_Size") %>% 
  group_by(income_strat) %>% 
  summarise(min_obs_rate = min(Data_Value, na.rm = TRUE),
            max_obs_rate = max(Data_Value, na.rm = TRUE),
            avg_obs_rate = round(mean(Data_Value, na.rm = TRUE), 2),
            median_obs_rate = median(Data_Value, na.rm = TRUE))






# use function to return estimates of marginal effects from moving up an income level on probability of being obese
marginal_effects <- 
  marginal_ods_calc(y = cln_tran_cdc$Data_Value/100,
                 x = cln_tran_cdc$income_strat,
                 weight = cln_tran_cdc$Sample_Size,
                 x_ord = cln_tran_cdc$income_ordinal)

marginal_effects_plot <- marginal_effects |> 
  ggplot(aes(y =  marginal_or, 
                               x = comp_level)) +
  geom_point() +
  geom_errorbar(aes(ymin=CI_lower, ymax=CI_upper), width=.2,
                position=position_dodge(0.05)) +
  labs(title = "Change in Odds Ratio",
       y = "Marginal Odd Ratio",
       x = "Income Level")

### Data visualizations ###
cln_tran_cdc %>% 
  expand_by_weight("Sample_Size") %>% 
  ggplot2::ggplot(aes(y = income_strat, 
                      x = Data_Value,

                      color = income_strat)) +
  geom_boxplot()

cln_tran_cdc %>% ggplot2::ggplot(aes(y = Data_Value))