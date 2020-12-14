grep("", ls("package:tidymodels"), value = TRUE) %>%
  walk(print) %>% 
  map(help)
# Equivalently:
ls("package:tidymodels") %>% 
  str_subset("tidy") %>% 
  walk(print) %>% 
  map(help)


tibble(old_names = grep("", ls("package:tidymodels"), value = TRUE),
       new_names = gsub("tidy", "banana", ls("package:tidymodels")))  

ggformula::gf_vline %>%
  body %>% 
  grep(pattern  = "lab", value = TRUE) 
