# multivariate outcome_names

# The intersection analyes
source("R/supervised_play/load_data.R")
dt %>% select(controls, treatments, c("SNX2", "ARPC3", "ARPC5","TGFBR2") )
