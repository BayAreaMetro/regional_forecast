# TO BAY AREA URBANSIM

## Overview
This foilder contains the regional forecast files for Bay Area UrbanSim.

## Files Setup
* [Household Control Totals](https://github.com/BayAreaMetro/bayarea_urbansim/blob/master/data/household_controls.csv): This table represents the total number of households forecast to live in the Bay Area in each forecast year. This means BAUS will ensure that its forecast conforms to these numbers. The values area counts of households. The values are segmented into four categories of approximate household income quartiles and provided for each forecast year (every 5 years from 2010 to 2050). NAME FORMAT: `household_controls_s#.csv` where # is the scenario number below.
* [Employment Control Totals](https://github.com/BayAreaMetro/bayarea_urbansim/blob/master/data/employment_controls.csv): This table represents the total number of jobs forecast to exist in the Bay Area in each forecast year. This means BAUS will ensure that its forecast conforms to these numbers. The values area counts of jobs. The values are segmented into six sectors and provided for each forecast year (every 5 years from 2010 to 2050). NAME FORMAT: `employment_controls_s#.csv` where # is the scenario number below.
* [Regional_Demographic_Forecast](https://github.com/BayAreaMetro/bayarea_urbansim/blob/datatypes_dict/data/regional_demographic_forecast.csv): This table provides region-level forecast data for households for each forecast year (every 5 years from 2010 to 2050). including the proprotion in various categories of income, size, worker count, householder age, and presence of children. NAME FORMAT: `regional_demographic_forecast_s#.csv` where # is the scenario number below.
* [Additional Regional Control Totals](https://github.com/BayAreaMetro/bayarea_urbansim/blob/master/data/regional_controls.csv): This table provides additional forecast information that is passed on to the Travel Model for each forecast year (every 5 years from 2010 to 2050). Values include counts of persons, employed residents, and persons by age category. Other values include the median age and the short term residential vacancy rate (set at 0.03, aka 3%, if no other expectations exist). NAME FORMAT: `regional_controls_s#.csv` where # is the scenario number below.
* [County Forecast Inputs](https://github.com/BayAreaMetro/bayarea_urbansim/blob/master/data/county_forecast_inputs.csv): This table provide the proportion of jobs expected to be in each occupation by county. NAME FORMAT: `county_forecast_inputs_s#.csv` where # is the scenario number below.
* [County Employment Forecast](https://github.com/BayAreaMetro/bayarea_urbansim/blob/master/data/county_employment_forecast.csv): This table provide the proportion of jobs expected to be in each occupation by county for each forecast year (every 5 years from 2010 to 2050). NAME FORMAT: `county_employment_forecast_s#.csv` where # is the scenario number below.


## Scenarios
Each folder contains 6 files for use in BAUS:
* meta: this folder contains data dictionaries ("dict") and optional metadata ("meta") for each of the files
* s20-s29 are scenario-specific folders for the scenarios described at https://github.com/BayAreaMetro/bayarea_urbansim/wiki/PBA50EIRalternatives and https://github.com/BayAreaMetro/bayarea_urbansim/wiki/PBA50scenarios
