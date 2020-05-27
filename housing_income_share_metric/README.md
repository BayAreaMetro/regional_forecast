# Share of HH Income Spent on Housing Metric

** NEED TO UPDATE SOME TABLES FOR CONSISTENCY WHEN CHOOSE BASEYEAR

Code and data here is used to calculate the metric for share of HH income spent on housing.

Data for this model come from different files (metadata is in csv file with "dict" appended to data file name):
* The count of HHs by pseudo-quartile for a given historical or forecast year come from the household_controls csv within each scenario directory at https://github.com/BayAreaMetro/regional_forecast/tree/master/to_baus. For instance, Scenario 21's HH forecasts file by pseudo-quartiles is at: https://github.com/BayAreaMetro/regional_forecast/blob/master/to_baus/s21/household_controls_s21.csv 
* Most data that pertains to all scenarios is in [generic_parameters.csv](https://github.com/BayAreaMetro/regional_forecast/blob/master/housing_income_share_metric/generic_parameters.csv) above.
* The matrix that sets the share of HHs in each situation that are in each pseuo_quartile is at [situation_income_matrix.csv](https://github.com/BayAreaMetro/regional_forecast/blob/master/housing_income_share_metric/situation_income_matrix.csv). Each cell sets the proprortion of units in that situation that are filled by HHs in that quartile and tenure combination.  This table is set up so that it is missing the column (Q4o) and final row (HHs in market-rate housing). The script will calculate the counts in these cells as a remainder of the other values. So, row and column totals cannot exceed 1 (but they will often be less, leaving some spots for the remainder row or column).
* Data that is specific to each scenaro (besides HH counts) is in [scenario_specific_parameters.csv](https://github.com/BayAreaMetro/regional_forecast/blob/master/housing_income_share_metric/scenario_specific_parameters.csv)

The script to calculate the metric is called sssss.py OR sssss.R above. It takes the data through these steps:
* calc count of HH in each situation X pseudo-quartile X tenure cell
* calculate weighted share of income in each comnbo of situation X pseudo-quartile X tenure
* adjust for price control timeline and transfer to build "comprehensive" prices
* Output table housing_income_share_output_yyyy_mm_dd_tttt.csv (in the style of [housing_income_share_output_yyyy_mm_dd_tttt_template.csv](https://github.com/BayAreaMetro/regional_forecast/blob/master/housing_income_share_metric/housing_income_share_output_2020_05_15_1141_tempate.csv) above) where the end is a time stamp. This is set up as above with info on

