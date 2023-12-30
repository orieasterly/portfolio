# Power BI Labor Efficiency Analysis
Overview
This repository contains a Power BI report designed to analyze a dataset related to production, labor, and cost metrics. The DAX script defines a set of measures for calculating various key performance indicators (KPIs) and variances. The goal is to provide insights into production costs, efficiency, and variances, facilitating detailed analysis and reporting in Power BI.

## Key Measures

### Cost per KG
Calculates the cost per kilogram by dividing the sum of 'Product KG' by the sum of 'Labor Cost.'

### Production Yield
Production Yield per Labor Hour: Calculates production yield per labor hour.
Production Yield VAR: Computes the variance in production yield, vs budget and previous year.

### FTE Total
Calculates Full-Time Equivalent (FTE) hours total and variance to previous year and budget

### Production Efficiency Variance
Combines volume, productivity, and rate variances to provide an overall measure of production efficiency.
Productivity and Rate Variance Measures
VOL Variance: Measures the difference in cost or productivity due to changes in production volume.
Productivity Variance: Measures the difference in cost or productivity due to changes in labor efficiency.
Rate Variance: Measures the difference in cost due to changes in labor cost per hour.

### Production Volume
Production VOL Var: Computes the variance in production volume.


# Visualization Summary
![image](https://github.com/orieasterly/portfolio/assets/142043678/41cecc27-4fe2-4907-9df4-984af0cbc228)
