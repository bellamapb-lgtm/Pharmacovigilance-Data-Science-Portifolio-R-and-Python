# ==============================================================================
# PROJECT 2: TIME-TO-ONSET ANALYSIS (KAPLAN-MEIER IN PHARMACOVIGILANCE)
# ==============================================================================
# Objective: Analyze the time from drug initiation to the onset of a specific 
# adverse event, evaluating biological plausibility (ICH E2A guidelines).

library(survival)
library(survminer)
library(tidyverse)

# Simulated cohort data based on real PV dynamics
set.seed(42)
n_patients <- 200

cohort_data <- tibble(
  patient_id = 1:n_patients,
  days_to_onset = c(rexp(n_patients * 0.7, rate = 0.05), rexp(n_patients * 0.3, rate = 0.01)),
  event_occurred = sample(c(1, 0), n_patients, replace = TRUE, prob = c(0.75, 0.25)),
  age_group = sample(c("Adults", "Elderly"), n_patients, replace = TRUE, prob = c(0.6, 0.4))
) %>% 
  mutate(days_to_onset = round(if_else(days_to_onset < 1, 1, days_to_onset)))

# Fit Kaplan-Meier Survival Object
surv_object <- Surv(time = cohort_data$days_to_onset, event = cohort_data$event_occurred)
fit_km <- survfit(surv_object ~ age_group, data = cohort_data)

# Execute Log-Rank Test to compare groups
log_rank_test <- survdiff(surv_object ~ age_group, data = cohort_data)
print(log_rank_test)
