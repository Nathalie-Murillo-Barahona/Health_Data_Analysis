source(file = "./Scripts/data_cleaning.R")
source(file = "./Scripts/helper_functions.R")

# use function to return estimates of marginal effects from moving up an income level on probability of being obese
marginal_effects <- 
  marginal_ods_calc(y = cln_tran_cdc$Data_Value/100,
                 x = cln_tran_cdc$income_strat,
                 weight = cln_tran_cdc$Sample_Size,
                 x_ord = cln_tran_cdc$income_ordinal)
marginal_effects |> ggplot(aes(y =  marginal_or, 
                               x = comp_level)) +
  geom_point() +
  geom_errorbar(aes(ymin=CI_lower, ymax=CI_upper), width=.2,
                position=position_dodge(0.05)) +
  labs(title = "Change in Odds Ratio")



test <- glm(cln_tran_cdc$Data_Value/100 ~ cln_tran_cdc$income_strat,
    family = binomial(link = "logit"),
    weights =cln_tran_cdc$Sample_Size)
CI <- as.data.frame(confint(test))
CI$`2.5 %`[]