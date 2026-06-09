# ==============================================================================
# PROJECT 1 (PART 2): SAFETY SIGNAL DETECTION USING PRR (R)
# ==============================================================================
# Objective: Calculate the Proportional Reporting Ratio (PRR) for 
# Acute Kidney Injury to compare Ibuprofen against Acetaminophen.

library(httr)
library(jsonlite)
library(tidyverse)

# Step 1: Fetch total reports for denominators
total_ibu <- fromJSON(content(GET("https://api.fda.gov/drug/event.json?search=patient.drug.medicinalproduct:IBUPROFEN"), "text"))$meta$results$total
total_ctrl <- fromJSON(content(GET("https://api.fda.gov/drug/event.json?search=patient.drug.medicinalproduct:ACETAMINOPHEN"), "text"))$meta$results$total

# Step 2: Fetch specific Adverse Drug Reaction (ADR) counts for numerators
a_ibu_renal <- fromJSON(content(GET("https://api.fda.gov/drug/event.json?search=patient.drug.medicinalproduct:IBUPROFEN+AND+patient.reaction.reactionmeddrapt:\"Acute+kidney+injury\""), "text"))$meta$results$total
c_ctrl_renal <- fromJSON(content(GET("https://api.fda.gov/drug/event.json?search=patient.drug.medicinalproduct:ACETAMINOPHEN+AND+patient.reaction.reactionmeddrapt:\"Acute+kidney+injury\""), "text"))$meta$results$total

# Step 3: Define 2x2 contingency table variables
A <- a_ibu_renal
B <- total_ibu - A
C <- c_ctrl_renal
D <- total_ctrl - C

# Step 4: Calculate proportions and PRR Score
prop_target <- A / (A + B)
prop_control <- C / (C + D)
PRR_final <- prop_target / prop_control

# Step 5: Build the final regulatory metrics table
resultado_prr <- data.frame(
  Reaction = "Acute Kidney Injury",
  Ibuprofen_Cases = A,
  Control_Cases = C,
  PRR_Score = PRR_final,
  Is_Signal = ifelse(PRR_final >= 2 & A >= 3, "YES - SAFETY SIGNAL", "NO")
)

# Print metrics to console
print(resultado_prr)
