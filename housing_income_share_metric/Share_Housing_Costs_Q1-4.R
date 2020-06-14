# Share_Housing_Costs_Q1-4.R
# Create matrix for 2050 share of housing costs, starting with 2015 assumptions
# SI

### Set assumptions here for shares by housing type and income quartile:

scenario = "s21"

# Share of total households by unit type
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

drq1r = 0.5     # Deed restricted units, quartile 1, renters
drq2r = 0.5     # Deed restricted units, quartile 2, renters
drq3r = 0.0     # Deed restricted units, quartile 3, renters
drq4r = 0.0     # Deed restricted units, quartile 4, renters

suq1r = 0.5     # Subsidized households, quartile 1, renters
suq2r = 0.5     # Subsidized households, quartile 2, renters
suq3r = 0.0     # Subsidized households, quartile 3, renters
suq4r = 0.0     # Subsidized households, quartile 4, renters

pcq1r = 0.4     # Price control units, quartile 1, renters
pcq2r = 0.3     # Price control units, quartile 2, renters
pcq3r = 0.3     # Price control units, quartile 3, renters
pcq4r = 0.0     # Price control units, quartile 4, renters

# Share by income quartile for each owner unit type. Within each unit type, Q1-Q4 should sum to 1 (100%) 

drq1o = 0.5     # Deed restricted units, quartile 1, owners
drq2o = 0.5     # Deed restricted units, quartile 2, owners
drq3o = 0.0     # Deed restricted units, quartile 3, owners
drq4o = 0.0     # Deed restricted units, quartile 4, owners

suq1o = 0.5     # Subsidized households, quartile 1, owners
suq2o = 0.5     # Subsidized households, quartile 2, owners
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

pcq1incr = 0.5     # Price control units, quartile 1, renters
pcq2incr = 0.4     # Price control units, quartile 2, renters
pcq3incr = 0.3     # Price control units, quartile 3, renters
pcq4incr = 0.2     # Price control units, quartile 4, renters

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

### End assumptions

# Input file locations

github_location     <- ("C:/Users/sisrael/Documents/GitHub/regional_forecast/housing_income_share_metric/")     # Needs to be set for script to work
pums_2015_location  <- paste0(github_location,"ACS PUMS 2015 Share Income Spent on Housing by Quartile.csv")
scenario_params_loc <- paste0(github_location,"scenario_specific_parameters.csv")

USERPROFILE     <- gsub("\\\\","/", Sys.getenv("USERPROFILE"))
BOX_Urban       <- file.path(USERPROFILE, "Box", "Modeling and Surveys", "Urban Modeling")
Urbansim_Runs   <- file.path(BOX_Urban, "Bay Area Urbansim 1.5", "PBA50", "Draft Blueprint runs")
Analysis_Run    <- file.path(Urbansim_Runs,"Blueprint Basic (s21)","v1.5.1","v1.5.1.2 (to 2050)")
County_2050_Loc <- file.path(Analysis_Run,"run56_county_summaries_2050.csv")

# Import Libraries

suppressMessages(library(tidyverse))

# Set working directory

WD = "C:/Users/sisrael/Documents/GitHub/regional_forecast/housing_income_share_metric"
setwd(WD)

# Set CPI values

CPI2000      <- 180.20
CPI2015      <- 258.57
CPI_ratio    <- CPI2015/CPI2000 # 2015 CPI/2000 CPI

# Bring in 2015 PUMS data on share of income spent by renters/owners for different quartiles, from script:
# https://github.com/BayAreaMetro/PUMS-Data/blob/master/Analysis/ACS%20PUMS%202015/ACS%202015%20PUMS%20Share%20Income%20on%20Housing%20Costs%20by%20Quartile.R
# Bring in other relevant files: Urbansim run, scenario specific parameters

pums2015            <- read.csv(pums_2015_location,header=TRUE)
county_2050         <- read.csv(County_2050_Loc,header=TRUE) %>% 
  summarize(HHINCQ1=sum(HHINCQ1),HHINCQ2=sum(HHINCQ2),HHINCQ3=sum(HHINCQ3),HHINCQ4=sum(HHINCQ4), 
            TOTHH=sum(TOTHH)) 
scenario_params     <- read.csv(scenario_params_loc,header = TRUE)

## Fill in hh_proportion_matrix_2015 table

shell=data.frame(hu_type=c("dr","su","pc","ma"),q1r=0,q1o=0,q2r=0,q2o=0,   # Create zero values for housing unit types to calculate later
                 q3r=0,q3o=0,q4r=0,q4o=0,q1t=0,q2t=0,q3t=0,q4t=0)

temp15p <- pums2015 %>%  # Populate 2015 housing totals by income and tenure, join with shell above
  select(short_name,households) %>% 
  spread(short_name,households) %>% 
  mutate(hu_type="total") %>% 
  rbind(shell,.) %>% mutate(                    # Add total columns for later calculations
    tr=q1r+q2r+q3r+q4r,                         # Create a column for total renters
    to=q1o+q2o+q3o+q4o,                         # Create a column for total owners
    tt=q1t+q2t+q3t+q4t) %>%                     # Create a column for total units
  select(-q1t,-q2t,-q3t,-q4t)                   # Remove a few unnecessary variables

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
    TRUE                 ~   tr),                       # Owned unit by housing unit type is total-rented
  to=tt-tr)

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

full2015 <- temp15p %>% mutate(
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
) %>% 
  select(-tr,-to,-tt)                          # Remove variables to match prescribed format
  
hh_proportion_matrix_2015 <- full2015 %>% 
  filter(hu_type!="total")                     # Remove total row to match prescribed format

  
## Fill in hh_income_matrix_2015 table

temp15i <- pums2015 %>%  # Populate 2015 share income spent, join with shell from above
  select(short_name,share_income) %>% 
  spread(short_name,share_income) %>% 
  mutate(hu_type="total") %>% 
  rbind(shell,.) %>% 
  select(-q1t,-q2t,-q3t,-q4t)                   # Remove a few unnecessary variables

temp15i <- temp15i %>% mutate(
  q1r=case_when(
    hu_type=="dr"        ~   drq1incr,                  # Split totals for housing unit type (by rent/own) into income quartiles
    hu_type=="su"        ~   suq1incr,                  # Factors used are the assumptions asserted at the top
    hu_type=="pc"        ~   pcq1incr,
    TRUE                 ~   q1r),
  q2r=case_when(
    hu_type=="dr"        ~   drq2incr,
    hu_type=="su"        ~   suq2incr,
    hu_type=="pc"        ~   pcq2incr,
    TRUE                 ~   q2r),
  q3r=case_when(
    hu_type=="dr"        ~   drq3incr,
    hu_type=="su"        ~   suq3incr,
    hu_type=="pc"        ~   pcq3incr,
    TRUE                 ~   q3r),
  q4r=case_when(
    hu_type=="dr"        ~   drq4incr,
    hu_type=="su"        ~   suq4incr,
    hu_type=="pc"        ~   pcq4incr,
    TRUE                 ~   q4r),
  q1o=case_when(
    hu_type=="dr"        ~   drq1inco,
    hu_type=="su"        ~   suq1inco,
    hu_type=="pc"        ~   pcq1inco,
    TRUE                 ~   q1o),
  q2o=case_when(
    hu_type=="dr"        ~   drq2inco,
    hu_type=="su"        ~   suq2inco,
    hu_type=="pc"        ~   pcq2inco,
    TRUE                 ~   q2o),
  q3o=case_when(
    hu_type=="dr"        ~   drq3inco,
    hu_type=="su"        ~   suq3inco,
    hu_type=="pc"        ~   pcq3inco,
    TRUE                 ~   q3o),
  q4o=case_when(
    hu_type=="dr"        ~   drq4inco,
    hu_type=="su"        ~   suq4inco,
    hu_type=="pc"        ~   pcq4inco,
    TRUE                 ~   q4o)
) 

hh_income_matrix_2015 <- temp15i %>% mutate(
  q1r=case_when(
    hu_type=="ma"        ~ ((full2015[5,"q1r"]*.[5,"q1r"])-
                              ((full2015[1,"q1r"]*.[1,"q1r"])+
                                 (full2015[2,"q1r"]*.[2,"q1r"])+
                                 (full2015[3,"q1r"]*.[3,"q1r"])))/
                                 full2015[4,"q1r"],
    TRUE                 ~ q1r),
  
  q2r=case_when(
    hu_type=="ma"        ~ ((full2015[5,"q2r"]*.[5,"q2r"])-
                              ((full2015[1,"q2r"]*.[1,"q2r"])+
                                 (full2015[2,"q2r"]*.[2,"q2r"])+
                                 (full2015[3,"q2r"]*.[3,"q2r"])))/
                                 full2015[4,"q2r"],
    TRUE                 ~ q2r),
  
  q3r=case_when(
    hu_type=="ma"        ~ ((full2015[5,"q3r"]*.[5,"q3r"])-
                              ((full2015[1,"q3r"]*.[1,"q3r"])+
                                 (full2015[2,"q3r"]*.[2,"q3r"])+
                                 (full2015[3,"q3r"]*.[3,"q3r"])))/
                                 full2015[4,"q3r"],
    TRUE                 ~ q3r),

  q4r=case_when(
    hu_type=="ma"        ~ ((full2015[5,"q4r"]*.[5,"q4r"])-
                              ((full2015[1,"q4r"]*.[1,"q4r"])+
                                 (full2015[2,"q4r"]*.[2,"q4r"])+
                                 (full2015[3,"q4r"]*.[3,"q4r"])))/
                                 full2015[4,"q4r"],
    TRUE                 ~ q4r),
  
  q1o=case_when(
    hu_type=="ma"        ~ ((full2015[5,"q1o"]*.[5,"q1o"])-
                              ((full2015[1,"q1o"]*.[1,"q1o"])+
                                 (full2015[2,"q1o"]*.[2,"q1o"])+
                                 (full2015[3,"q1o"]*.[3,"q1o"])))/
                                 full2015[4,"q1o"],
    TRUE                 ~ q1o),
  
  q2o=case_when(
    hu_type=="ma"        ~ ((full2015[5,"q2o"]*.[5,"q2o"])-
                              ((full2015[1,"q2o"]*.[1,"q2o"])+
                                 (full2015[2,"q2o"]*.[2,"q2o"])+
                                 (full2015[3,"q2o"]*.[3,"q2o"])))/
                                 full2015[4,"q2o"],
    TRUE                 ~ q2o),
  
  q3o=case_when(
    hu_type=="ma"        ~ ((full2015[5,"q3o"]*.[5,"q3o"])-
                              ((full2015[1,"q3o"]*.[1,"q3o"])+
                                 (full2015[2,"q3o"]*.[2,"q3o"])+
                                 (full2015[3,"q3o"]*.[3,"q3o"])))/
                                 full2015[4,"q3o"],
    TRUE                 ~ q3o),
  
  q4o=case_when(
    hu_type=="ma"        ~ ((full2015[5,"q4o"]*.[5,"q4o"])-
                              ((full2015[1,"q4o"]*.[1,"q4o"])+
                                 (full2015[2,"q4o"]*.[2,"q4o"])+
                                 (full2015[3,"q4o"]*.[3,"q4o"])))/
                                 full2015[4,"q4o"],
    TRUE                 ~ q4o),
) %>% 
  filter(hu_type!="total") %>% 
  mutate_if(is.numeric,round,3)
  

# Bring in scenario-specific information



 
  
load (HH_RDATA) 

household <- hbayarea15 %>% 
  filter(!is.na(TEN) & TEN!=4) %>% 
  mutate(
    adjustedinc=HINCP*(ADJINC/1000000), 
    persons=case_when(
      NP>8L   ~8L,
      TRUE   ~NP
    )
  ) %>% 
#  group_by(persons) %>% 
  summarize(median_2015=wtd.quantile(adjustedinc,q=0.5,weight=WGTP)) %>% mutate(
    median_2010=median_2015/CPI_ratio,
    ELI_2015=(0.3*median_2015), 
    VLI_2015=(0.5*median_2015),
    ELI_2000=(0.3*median_2015)/CPI_ratio, 
    VLI_2000=(0.5*median_2015)/CPI_ratio
    ) %>% 
  mutate_if(is.numeric,round,0)

print(household)

# Recode data

Q4 <- hbayarea15 %>% 
  filter(TEN!=4) %>% mutate(                          # Remove occupied without payment of rent
  adjustedinc=HINCP*(ADJINC/1000000),                 #Adjusted income to constant 2015$ 
  tenure=case_when(
    TEN==1     ~ "Owner",                             # Owned with a mortgage
    TEN==2     ~ "Owner",                             # Owned free and clear
    TEN==3     ~ "Renter"                            # Rented
  )
  ) %>% 
  filter(!is.na(TEN) & adjustedinc>=Q4_threshold) %>% # Keep cases that are not GQ/vacant and are above inflated Q4 threshold    
  select(PUMA,PUMA_Name,HINCP,ADJINC, TEN,adjustedinc,tenure,WGTP)  # Select out relevant variables

# Summarize by tenure, then total, concatenate for a final dataset

Q4_tenure <- Q4 %>% 
  group_by(tenure) %>% 
  summarize(mean_income_2015dollars=weighted.mean(adjustedinc,WGTP))

Q4_total <- Q4 %>% 
  summarize(mean_income_2015dollars=weighted.mean(adjustedinc,WGTP))

temp <- data.frame("tenure"="Total")
temp_join <- cbind(temp,Q4_total)  
final <- rbind(Q4_tenure,temp_join) %>% mutate(
  mean_income_2000dollars=mean_income_2015dollars/CPI_ratio
)

# Export

write.csv(final,file="ACS PUMS 2015 Q4 Mean Income by Tenure.csv",row.names = FALSE,quote=TRUE)

trial <- temp15i %>% mutate(
  value=full2015[5,"q1r"]-(full2015[1,"q1r"]*.[1,"q1r"]+full2015[2,"q1r"]*.[2,"q1r"]+
                              full2015[3,"q1r"]*.[3,"q1r"])/full2015[4,q1r])