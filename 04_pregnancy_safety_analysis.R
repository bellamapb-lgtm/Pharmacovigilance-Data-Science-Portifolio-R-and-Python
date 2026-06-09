# ==============================================================================
# PROJECT 04: PREGNANCY REGISTRY ANALYSIS (LOGISTIC REGRESSION)
# ==============================================================================
# Objective: Evaluate the association between drug exposure and congenital 
# malformations, adjusting for maternal age and smoking (EMA GVP P.III).

library(tidyverse)
library(broom)

# Simulated Pregnancy Registry Data
set.seed(123)
n_cases <- 500

pregnancy_data <- tibble(
  patient_id = 1:n_cases,
  exposed = sample(c(1, 0), n_cases, replace = TRUE, prob = c(0.4, 0.6)),
  maternal_age = round(rnorm(n_cases, mean = 30, sd = 5)),
  smoking = sample(c(1, 0), n_cases, replace = TRUE, prob = c(0.15, 0.85)),
  malformation = rbinom(n_cases, 1, prob = 0.05 + 0.12*exposed + 0.005*maternal_age)
)

# Multivariate Logistic Regression (Confounder Adjustment)
model <- glm(malformation ~ exposed + maternal_age + smoking, 
             data = pregnancy_data, family = binomial)

# Extracting Odds Ratios (OR) and Confidence Intervals (95% CI)
results_table <- tidy(model, exponentiate = TRUE, conf.int = TRUE) %>%
  filter(term != "(Intercept)") %>%
  mutate(term = recode(term, "exposed" = "Drug Exposure", 
                             "maternal_age" = "Maternal Age",
                             "smoking" = "Smoking Status"))

print(results_table)
