# ==============================================================================
# PROJECT 2: AUTOMATED DRUG SAFETY ALERT SYSTEM (PYTHON)
# ==============================================================================
# Objective: Extract and analyze serious adverse events (hospitalization/death)
# for a specific drug using Python and Pandas.

import requests
import pandas as pd

print("--- Starting openFDA Data Extraction (Python) ---")

# Step 1: Define API Endpoint and parameters for a new target drug: METFORMIN
# We are filtering specifically for serious cases (seriousness = 1)
url = "https://api.fda.gov/drug/event.json"
params = {
    "search": "patient.drug.medicinalproduct:METFORMIN AND seriousness:1",
    "count": "patient.reaction.reactionmeddrapt.exact",
    "limit": 10
}

# Step 2: Execute the HTTP GET request
response = requests.get(url, params=params)

# Step 3: Parse JSON data and convert to a Pandas DataFrame
if response.status_code == 200:
    data = response.json()
    results = data['results']
    
    # Creating the structured table
    df_alerts = pd.DataFrame(results)
    
    # Renaming columns for clarity
    df_alerts.columns = ['MedDRA_Term', 'Serious_Case_Count']
    
    # Step 4: Data Transformation - Calculate percentage of impact
    total_serious = df_alerts['Serious_Case_Count'].sum()
    df_alerts['Percentage_Share'] = (df_alerts['Serious_Case_Count'] / total_serious) * 100
    
    # Step 5: Print the Automated Alert Report
    print("\n⚠️ [ALERT REPORT] TOP 10 SERIOUS ADVERSE EVENTS FOR METFORMIN ⚠️")
    print("================================================================")
    print(df_alerts.to_string(index=False))
    print("================================================================")
    
else:
    print(f"Failed to connect to openFDA API. Status Code: {response.status_code}")
  
