# Share of HH Income Spent on Housing Metric

Code and data here is used to calculate the metric for share of HH income spent on housing.

Data for this model come from different files (metadata is in csv file with "dict" appended to data file name):
* The count of HHs by pseudo-quartile for a given historical or forecast year come from the household_controls csv within each scenario directory at https://github.com/BayAreaMetro/regional_forecast/tree/master/to_baus. For instance, Scenario 21's HH forecasts file by pseudo-quartiles is at: https://github.com/BayAreaMetro/regional_forecast/blob/master/to_baus/s21/household_controls_s21.csv 
* Most data that pertains to all scenarios is in 
* The matrix that sets the share of HHs in each situation that are in each pseuo_quartile is at . Each cell sets the proprortion of units in that situation that are filled by HHs in that quartile.  This table is set up so that it is missing the column (Q4) and final row (HHs in market-rate housing). The script will calculate the counts in these cells as a remainder of the other values. So, row and column totals cannot exceed 1 (but they will often be less, leaving some spots for the remainder row or column).
* Data that is specific to each scenaro (besides HH counts) is in 
