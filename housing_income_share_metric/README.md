# Share of HH Income Spent on Housing Metric

Code and data here is used to calculate the metric for share of HH income spent on housing.

Data for this model come from different files (metadata is in csv file with "dict" appended to data file name):
* The count of HHs by pseudo-quartile for a given historical or forecast year come from the household_controls csv within each scenario directory at https://github.com/BayAreaMetro/regional_forecast/tree/master/to_baus. For instance, Scenario 21's HH forecasts file by pseudo-quartiles is at: https://github.com/BayAreaMetro/regional_forecast/blob/master/to_baus/s21/household_controls_s21.csv. These serves as inputs into this repository. 
* The hh_proportion_matrix_2015 is the share of HHs in each segment in 2015. Thhe hh_income_matrix_2015.csv is the mean share of HH income spent on housing for households in that segment in 2015. 
* The hh_proportion_matrix_2050_[snn].csv is the share of HHs in each segment in 2050. Thhe hh_income_matrix_2050_[snn].csv is the mean share of HH income spent on housing for households in that segment in 2050. 
* Data that is specific to each scenaro (besides the two matrices) is in [scenario_specific_parameters.csv](https://github.com/BayAreaMetro/regional_forecast/blob/master/housing_income_share_metric/scenario_specific_parameters.csv)

* Output table housing_income_share_output_snn_yyyy_mm_dd_tttt.csv (in the style of [housing_income_share_output_snn_yyyy_mm_dd_tttt_template.csv](https://github.com/BayAreaMetro/regional_forecast/blob/master/housing_income_share_metric/housing_income_share_output_[snn]_2020_05_15_1141_tempate.csv) above) where the end is a time stamp. This is set up as above with info on

