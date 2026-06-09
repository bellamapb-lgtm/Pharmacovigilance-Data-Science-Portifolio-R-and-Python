# ==============================================================================
# PROJECT 1: OPENFDA API CONNECTION (PHARMACOVIGILANCE SURVEILLANCE)
# ==============================================================================

# Step 1: Load required libraries
library(httr)
library(jsonlite)
library(tidyverse)

# Step 2: Fetch adverse event data for Ibuprofen from the openFDA API
response <- GET("https://api.fda.gov/drug/event.json?search=patient.drug.medicinalproduct:IBUPROFEN&count=patient.reaction.reactionmeddrapt.exact&limit=10")

# Step 3: Extract raw content as readable text using UTF-8 encoding
raw_text <- content(response, "text", encoding = "UTF-8")

# Step 4: Parse the JSON text and convert it into a structured data frame
data_list <- fromJSON(raw_text)
final_table <- as.data.frame(data_list$results)

# Step 5: Print the final structured data table in the console
print(final_table)
