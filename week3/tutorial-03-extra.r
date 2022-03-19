# use recipes to transform the predictor
wage_prep <-
  recipe(wage ~ age,
         data = Wage) %>%
  step_poly(age, degree = 4) %>%
  prep()
wage_prep_baked <- bake(wage_prep, new_data = NULL)

# Take a look a the polynomials being used
wage_all <- Wage %>%
  select(age) %>%
  bind_cols(wage_prep_baked)

ggduo(wage_all, columnsX = 1,
      columnsY = 3:6,
      types = list(continuous = "points"))

# Fit the model
lm_mod <-
  linear_reg() %>%
  set_engine("lm")

lm_fit <-
  lm_mod %>%
  fit(wage ~ ., data = wage_prep_baked)
tidy(lm_fit)
glance(lm_fit)

# Note: why not use this code: step_poly fits raw but
# doesn't allow for fitting orthonormal

