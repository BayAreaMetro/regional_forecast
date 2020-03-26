### TO BAY AREA URBANSIM

## Overview
This foilder contains the regional output files for Bay Area UrbanSim 

## Files Setup
* [Household Control Totals](https://github.com/BayAreaMetro/bayarea_urbansim/blob/master/data/household_controls.csv): This table represents the total number of households forecast to live in the Bay Area in each forecast year. This means BAUS will ensure that its forecast conforms to these numbers. The values area counts of households. The values are segmented into 5-year intervals (2010 to 2050) and into four categories of approximate household income quartiles. FORMAT: household_controls_s# where # is the scenario number below
* [Employment Control Totals](https://github.com/BayAreaMetro/bayarea_urbansim/blob/master/data/employment_controls.csv): This table represents the total number of jobs forecast to exist in the Bay Area in each forecast year. This means BAUS will ensure that its forecast conforms to these numbers. The values area counts of jobs. The values are segmented into each 5-year intervals (2010 to 2050) and into six sectors.
* [Additional Regional Control Totals](https://github.com/BayAreaMetro/bayarea_urbansim/blob/master/data/regional_controls.csv): This table provides additional forecast information that is passed on to the Travel Model. THe final column is the expected
* [County Forecast Inputs](https://github.com/BayAreaMetro/bayarea_urbansim/blob/master/data/county_forecast_inputs.csv): 
* [County Employment Forecast](https://github.com/BayAreaMetro/bayarea_urbansim/blob/master/data/county_employment_forecast.csv):

## Scenarios
Each folder contains the 5 output files for use in BAUS:
* meta: this folder contains data dictionaries ("dict") and optional metadata ("meta") for each of the files
* s20: Baseline for PBA50 (so the lower HH count without policy change)
* s21: Blueprint Basic
* s22: Blueprint Plus Fix It First
* s23: Blueprint Plus Crossing
