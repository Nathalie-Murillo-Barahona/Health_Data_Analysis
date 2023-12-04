
####################################################
# Script: helper_functions.r
# Author: Nathalie Murillo-Barahona
# Date: 2023/21/11
#---------------------------------------------------
# Change History:
####################################################  


# A function which calculates the marginal change in Odds ratio 
# with the change in level of a independent ordinal variable 
marginal_ods_calc <- function(y, x, weight, x_ord){
    
    n_levels <- max(x_ord)
    
    output <- data.frame(ref_level = rep("", n_levels - 1),
                         comp_level = rep("", n_levels - 1),
                         marginal_or = rep(0, n_levels - 1),
                         CI_lower = rep(0, n_levels - 1),
                         CI_upper = rep(0, n_levels - 1))
    
    for(i in 1:(n_levels - 1)){
      
      x_filtered_ref <- x[x_ord == i]
      
      x_filtered_comp <- x[x_ord == i + 1]
      
      ref <- as.character(x_filtered_ref[1])
      
      comp <- as.character(x_filtered_comp[1])
      
      x_releveled <- relevel(x, ref)
      
      model <- glm(y ~ x_releveled,
                   family = binomial(link = "logit"),
                   weights = weight)
      
      coef <- as.numeric(model$coefficients[i + 1])
      
      CI <- as.data.frame(confint(model))
      
      m_or <- exp(coef)
      
      CI_lower <- exp(CI$`2.5 %`[i + 1])
      
      CI_upper <- exp(CI$`97.5 %`[i + 1])
      
      output$ref_level[i] <- ref
      output$comp_level[i] <- comp
      output$marginal_or[i] <- m_or
      output$CI_lower[i] <- CI_lower
      output$CI_upper[i] <- CI_upper
    }
    return(output)
}

# expand a data frame which is compressed by sample weight 
expand_by_weight <- function(data, weight){
  expanded_data <- data %>%
    slice(rep(1:n(), each = data[[weight]])) 
  
  return(expanded_data)
  
}


 