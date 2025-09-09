# Layoffs Data Analysis SQL Project

## Overview
This project explores global layoff data to identify trends and patterns. It started as a guided learning exercise based on a tutorial by AlexTheAnalyst(https://www.youtube.com/watch?v=QYd-RtK58VQ) and was expanded with my own SQL queries and analysis. 
As a fresher Data Analyst, this project served as a hands-on exercise to practice SQL skills, from data cleaning to deriving meaningful business insights. I followed a guidance video but expanded the analysis with my own unique calculations and findings.

**Original Contribution:** I extended the initial analysis to calculate the **Percentage Distribution of Total Layoffs by Country** and other metrics to gain a deeper geographical understanding of the data.

## Data Source
*   The dataset used is `layoffs.csv`, which contains information about layoffs from various companies worldwide.
*   Data source contained 1,995 rows of data post cleaning
  *   **Source:** The original dataset was acquired from AlexTheAnalyst's GitHub.(https://github.com/AlexTheAnalyst)

## Tools Used
*   **SQL:** Data cleaning, transformation, and analysis
*   **Git:** Version control

## Project Steps
1.  **Data Preparation:** Explored and cleaned the raw data in SQL (handling duplicates, NULL values, standardizing text).
2.  **Exploratory Data Analysis (EDA):** Performed initial analysis to understand key metrics like total layoffs per company, industry, and year.
3.  **Advanced Analysis (My Contribution):**
    *   Wrote queries to calculate the **`Distribution of Total Layoffs Across Countries (%)`**.
    *   Wrote queries to find the top 5 companies with most layoffs each  year **`year wise top 5 companies that carried out most layoffs`**.
      
## Key Insights
*   The country with the highest concentration of layoffs was **[United States]**, accounting for approximately **67%** of all layoffs in the dataset.
*   The year 2022 saw the most layoffs with total layoffs crossing **`160000`**.
*   The industry that saw the most amount of layoffs was the **`consumer`** industry, making it the the industry that was most affected by the pandemic.

## Files in this Repository
*   `layoffs.csv`: The dataset used for the analysis
*   `layoff analysis.sql`: Queries for analysis and insights
*   `datacln.sql`: Data cleaning queries
*   `README.md`: Project documentation (this file)

## Acknowledgments
*   Inspired by the SQL tutorial by **AlexTheAnalyst**(https://www.youtube.com/watch?v=QYd-RtK58VQ).
*   AlexTheAnalyst Github: https://github.com/AlexTheAnalyst
