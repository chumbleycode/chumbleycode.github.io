purity = function(x){
  # x a function
  # value: a list of external dependencies, TRUE means is function
  
  codetools::findGlobals(x) %>% 
    map(safely(get)) %>% 
    map("result") %>%
    set_names(codetools::findGlobals(x)) %>% 
    map_lgl(is.function) %>% 
    sort %>% 
    as_tibble(rownames = "obj") %>%  
    mutate(value = case_when(value == TRUE ~ "function",
                             value == FALSE ~ "variable")) %>% 
    print(n = Inf)
}