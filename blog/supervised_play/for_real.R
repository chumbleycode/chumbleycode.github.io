source("prepro.R")

# Define outcome
dt = dt %>% rename(y = ses_sss_composite)

set.seed(123)
split = initial_split(na.omit(dt))
training = training(split)
testing = testing(split)

folds <- vfold_cv(training, v = 10)
control <- control_resamples(save_pred = TRUE)

object = 
  list(
    logist = linear_reg() %>%
      set_engine("lm"),
    nearest = nearest_neighbor() %>%
      set_engine("kknn") %>%
      set_mode("regression"),
    forest = rand_forest() %>%
      set_engine("ranger") %>%
      set_mode("regression"), 
    svm = svm_rbf() %>%
      set_engine("kernlab") %>%
      set_mode("regression") 
  )

set.seed(234) # for fit_resamples()
bb = 
  map(signatures$outcome_set,
      function(outcomes) {
        
        slim_training = select(training, AID, y, controls, outcomes) # superset of all variables in the following designs
        preprocessor =
          list(
            controls_genes = recipe(y ~ ., data = select(slim_training, y, controls, outcomes)) %>%
              step_dummy(all_nominal()) %>%
              step_nzv(all_predictors()) %>%
              step_zv(all_predictors()) %>%
              # step_pca(all_predictors()) %>%
              step_naomit(all_predictors(), all_outcomes()),
            controls_genes_pca = recipe(y ~ ., data = select(slim_training, y, controls, outcomes)) %>%
              step_dummy(all_nominal()) %>%
              step_nzv(all_predictors()) %>%
              step_zv(all_predictors()) %>%
              step_pca(all_predictors()) %>%
              step_naomit(all_predictors(), all_outcomes()),
            controls = recipe(y ~ ., data = select(slim_training, y, controls)) %>% 
              step_dummy(all_nominal()) %>%
              step_nzv(all_predictors()) %>%
              step_zv(all_predictors()) %>%
              # step_pca(all_predictors()) %>% 
              step_naomit(all_predictors(), all_outcomes())
            
          )
        
        a = crossing(preprocessor, object) %>% 
          mutate(
            fits = pmap(., fit_resamples, 
                        control = control,
                        resamples = folds),
            metrics = map(fits, collect_metrics),
            preds = map(fits, collect_predictions),
            preds = map(preds, ~ arrange(.x, .row) %>%
                          bind_cols(slim_training)),
            preprocessor = names(preprocessor),
            object = names(object)
          )  
        return(a = a)
      }
  ) 

saveRDS(bb, "bb.rds")

############################################################
# EXAMINE
############################################################

if(0){ 
  map2_df(bb, names(bb),
          function(.x, .y) {
            .x %>% 
              select(-fits, -preds) %>% 
              unnest(metrics) %>%
              filter(.metric == "rsq") %>% 
              mutate(gene_set = .y)  %>% 
              select(gene_set, preprocessor, object, mean_rsq = mean)
          }
  ) %>% 
    arrange(-mean_rsq)
  
  bb %>% 
    pluck("ctra_mRNA") %>%
    list %>% 
    map(
      function(a) {
        a %>% 
          # for a big speed up
          select(preprocessor, object, preds) %>% 
          unnest(preds) %>% 
          gf_point(y ~ .pred ) %>% 
          gf_facet_wrap(~preprocessor + object, ncol = 2) %>% 
          print
      }
    )
  
  map(bb, 
      function(a) {
        a %>% 
          # for a big speed up
          select(preprocessor, object, preds) %>% 
          unnest(preds) %>% 
          gf_point(y - .pred ~ ifi35) %>% 
          gf_facet_wrap(~preprocessor + object, ncol = 2) %>% 
          print
      }
  )
  
  if(0){
    
    # residual analysis: 
    # what is the expected prediction error (e.g. rmse), on average over all input space X?
    # how does the local prediction error (out-of-sample residual) vary over input-space?
    # how does prediction error vary? systematically with some variable?
    bb %>% pluck("ctra_mRNA") %>% 
      select(preprocessor, preds) %>% 
      unnest(preds) %>% 
      gather("gene", "mRNA", signatures$outcome_set[[1]]) %>%
      select(gene, mRNA, y, .pred) %>% gf_point(y-.pred ~ mRNA) %>% 
      gf_facet_wrap(~gene)
    
  }
  
}