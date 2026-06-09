# Pharmacovigilance-Data-Science-Portifolio-R-and-Python
Data science projects applied to Pharmacovigilance, Drug Safety, and Regulatory Affairs using R and Python. Features real-time data extraction from the openFDA API
# Pharmacovigilance Data Science Portfolio: R & Python

This repository features practical data science projects demonstrating the application of programming languages in Drug Safety, Regulatory Affairs, and Patient Safety. The primary focus is turning raw health data into actionable regulatory insights.

---

## Project 1: Automated Adverse Event Data Extraction (openFDA API)

In this first module, I developed a script in **R** to connect directly with the U.S. Food and Drug Administration's official public API (**openFDA**). 

### Project Objectives:
1. Establish a secure HTTP connection with the adverse event endpoint (`drug/event.json`).
2. Query and extract real-time post-marketing surveillance data (JSON format) for a specific drug (**Ibuprofen**).
3. Perform data cleaning and transformation, converting nested JSON structures into a structured, tidy data frame.

### Tech Stack & Libraries:
* **httr**: For handling HTTP requests and API communication.
* **jsonlite**: For parsing, flattening, and converting JSON data into R data frames.
* **tidyverse**: For efficient data manipulation and syntax styling.

### Next Steps in Development:
* Implement data filtering to remove generic MedDRA terms (e.g., "Drug Ineffective").
* Generate statistical visualization (bar charts) using `ggplot2` to display the distribution of the most frequently reported Adverse Drug Reactions (ADRs).
* Calculate Disproportionality Scores (Proportional Reporting Ratio - PRR) for safety signal detection.

### 📈 Visual Insights:
Below is the chart generated directly from the script, showcasing the distribution of the top 15 reported adverse events:

![Top 15 Ibuprofen ADRs](top15_ibuprofen_adr.png)
