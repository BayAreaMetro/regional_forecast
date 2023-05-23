# Consolidate regional forecasts into a single file to visualize together
#
# For now, just focuses on population, households, and jobs by county
#
library(dplyr)
library(readr)
library(readxl)
library(stringr)

ONE_THOUSAND <- 1000

# Counties of interest
BAY_AREA_COUNTIES <- c(
    "Alameda",
    "Contra Costa",
    "Marin",
    "Napa",
    "San Francisco",
    "San Mateo",
    "Santa Clara",
    "Sonoma",
    "Solano"
)

# Caltrans Long-Term Socio-Economic Forecasts by County
CALTRANS_FILES_PATH <- "M:/Data/Regional Forecast/Caltrans/forecast-data-*.xls*"
CALTRANS_FILES <- Sys.glob(CALTRANS_FILES_PATH)

# Box Drive location -- set this by user
BOX_DRIVE <- "unset"
if (Sys.getenv("USERNAME")=="lzorn") {
    BOX_DRIVE <- "E://Box"
}
stopifnot(BOX_DRIVE != "unset")

# Plan Bay Area 2050 Regional Forecast by County (Regional Transportation Plan 2021)
# Technically this isn't just regional since it's by county so it's from BAUS
RTP_2021_FILES_DIR <- file.path(BOX_DRIVE, "Modeling and Surveys", "Urban Modeling", 
    "Bay Area UrbanSim", "PBA50", "Final Blueprint runs", "Final Blueprint (s24)", 
    "BAUS v2.25 - FINAL VERSION")
RTP_2021_FILES <- Sys.glob(paste(RTP_2021_FILES_DIR,"run182_county_summaries_*.csv",
    sep=.Platform$file.sep))

# Write resuls here
OUTPUT_FILE <- "M:\\Data\\Regional Forecast\\consolidated_forecasts.csv"

# Store results here
consolidated_forecast <- tibble()

# --------- Caltrans Long-Term Socio-Economic Forecasts by County
for (caltrans_file in CALTRANS_FILES) {
    print(paste("Reading Caltrans Forecast file:",caltrans_file))
    forecast_release_year <- str_extract(caltrans_file, "forecast-data-([[:digit:]]+).xls", group=1)

    for (county in BAY_AREA_COUNTIES) {
        county_caltrans_forecast <- suppressMessages(read_excel(caltrans_file, sheet=county))
        # print(str(county_caltrans_forecast))

        # select only the columns we need
        county_caltrans_forecast <- select(
            county_caltrans_forecast,
            "...1", "Population (people)", "Households (thousands)", "Total Wage & Salary"
        )
        # rename columns for clarity
        county_caltrans_forecast <- rename(county_caltrans_forecast, c(
            "year"                 = "...1",
            "population"           = "Population (people)",
            "households_thousands" = "Households (thousands)",
            "jobs_thousands"       = "Total Wage & Salary"
        ))
        # filter out year=NA rows
        county_caltrans_forecast <- filter(county_caltrans_forecast, !is.na(year))
        # make year and jobs numeric
        county_caltrans_forecast$year           <- as.numeric(county_caltrans_forecast$year)
        county_caltrans_forecast$jobs_thousands <- as.numeric(county_caltrans_forecast$jobs_thousands)
        # print(str(county_caltrans_forecast))
        # remove thousants factors
        county_caltrans_forecast <- mutate(county_caltrans_forecast,
            households = households_thousands * ONE_THOUSAND,
            jobs       = jobs_thousands * ONE_THOUSAND
        ) %>% select(-households_thousands, -jobs_thousands)
        # print(str(county_caltrans_forecast))

        # store county and forecast source
        county_caltrans_forecast <- mutate(county_caltrans_forecast,
            source = paste("Caltrans", forecast_release_year),
            county = county,
        )
        # save
        consolidated_forecast <- rbind(consolidated_forecast, county_caltrans_forecast)
    }
}

# --------- Plan Bay Area 2050 (Regional Transportation Plan 2021)
for (rtp_2021_file in RTP_2021_FILES) {
    print(paste("Reading RTP 2021 file:", rtp_2021_file))
    forecast_release_year <- 2021
    year <- as.numeric(str_extract(rtp_2021_file, "county_summaries_([[:digit:]]+).csv", group=1))

    rtp_2021_forecast <- suppressMessages(read_csv(rtp_2021_file))
    # select county, population, households, jobs
    rtp_2021_forecast <- select(rtp_2021_forecast, COUNTY_NAME, TOTPOP, TOTHH, TOTEMP) %>% rename(
        county     = COUNTY_NAME,
        population = TOTPOP,
        households = TOTHH,
        jobs       = TOTEMP)
    # add source and year
    rtp_2021_forecast <- mutate(rtp_2021_forecast, 
        source = "Regional Transportation Plan 2021",
        year   = year
    )
    # save
    consolidated_forecast <- rbind(consolidated_forecast, rtp_2021_forecast)
}

# save consolidated
write_csv(consolidated_forecast, OUTPUT_FILE)
print(paste("Wrote",nrow(consolidated_forecast),"rows to",OUTPUT_FILE))
