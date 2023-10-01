
  marginal_ods_calc <- function(y, x, weight, x_ord){
    
    n_levels <- max(x_ord)
    
    output <- data.frame(ref_level = rep("", n_levels - 1),
                         comp_level = rep("", n_levels - 1),
                         marginal_or = rep(0, n_levels - 1))
    
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
      
      m_or <- 1 - exp(coef)
      
      output$ref_level[i] <- ref
      output$comp_level[i] <- comp
      output$marginal_or[i] <- m_or
    }
    return(output)
  }
  
 