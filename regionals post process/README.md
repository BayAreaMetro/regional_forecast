### Regionals Post Process

## Overview
This folder contains the scripts and data disctionaries needed to process results from REMI model into the format needed by UrbanSim and Travel Model 2.

## Content

* [BEA_to_EDD_ACS_employment_translate.ipynb](BEA_to_EDD_ACS_employment_translate.ipynb): This script intends to translate REMI employment numbers (BEA concept) into BLS + ACS concept employment. The ratios were calculated using 2015 published BEA data, and BLS (CA EDD data) full time employment data and ACS 2013-2017 5-year Self Employment data. These ratios ([emp_translate.csv](emp_translate.csv)) were used to scale the REMI forecast results. The values are segmented into 5-year intervals (2015 to 2050) and into 11 categories (which is what's available in the ACS table, [sectormap.csv](sectormap.csv))

* [Control_Totals_for_UrbanSim_PBA50.ipynb](Control_Totals_for_UrbanSim_PBA50.ipynb): This script intends to compile all population, employment (from REMI) and household (from MTC/ABAG household and income models) results into a single excel file. It includes: population by age groups [age_group.csv](age_group.csv), employment by industry [ind_6_cat.csv](ind_6_cat.csv), household by income bins, and total population/jobs/households.

