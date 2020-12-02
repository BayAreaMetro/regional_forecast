# Share_Housing_Costs_Q1-4.R
# Create matrix for 2050 share of housing costs, starting with 2015 assumptions
# SI

### Set assumptions here for shares by housing type and income quartile:

scenario = "s24"

# Share of total households by unit type in 2015 (taken from 2010 values in below document)
# dr=deed restricted, su=subsidized, pc=price controlled, ma=market

drshare = 0.044  # From "2019 08 29 Housing Costs Forecast Model.xlsx": https://mtcdrive.app.box.com/file/515836887426
sushare = 0.027
pcshare = 0.058
mashare = 1-sum(drshare+sushare+pcshare)

# Percent of total units by type that are owned vs. rented
# Starting with the assumption that only market rate units are owned
# dr=deed restricted, su=subsidized, pc=price controlled - market rate rented units is calculated later

drrent = 1.0    # Share of deed restricted units that are rented (not owned)
surent = 1.0    # Share of subsidized units that are rented (not owned)
pcrent = 1.0    # Share of price controlled units that are rented (not owned)

# Distribution across income quartiles for each rental unit type. Q1-Q4 shares should sum to 1 (100%) 

drq1r = 1.0     # Deed restricted units, quartile 1, renters
drq2r = 0.0     # Deed restricted units, quartile 2, renters
drq3r = 0.0     # Deed restricted units, quartile 3, renters
drq4r = 0.0     # Deed restricted units, quartile 4, renters

drq1r_50 = 0.955283     # Deed restricted units, quartile 1, renters
drq2r_50 = 0.044717     # Deed restricted units, quartile 2, renters
drq3r_50 = 0.0            # Deed restricted units, quartile 3, renters
drq4r_50 = 0.0            # Deed restricted units, quartile 4, renters

suq1r = 1.0     # Subsidized households, quartile 1, renters
suq2r = 0.0     # Subsidized households, quartile 2, renters
suq3r = 0.0     # Subsidized households, quartile 3, renters
suq4r = 0.0     # Subsidized households, quartile 4, renters

pcq1r = 0.4     # Price control units, quartile 1, renters
pcq2r = 0.3     # Price control units, quartile 2, renters
pcq3r = 0.3     # Price control units, quartile 3, renters
pcq4r = 0.0     # Price control units, quartile 4, renters

pcq1r_50 = 0.0     # Price control units, quartile 1, renters
pcq2r_50 = 0.6     # Price control units, quartile 2, renters
pcq3r_50 = 0.4     # Price control units, quartile 3, renters
pcq4r_50 = 0.0     # Price control units, quartile 4, renters
# Share by income quartile for each owner unit type. Within each unit type, Q1-Q4 should sum to 1 (100%) 

drq1o = 1.0     # Deed restricted units, quartile 1, owners
drq2o = 0.0     # Deed restricted units, quartile 2, owners
drq3o = 0.0     # Deed restricted units, quartile 3, owners
drq4o = 0.0     # Deed restricted units, quartile 4, owners

suq1o = 1.0     # Subsidized households, quartile 1, owners
suq2o = 0.0     # Subsidized households, quartile 2, owners
suq3o = 0.0     # Subsidized households, quartile 3, owners
suq4o = 0.0     # Subsidized households, quartile 4, owners

pcq1o = 0.4     # Price control units, quartile 1, owners
pcq2o = 0.3     # Price control units, quartile 2, owners
pcq3o = 0.3     # Price control units, quartile 3, owners
pcq4o = 0.0     # Price control units, quartile 4, owners

# Share of income spent on housing for renters (assuming just under 30 percent - i.e., 0.29 for dr and su)

drq1incr = 0.29     # Deed restricted units, quartile 1, renters
drq2incr = 0.29     # Deed restricted units, quartile 2, renters
drq3incr = 0.29     # Deed restricted units, quartile 3, renters
drq4incr = 0.29     # Deed restricted units, quartile 4, renters

suq1incr = 0.29     # Subsidized households, quartile 1, renters
suq2incr = 0.29     # Subsidized households, quartile 2, renters
suq3incr = 0.29     # Subsidized households, quartile 3, renters
suq4incr = 0.29     # Subsidized households, quartile 4, renters

pc_fac1r = 0.857    # Factor converting market share of income to price control (pc_share=ma_share*0.857) for renters
pc_fac2r = 0.857    # Factor converting market share of income to price control (pc_share=ma_share*0.857) for renters
pc_fac3r = 0.857    # Factor converting market share of income to price control (pc_share=ma_share*0.857) for renters
pc_fac4r = 0.857    # Factor converting market share of income to price control (pc_share=ma_share*0.857) for renters

# Share of income spent on housing for owners

drq1inco = 0.29     # Deed restricted units, quartile 1, owners
drq2inco = 0.29     # Deed restricted units, quartile 2, owners
drq3inco = 0.29     # Deed restricted units, quartile 3, owners
drq4inco = 0.29     # Deed restricted units, quartile 4, owners

suq1inco = 0.29     # Subsidized households, quartile 1, owners
suq2inco = 0.29     # Subsidized households, quartile 2, owners
suq3inco = 0.29     # Subsidized households, quartile 3, owners
suq4inco = 0.29     # Subsidized households, quartile 4, owners

pcq1inco = 0.5     # Price control units, quartile 1, owners
pcq2inco = 0.4     # Price control units, quartile 2, owners
pcq3inco = 0.3     # Price control units, quartile 3, owners
pcq4inco = 0.2     # Price control units, quartile 4, owners

pc_fac1o = 0.857    # Factor converting market share of income to price control (pc_share=ma_share*0.857) for owners
pc_fac2o = 0.857    # Factor converting market share of income to price control (pc_share=ma_share*0.857) for owners
pc_fac3o = 0.857    # Factor converting market share of income to price control (pc_share=ma_share*0.857) for owners
pc_fac4o = 0.857    # Factor converting market share of income to price control (pc_share=ma_share*0.857) for owners

### End assumptions

# Input file locations

github_location     <- ("C:/Users/blu/Documents/GitHub/regional_forecast/housing_income_share_metric/")     # Needs to be set for script to work
pums_2015_location  <- paste0(github_location,"ACS PUMS 2015 Share Income Spent on Housing by Quartile_UBI.csv")
scenario_params_loc <- paste0(github_location,"scenario_specific_parameters.csv")

USERPROFILE     <- gsub("\\\\","/", Sys.getenv("USERPROFILE"))
BOX_Urban       <- file.path(USERPROFILE, "Box", "Modeling and Surveys", "Urban Modeling")
Urbansim_Runs   <- file.path(BOX_Urban, "Bay Area Urbansim", "PBA50", "Final Blueprint runs")
Analysis_Run    <- file.path(Urbansim_Runs,"Final Blueprint (s24)","BAUS v2.25")
County_2015_Loc <- file.path(Analysis_Run,"run182_county_summaries_2015.csv")
County_2050_Loc <- file.path(Analysis_Run,"run182_county_summaries_2050.csv")
 
# Import Libraries

suppressMessages(library(tidyverse))

# Set working directory

WD = "C:/Users/blu/Documents/GitHub/regional_forecast/housing_income_share_metric"
setwd(WD)

# Set CPI values

CPI2000      <- 180.20
CPI2015      <- 258.57
CPI_ratio    <- CPI2015/CPI2000 # 2015 CPI/2000 CPI

# Bring in 2015 PUMS data on share of income spent by renters/owners for different quartiles, from script:
# https://github.com/BayAreaMetro/PUMS-Data/blob/master/Analysis/ACS%20PUMS%202015/ACS%202015%20PUMS%20Share%20Income%20on%20Housing%20Costs%20by%20Quartile.R
# Bring in other relevant files: Urbansim run, scenario specific parameters

pums2015            <- read.csv(pums_2015_location,header=TRUE)

county_2015         <- read.csv(County_2015_Loc,header=TRUE,stringsAsFactors = FALSE) %>% 
  summarize(HHINCQ1=sum(HHINCQ1),HHINCQ2=sum(HHINCQ2),HHINCQ3=sum(HHINCQ3),HHINCQ4=sum(HHINCQ4), 
            TOTHH=sum(TOTHH)) 

county_2050         <- read.csv(County_2050_Loc,header=TRUE,stringsAsFactors = FALSE) %>% 
  summarize(HHINCQ1=sum(HHINCQ1),HHINCQ2=sum(HHINCQ2),HHINCQ3=sum(HHINCQ3),HHINCQ4=sum(HHINCQ4), 
            TOTHH=sum(TOTHH))
scenario_params     <- read.csv(scenario_params_loc,header = TRUE,stringsAsFactors = FALSE) 

## Fill in hh_proportion_matrix_2015 table

shell=data.frame(hu_type=c("dr","su","pc","ma"),q1r=0,q1o=0,q2r=0,q2o=0,   # Create zero values for housing unit types to calculate later
                 q3r=0,q3o=0,q4r=0,q4o=0)

rent_share <- pums2015 %>%                         # Use PUMS data to distribute 2015 run quartiles by owner/renter
  select(quartile,tenure, households) %>% 
  spread(tenure,households) %>% mutate(
    renter_share=Renter/Total) %>% 
  select(quartile,renter_share) %>% 
  spread(quartile,renter_share) %>% 
  rename(q1renters=Quartile1,q2renters=Quartile2,q3renters=Quartile3,q4renters=Quartile4)
  

temp15p <- county_2015 %>%  # Populate 2015 housing totals by income and tenure, join with shell above
  cbind(.,rent_share) %>% mutate(
    hu_type="total",
    q1r=round(HHINCQ1*q1renters),
    q1o=HHINCQ1-q1r,
    q2r=round(HHINCQ2*q2renters),
    q2o=HHINCQ2-q2r,
    q3r=round(HHINCQ3*q3renters),
    q3o=HHINCQ3-q3r,
    q4r=round(HHINCQ4*q4renters),
    q4o=HHINCQ4-q4r) %>% 
  select(hu_type,q1r,q1o,q2r,q2o,q3r,q3o,q4r,q4o)   %>% 
  rbind(shell,.) %>% mutate(                    # Add total columns for later calculations
    tr=q1r+q2r+q3r+q4r,                         # Create a column for total renters
    to=q1o+q2o+q3o+q4o,                         # Create a column for total owners
    tt=to+tr)                                   # Create a column for total units


temp15p <- temp15p %>% mutate(  # Now fill in cells
  tt=case_when(
    hu_type=="dr"        ~   temp15p[5,"tt"]*drshare,    # Calculate total deed restricted units in 2015
    hu_type=="su"        ~   temp15p[5,"tt"]*sushare,    # Calculate total subsidized units in 2015
    hu_type=="pc"        ~   temp15p[5,"tt"]*pcshare,    # Calculate total price control units in 2015
    hu_type=="ma"        ~   temp15p[5,"tt"]*mashare,    # Calculate total market units in 2015
    hu_type=="total"     ~   tt
  ),
  tr=case_when(
    hu_type=="dr"        ~   tt*drrent,                 # Calculate 2105 housing unit types into rented 
    hu_type=="su"        ~   tt*surent,
    hu_type=="pc"        ~   tt*pcrent,
    TRUE                 ~   tr))                       # Owned unit by housing unit type is total-rented


temp15p <- temp15p %>% mutate(
  q1r=case_when(
    hu_type=="dr"        ~   tr*drq1r,                  # Split totals for housing unit type (by rent/own) into income quartiles
    hu_type=="su"        ~   tr*suq1r,                  # Factors used are the assumptions asserted at the top
    hu_type=="pc"        ~   tr*pcq1r,
    TRUE                 ~   q1r),
  q2r=case_when(
    hu_type=="dr"        ~   tr*drq2r,
    hu_type=="su"        ~   tr*suq2r,
    hu_type=="pc"        ~   tr*pcq2r,
    TRUE                 ~   q2r),
  q3r=case_when(
    hu_type=="dr"        ~   tr*drq3r,
    hu_type=="su"        ~   tr*suq3r,
    hu_type=="pc"        ~   tr*pcq3r,
    TRUE                 ~   q3r),
  q4r=case_when(
    hu_type=="dr"        ~   tr*drq4r,
    hu_type=="su"        ~   tr*suq4r,
    hu_type=="pc"        ~   tr*pcq4r,
    TRUE                 ~   q4r),
  q1o=case_when(
    hu_type=="dr"        ~   to*drq1o,
    hu_type=="su"        ~   to*suq1o,
    hu_type=="pc"        ~   to*pcq1o,
    TRUE                 ~   q1o),
  q2o=case_when(
    hu_type=="dr"        ~   to*drq2o,
    hu_type=="su"        ~   to*suq2o,
    hu_type=="pc"        ~   to*pcq2o,
    TRUE                 ~   q2o),
  q3o=case_when(
    hu_type=="dr"        ~   to*drq3o,
    hu_type=="su"        ~   to*suq3o,
    hu_type=="pc"        ~   to*pcq3o,
    TRUE                 ~   q3o),
  q4o=case_when(
    hu_type=="dr"        ~   to*drq4o,
    hu_type=="su"        ~   to*suq4o,
    hu_type=="pc"        ~   to*pcq4o,
    TRUE                 ~   q4o)
) %>% 
  mutate_if(is.numeric,round,0)

# Subtract sum of values for dr,su, and pc units from total to yield market-rate unit cells

full_2015 <- temp15p %>% mutate(
  tr=case_when(
    hu_type=="ma"        ~ .[5,"tr"]-(.[1,"tr"] + .[2,"tr"] + .[3,"tr"]),
    TRUE                 ~ tr
    ),
  q1r=case_when(
    hu_type=="ma"        ~ .[5,"q1r"]-(.[1,"q1r"] + .[2,"q1r"] + .[3,"q1r"]),
    TRUE                 ~ q1r),
  q2r=case_when(
    hu_type=="ma"        ~ .[5,"q2r"]-(.[1,"q2r"] + .[2,"q2r"] + .[3,"q2r"]),
    TRUE                 ~ q2r),
  q3r=case_when(
    hu_type=="ma"        ~ .[5,"q3r"]-(.[1,"q3r"] + .[2,"q3r"] + .[3,"q3r"]),
    TRUE                 ~ q3r),
  q4r=case_when(
    hu_type=="ma"        ~ .[5,"q4r"]-(.[1,"q4r"] + .[2,"q4r"] + .[3,"q4r"]),
    TRUE                 ~ q4r),
  q1o=case_when(
    hu_type=="ma"        ~ .[5,"q1o"]-(.[1,"q1o"] + .[2,"q1o"] + .[3,"q1o"]),
    TRUE                 ~ q1o),
  q2o=case_when(
    hu_type=="ma"        ~ .[5,"q2o"]-(.[1,"q2o"] + .[2,"q2o"] + .[3,"q2o"]),
    TRUE                 ~ q2o),
  q3o=case_when(
    hu_type=="ma"        ~ .[5,"q3o"]-(.[1,"q3o"] + .[2,"q3o"] + .[3,"q3o"]),
    TRUE                 ~ q3o),
  q4o=case_when(
    hu_type=="ma"        ~ .[5,"q4o"]-(.[1,"q4o"] + .[2,"q4o"] + .[3,"q4o"]),
    TRUE                 ~ q4o)
) %>% mutate(
  to=tt-tr)

hh_proportion_matrix_2015 <- full_2015 %>% 
  filter(hu_type!="total") %>%                 # Remove total row to match prescribed format
  select(-tr,-to,-tt)                          # Remove variables to match prescribed format
  
## Fill in hh_income_matrix_2015 table

temp15i <- pums2015 %>%  # Populate 2015 share income spent, join with shell from above
  select(short_name,share_income) %>% 
  spread(short_name,share_income) %>% 
  mutate(hu_type="total") %>% 
  select(-q1t,-q2t,-q3t,-q4t) %>%              # Remove a few unnecessary variables
  rbind(shell,.) 

temp15i <- temp15i %>% mutate(
  q1r=case_when(
    hu_type=="dr"        ~   drq1incr,                  # Split totals for housing unit type (by rent/own) into income quartiles
    hu_type=="su"        ~   suq1incr,                  # Factors used are the assumptions asserted at the top
    TRUE                 ~   q1r),
  q2r=case_when(
    hu_type=="dr"        ~   drq2incr,
    hu_type=="su"        ~   suq2incr,
    TRUE                 ~   q2r),
  q3r=case_when(
    hu_type=="dr"        ~   drq3incr,
    hu_type=="su"        ~   suq3incr,
    TRUE                 ~   q3r),
  q4r=case_when(
    hu_type=="dr"        ~   drq4incr,
    hu_type=="su"        ~   suq4incr,
    TRUE                 ~   q4r),
  q1o=case_when(
    hu_type=="dr"        ~   drq1inco,
    hu_type=="su"        ~   suq1inco,
    TRUE                 ~   q1o),
  q2o=case_when(
    hu_type=="dr"        ~   drq2inco,
    hu_type=="su"        ~   suq2inco,
    TRUE                 ~   q2o),
  q3o=case_when(
    hu_type=="dr"        ~   drq3inco,
    hu_type=="su"        ~   suq3inco,
    TRUE                 ~   q3o),
  q4o=case_when(
    hu_type=="dr"        ~   drq4inco,
    hu_type=="su"        ~   suq4inco,
    TRUE                 ~   q4o)
) 

# Now calculate 2015 market share of income spent on housing (requires flexing your 8th grade algebra skills) 
"
Starting with equation to get weighted average of housing unit types: 'share' is share of income paid and 'count'
is count of units of that type (by income quartile and tenure):

(dr_count*dr_share*)+(su_count*su_share)+(pc_count*pc_share)+(ma_count*ma_share)=(total_count*total_share)

Substituting ma_share*pc_fac[income quartile,tenure] for pc_share and manipulating the variables:

ma_share=((total_count*total_share)-((dr_count*dr_share)+(su_count*su_share)))/((pc_count*pc_fac)+ma_count)
"
#ma_share=((total_count*total_share)-((dr_count*dr_share)+(su_count*su_share)))/ ((pc_count*pc_fac)+ma_count)

hh_income_matrix_2015 <- temp15i %>% mutate(
  q1r=case_when(
    hu_type=="ma"        ~ ((full_2015[5,"q1r"]*.[5,"q1r"])-            # Now use weighted average to determine market share of income spent
                              ((full_2015[1,"q1r"]*.[1,"q1r"])+
                                 (full_2015[2,"q1r"]*.[2,"q1r"])+
                                 (full_2015[3,"q1r"]*.[3,"q1r"])))/
                                 ((full_2015[3,"q1r"]*pc_fac1r)+full_2015[4,"q1r"]),
    TRUE                 ~ q1r),
  
  q2r=case_when(
    hu_type=="ma"        ~ ((full_2015[5,"q2r"]*.[5,"q2r"])-            # Now use weighted average to determine market share of income spent
                              ((full_2015[1,"q2r"]*.[1,"q2r"])+
                                 (full_2015[2,"q2r"]*.[2,"q2r"])+
                                 (full_2015[3,"q2r"]*.[3,"q2r"])))/
                                 ((full_2015[3,"q2r"]*pc_fac2r)+full_2015[4,"q2r"]),
    TRUE                 ~ q2r),
  
  q3r=case_when(
    hu_type=="ma"        ~ ((full_2015[5,"q3r"]*.[5,"q3r"])-            # Now use weighted average to determine market share of income spent
                              ((full_2015[1,"q3r"]*.[1,"q3r"])+
                                 (full_2015[2,"q3r"]*.[2,"q3r"])+
                                 (full_2015[3,"q3r"]*.[3,"q3r"])))/
                                 ((full_2015[3,"q3r"]*pc_fac3r)+full_2015[4,"q3r"]),
    TRUE                 ~ q3r),

  q4r=case_when(
    hu_type=="ma"        ~ ((full_2015[5,"q4r"]*.[5,"q4r"])-            # Now use weighted average to determine market share of income spent
                              ((full_2015[1,"q4r"]*.[1,"q4r"])+
                                 (full_2015[2,"q4r"]*.[2,"q4r"])+
                                 (full_2015[3,"q4r"]*.[3,"q4r"])))/
                                 ((full_2015[3,"q4r"]*pc_fac4r)+full_2015[4,"q4r"]),
    TRUE                 ~ q4r),
  
  q1o=case_when(
    hu_type=="ma"        ~ ((full_2015[5,"q1o"]*.[5,"q1o"])-            # Now use weighted average to determine market share of income spent
                              ((full_2015[1,"q1o"]*.[1,"q1o"])+
                                 (full_2015[2,"q1o"]*.[2,"q1o"])+
                                 (full_2015[3,"q1o"]*.[3,"q1o"])))/
                                 ((full_2015[3,"q1o"]*pc_fac1o)+full_2015[4,"q1o"]),
    TRUE                 ~ q1o),
  
  q2o=case_when(
    hu_type=="ma"        ~ ((full_2015[5,"q2o"]*.[5,"q2o"])-            # Now use weighted average to determine market share of income spent
                              ((full_2015[1,"q2o"]*.[1,"q2o"])+
                                 (full_2015[2,"q2o"]*.[2,"q2o"])+
                                 (full_2015[3,"q2o"]*.[3,"q2o"])))/
                                 ((full_2015[3,"q2o"]*pc_fac2o)+full_2015[4,"q2o"]),
    TRUE                 ~ q2o),
  
  q3o=case_when(
    hu_type=="ma"        ~ ((full_2015[5,"q3o"]*.[5,"q3o"])-            # Now use weighted average to determine market share of income spent
                              ((full_2015[1,"q3o"]*.[1,"q3o"])+
                                 (full_2015[2,"q3o"]*.[2,"q3o"])+
                                 (full_2015[3,"q3o"]*.[3,"q3o"])))/
                                 ((full_2015[3,"q3o"]*pc_fac3o)+full_2015[4,"q3o"]),
    TRUE                 ~ q3o),
  
  q4o=case_when(
    hu_type=="ma"        ~ ((full_2015[5,"q4o"]*.[5,"q4o"])-            # Now use weighted average to determine market share of income spent
                              ((full_2015[1,"q4o"]*.[1,"q4o"])+
                                 (full_2015[2,"q4o"]*.[2,"q4o"])+
                                 (full_2015[3,"q4o"]*.[3,"q4o"])))/
                                 ((full_2015[3,"q4o"]*pc_fac4o)+full_2015[4,"q4o"]),
    TRUE                 ~ q4o),
  
) %>% mutate(             # Now calculate pc share of income by multiplying market share*pc_fac[income quartile,tenure]
  
  q1r=case_when(
    hu_type=="pc"        ~ .[4,"q1r"]*pc_fac1r,
    TRUE                 ~ q1r),
  
  q2r=case_when(
    hu_type=="pc"        ~ .[4,"q2r"]*pc_fac2r,
    TRUE                 ~ q2r),
  
  q3r=case_when(
    hu_type=="pc"        ~ .[4,"q3r"]*pc_fac3r,
    TRUE                 ~ q3r),
  
  q4r=case_when(
    hu_type=="pc"        ~ .[4,"q4r"]*pc_fac4r,
    TRUE                 ~ q4r),
  
  q1o=case_when(
    hu_type=="pc"        ~ .[4,"q1o"]*pc_fac1o,
    TRUE                 ~ q1o),
  
  q2o=case_when(
    hu_type=="pc"        ~ .[4,"q2o"]*pc_fac2o,
    TRUE                 ~ q2o),
  
  q3o=case_when(
    hu_type=="pc"        ~ .[4,"q3o"]*pc_fac3o,
    TRUE                 ~ q3o),
  
  q4o=case_when(
    hu_type=="pc"        ~ .[4,"q4o"]*pc_fac4o,
    TRUE                 ~ q4o),
    ) %>% 
  filter(hu_type!="total") %>%                          # Remove row for totals to match prescribed format
  mutate_if(is.numeric,round,3)                         # Round to three decimal places
  

# Bring in 2050 scenario-specific information

for(i in 1:nrow(scenario_params)) {
  if(scenario_params[i,"scenario"]==scenario){
    rdr_2050=as.numeric(scenario_params[i,"rdr_units_2050"])
    odr_2050=as.numeric(scenario_params[i,"odr_units_2050"])
    rpc_2050=as.numeric(scenario_params[i,"total_rpc_units_2050"]) 	
    opc_2050=as.numeric(scenario_params[i,"total_opc_units_2050"]) 	
    price_2050_to_2015=as.numeric(scenario_params[i,"avg_hu_price_ratio_2050_to_2015"])
  }
}
 
## Populate 2050 tables

temp50p <- county_2050 %>%  # Populate 2050 housing totals by income and tenure, join with shell above
  cbind(.,rent_share) %>% mutate(       # Join renter shares from PUMS 2015
    hu_type="total",
    q1r=round(HHINCQ1*q1renters),       # Apply renter share   
    q1o=HHINCQ1-q1r,                    # Owners are 2050 Q1 HHs minus Q1 renters
    q2r=round(HHINCQ2*q2renters),
    q2o=HHINCQ2-q2r,
    q3r=round(HHINCQ3*q3renters),
    q3o=HHINCQ3-q3r,
    q4r=round(HHINCQ4*q4renters),
    q4o=HHINCQ4-q4r) %>% 
  select(hu_type,q1r,q1o,q2r,q2o,q3r,q3o,q4r,q4o)   %>% 
  rbind(shell,.) %>% mutate(                    # Add total columns for later calculations
    tr=q1r+q2r+q3r+q4r,                         # Create a column for total renters
    to=q1o+q2o+q3o+q4o,                         # Create a column for total owners
    tt=to+tr)                                   # Create a column for total units

temp50p <- temp50p %>% mutate(  # Now fill in cells
  tr=case_when(
    hu_type=="dr"        ~   rdr_2050,                 # Apply 2050 values from Scenario-Specific Values
    hu_type=="su"        ~   round((full_2015[2,"tr"]/full_2015[5,"tt"])*
                             county_2050[1,"TOTHH"]),  # Apply proportion from 2015 to 2050 su totals
    hu_type=="pc"        ~   rpc_2050,
    TRUE                 ~   tr),                     
  to=case_when(
    hu_type=="dr"        ~   odr_2050,                 # Apply 2050 values from Scenario-Specific Values
    hu_type=="su"        ~   round((full_2015[2,"to"]/full_2015[5,"tt"])*
                                     county_2050[1,"TOTHH"]),
    hu_type=="pc"        ~   opc_2050,
    TRUE                 ~   to), 
  )

temp50p <- temp50p %>% mutate(
  q1r=case_when(
    hu_type=="dr"        ~   tr*drq1r_50,                  # Split totals for housing unit type (by rent/own) into income quartiles
    hu_type=="su"        ~   tr*suq1r,                  # Factors used are the assumptions asserted at the top
    hu_type=="pc"        ~   tr*pcq1r_50,
    TRUE                 ~   q1r),
  q2r=case_when(
    hu_type=="dr"        ~   tr*drq2r_50,
    hu_type=="su"        ~   tr*suq2r,
    hu_type=="pc"        ~   tr*pcq2r_50,
    TRUE                 ~   q2r),
  q3r=case_when(
    hu_type=="dr"        ~   tr*drq3r_50,
    hu_type=="su"        ~   tr*suq3r,
    hu_type=="pc"        ~   tr*pcq3r_50,
    TRUE                 ~   q3r),
  q4r=case_when(
    hu_type=="dr"        ~   tr*drq4r_50,
    hu_type=="su"        ~   tr*suq4r,
    hu_type=="pc"        ~   tr*pcq4r_50,
    TRUE                 ~   q4r),
  q1o=case_when(
    hu_type=="dr"        ~   to*drq1o,
    hu_type=="su"        ~   to*suq1o,
    hu_type=="pc"        ~   to*pcq1o,
    TRUE                 ~   q1o),
  q2o=case_when(
    hu_type=="dr"        ~   to*drq2o,
    hu_type=="su"        ~   to*suq2o,
    hu_type=="pc"        ~   to*pcq2o,
    TRUE                 ~   q2o),
  q3o=case_when(
    hu_type=="dr"        ~   to*drq3o,
    hu_type=="su"        ~   to*suq3o,
    hu_type=="pc"        ~   to*pcq3o,
    TRUE                 ~   q3o),
  q4o=case_when(
    hu_type=="dr"        ~   to*drq4o,
    hu_type=="su"        ~   to*suq4o,
    hu_type=="pc"        ~   to*pcq4o,
    TRUE                 ~   q4o)
) %>% 
  mutate_if(is.numeric,round,0) 

full_2050 <- temp50p %>% mutate(
  q1r=case_when(
    hu_type=="ma"        ~ .[5,"q1r"]-(.[1,"q1r"] + .[2,"q1r"] + .[3,"q1r"]),
    TRUE                 ~ q1r),
  q2r=case_when(
    hu_type=="ma"        ~ .[5,"q2r"]-(.[1,"q2r"] + .[2,"q2r"] + .[3,"q2r"]),
    TRUE                 ~ q2r),
  q3r=case_when(
    hu_type=="ma"        ~ .[5,"q3r"]-(.[1,"q3r"] + .[2,"q3r"] + .[3,"q3r"]),
    TRUE                 ~ q3r),
  q4r=case_when(
    hu_type=="ma"        ~ .[5,"q4r"]-(.[1,"q4r"] + .[2,"q4r"] + .[3,"q4r"]),
    TRUE                 ~ q4r),
  q1o=case_when(
    hu_type=="ma"        ~ .[5,"q1o"]-(.[1,"q1o"] + .[2,"q1o"] + .[3,"q1o"]),
    TRUE                 ~ q1o),
  q2o=case_when(
    hu_type=="ma"        ~ .[5,"q2o"]-(.[1,"q2o"] + .[2,"q2o"] + .[3,"q2o"]),
    TRUE                 ~ q2o),
  q3o=case_when(
    hu_type=="ma"        ~ .[5,"q3o"]-(.[1,"q3o"] + .[2,"q3o"] + .[3,"q3o"]),
    TRUE                 ~ q3o),
  q4o=case_when(
    hu_type=="ma"        ~ .[5,"q4o"]-(.[1,"q4o"] + .[2,"q4o"] + .[3,"q4o"]),
    TRUE                 ~ q4o),
  tr=case_when(
    hu_type=="ma"        ~ .[5,"tr"]-(.[1,"tr"] + .[2,"tr"] + .[3,"tr"]),
    TRUE                 ~ tr),
  to=case_when(
    hu_type=="ma"        ~ .[5,"to"]-(.[1,"to"] + .[2,"to"] + .[3,"to"]),
    TRUE                 ~ to)) %>% 
  mutate(tt=to+tr)

hh_proportion_matrix_2050 <- full_2050 %>% 
  filter(hu_type!="total") %>%                 # Remove total row to match prescribed format
  select(-tr,-to,-tt)                          # Remove variables to match prescribed format

## Fill in hh_income_matrix_2050 table

# Start w/ 2015, make changes indicated by Forecasting Income Share Spent on Housing in 2050 memo

hh_income_matrix_2050     <- hh_income_matrix_2015 %>% mutate(
  q1r=case_when(
    hu_type=="dr"        ~   q1r,                
    hu_type=="su"        ~   q1r,                  
    hu_type=="pc"        ~   q1r*price_2050_to_2015,
    hu_type=="ma"        ~   q1r*price_2050_to_2015),
  q2r=case_when(
    hu_type=="dr"        ~   q2r,                
    hu_type=="su"        ~   q2r,                  
    hu_type=="pc"        ~   q2r*price_2050_to_2015,
    hu_type=="ma"        ~   q2r*price_2050_to_2015),
  q3r=case_when(
    hu_type=="dr"        ~   q3r,                
    hu_type=="su"        ~   q3r,                  
    hu_type=="pc"        ~   q3r*price_2050_to_2015,
    hu_type=="ma"        ~   q3r*price_2050_to_2015),
  q4r=case_when(
    hu_type=="dr"        ~   q4r,                
    hu_type=="su"        ~   q4r,                  
    hu_type=="pc"        ~   q4r*price_2050_to_2015,
    hu_type=="ma"        ~   q4r*price_2050_to_2015),
  q1o=case_when(
    hu_type=="dr"        ~   q1o,
    hu_type=="su"        ~   q1o,
    hu_type=="pc"        ~   q1o,
    hu_type=="ma"        ~   q1o*price_2050_to_2015),
  q2o=case_when(
    hu_type=="dr"        ~   q2o,
    hu_type=="su"        ~   q2o,
    hu_type=="pc"        ~   q2o,
    hu_type=="ma"        ~   q2o*price_2050_to_2015),
  q3o=case_when(
    hu_type=="dr"        ~   q3o,
    hu_type=="su"        ~   q3o,
    hu_type=="pc"        ~   q3o,
    hu_type=="ma"        ~   q3o*price_2050_to_2015),
  q4o=case_when(
    hu_type=="dr"        ~   q4o,
    hu_type=="su"        ~   q4o,
    hu_type=="pc"        ~   q4o,
    hu_type=="ma"        ~   q4o*price_2050_to_2015)
) %>% 
  mutate_if(is.numeric,round,3)

# Calculate weighted averages by quartile and tenure

w_q1r = ((hh_income_matrix_2050[1,"q1r"]*full_2050[1,"q1r"])+(hh_income_matrix_2050[2,"q1r"]*full_2050[2,"q1r"])+
           (hh_income_matrix_2050[3,"q1r"]*full_2050[3,"q1r"])+(hh_income_matrix_2050[4,"q1r"]*full_2050[4,"q1r"]))/
           full_2050[5,"q1r"]

w_q2r=((hh_income_matrix_2050[1,"q2r"]*full_2050[1,"q2r"])+(hh_income_matrix_2050[2,"q2r"]*full_2050[2,"q2r"])+
         (hh_income_matrix_2050[3,"q2r"]*full_2050[3,"q2r"])+(hh_income_matrix_2050[4,"q2r"]*full_2050[4,"q2r"]))/
         full_2050[5,"q2r"]

w_q3r=((hh_income_matrix_2050[1,"q3r"]*full_2050[1,"q3r"])+(hh_income_matrix_2050[2,"q3r"]*full_2050[2,"q3r"])+
         (hh_income_matrix_2050[3,"q3r"]*full_2050[3,"q3r"])+(hh_income_matrix_2050[4,"q3r"]*full_2050[4,"q3r"]))/
         full_2050[5,"q3r"]

w_q4r=((hh_income_matrix_2050[1,"q4r"]*full_2050[1,"q4r"])+(hh_income_matrix_2050[2,"q4r"]*full_2050[2,"q4r"])+
         (hh_income_matrix_2050[3,"q4r"]*full_2050[3,"q4r"])+(hh_income_matrix_2050[4,"q4r"]*full_2050[4,"q4r"]))/
         full_2050[5,"q4r"]

w_q1o=((hh_income_matrix_2050[1,"q1o"]*full_2050[1,"q1o"])+(hh_income_matrix_2050[2,"q1o"]*full_2050[2,"q1o"])+
         (hh_income_matrix_2050[3,"q1o"]*full_2050[3,"q1o"])+(hh_income_matrix_2050[4,"q1o"]*full_2050[4,"q1o"]))/
         full_2050[5,"q1o"]

w_q2o=((hh_income_matrix_2050[1,"q2o"]*full_2050[1,"q2o"])+(hh_income_matrix_2050[2,"q2o"]*full_2050[2,"q2o"])+
         (hh_income_matrix_2050[3,"q2o"]*full_2050[3,"q2o"])+(hh_income_matrix_2050[4,"q2o"]*full_2050[4,"q2o"]))/
         full_2050[5,"q2o"]

w_q3o=((hh_income_matrix_2050[1,"q3o"]*full_2050[1,"q3o"])+(hh_income_matrix_2050[2,"q3o"]*full_2050[2,"q3o"])+
         (hh_income_matrix_2050[3,"q3o"]*full_2050[3,"q3o"])+(hh_income_matrix_2050[4,"q3o"]*full_2050[4,"q3o"]))/
         full_2050[5,"q3o"]

w_q4o=((hh_income_matrix_2050[1,"q4o"]*full_2050[1,"q4o"])+(hh_income_matrix_2050[2,"q4o"]*full_2050[2,"q4o"])+
         (hh_income_matrix_2050[3,"q4o"]*full_2050[3,"q4o"])+(hh_income_matrix_2050[4,"q4o"]*full_2050[4,"q4o"]))/
         full_2050[5,"q4o"]

w_q1    =((w_q1r*full_2050[5,"q1r"])+(w_q1o*full_2050[5,"q1o"]))/(full_2050[5,"q1r"]+full_2050[5,"q1o"])
w_q2    =((w_q2r*full_2050[5,"q2r"])+(w_q2o*full_2050[5,"q2o"]))/(full_2050[5,"q2r"]+full_2050[5,"q2o"])
w_q3    =((w_q3r*full_2050[5,"q3r"])+(w_q3o*full_2050[5,"q3o"]))/(full_2050[5,"q3r"]+full_2050[5,"q3o"])
w_q4    =((w_q4r*full_2050[5,"q4r"])+(w_q4o*full_2050[5,"q4o"]))/(full_2050[5,"q4r"]+full_2050[5,"q4o"])
w_q1_q2 =((w_q1*(full_2050[5,"q1r"]+full_2050[5,"q1o"]))+(w_q2*(full_2050[5,"q2r"]+full_2050[5,"q2o"])))/
         (full_2050[5,"q1r"]+full_2050[5,"q1o"]+full_2050[5,"q2r"]+full_2050[5,"q2o"])
w_all   =((w_q1*(full_2050[5,"q1r"]+full_2050[5,"q1o"]))+(w_q2*(full_2050[5,"q2r"]+full_2050[5,"q2o"]))+
            (w_q3*(full_2050[5,"q3r"]+full_2050[5,"q3o"]))+(w_q4*(full_2050[5,"q4r"]+full_2050[5,"q4o"])))/
            full_2050[5,"tt"]

income_share <- data.frame(hu_type="total",w_q1r,w_q1o,w_q2r,w_q2o,w_q3r,w_q3o,w_q4r,w_q4o,w_q1,w_q2,w_q3,w_q4,
                           w_q1_q2,w_all)
  

# Export

write.csv(income_share,file="FBP 2050 Share of Income Spent on Housing.csv",row.names = FALSE,quote=TRUE)
write.csv(pums2015,file="FBP 2015 Share of Income Spent on Housing.csv",row.names = FALSE,quote=TRUE)

