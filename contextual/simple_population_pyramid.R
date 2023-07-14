library(ggplot2)
library(tidyverse)

race_data <- read.csv('/Users/aolsen/Box/Modeling and Surveys/Projects/Regional Growth Forecast Update/Forecasts/harvested/combo_race_summary.csv')
age_data <- read.csv('/Users/aolsen/Box/Modeling and Surveys/Projects/Regional Growth Forecast Update/Forecasts/harvested/combo_age_summary.csv')

age_cat_order <- c('under 5 years',
                   '5 to 9 years',
                   '10 to 14 years',
                   '15 to 19 years',
                   '20 to 24 years',
                   '25 to 29 years',
                   '30 to 34 years',
                   '35 to 39 years',
                   '40 to 44 years',
                   '45 to 49 years',
                   '50 to 54 years',
                   '55 to 59 years',
                   '60 to 64 years',
                   '65 to 69 years',
                   '70 to 74 years',
                   '75 to 79 years',
                   '80 to 84 years',
                   '85 years and over')

age_data$age_bin <- factor(age_data$age_bin, levels = age_cat_order, ordered = TRUE)

create_population_pyramids_pdf <- function(filtered_data, dimension_name, dimension_values, x_var, output_file, wrap_var) {
  plot <- ggplot(data = filtered_data, aes_string(x = x_var, fill = "year")) +
    geom_bar(data = filtered_data[filtered_data[[dimension_name]] == dimension_values[1], ],
             stat = 'identity', aes(y = value * -1, fill = as.character(dimension_values[1])), width = 1) +
    geom_bar(data = filtered_data[filtered_data[[dimension_name]] == dimension_values[2], ],
             stat = 'identity', aes(y = value, fill = as.character(dimension_values[2])), width = 1) +
    coord_flip() +
    xlab('') + ylab('') +
    scale_fill_manual(values = c("darkred", "darkblue")) +
    theme(
      strip.text.x = element_text(size = 10, angle = 0, face = "bold"),
      strip.text.y = element_text(size = 10, face = "bold"),
      legend.position = "bottom"
    ) +
    labs(
      title = sprintf('Age Distribution, (%s County)', filtered_data$county[1]),
      subtitle = 'Source: MTC from Woods & Poole, REMI, CA DOF',
      caption = format(Sys.time(), "%a %b %d %Y %H:%M:%S"),
      sep = '\n'
    ) +
    facet_wrap(paste("~", wrap_var)) +
    theme_bw()
  
  print(plot)
}

# Create population pyramids and save as a PDF file
pdf_path <- "/Users/aolsen/Box/Modeling and Surveys/Projects/Regional Growth Forecast Update/Forecasts/plots/pyramids_age_comparative.pdf"
pdf(pdf_path, width = 11, height = 8.5)

# loop through counties in data file - the first 9 happens to be Bay Area counties.
for (cnty in unique(age_data$county)[1:9]) {
  filtered_data <- age_data %>% subset(county %in% c(cnty))
  create_population_pyramids_pdf(filtered_data, dimension_name = 'year', x_var = 'age_bin',dimension_values = c(2020, 2050), wrap_var = "source")
}

dev.off()

# Create population pyramids and save as a PDF file
pdf_path <- "/Users/aolsen/Box/Modeling and Surveys/Projects/Regional Growth Forecast Update/Forecasts/plots/pyramids_race_comparative.pdf"
pdf(pdf_path, width = 11, height = 8.5)

# loop through counties in data file - the first 9 happens to be Bay Area counties.
for (cnty in unique(age_data$county)[1:9]) {
  filtered_data <- race_data %>% subset(county %in% c(cnty))
  create_population_pyramids_pdf(filtered_data, dimension_name = 'year', x_var = 'race_ethn',dimension_values = c(2020, 2050), wrap_var = "source")
}

dev.off()




create_population_pyramids_pdf(filtered_data, dimension_name = 'year', x_var = 'race_ethn', dimension_values = c(2020, 2050), wrap_var = "source")


filtered_data <- age_data %>% subset(county %in% c('Alameda') & year %in% c(2020, 2050))
create_population_pyramids_pdf(filtered_data, dimension_name = 'source', dimension_values = c('DOF', 'REMI RC'), wrap_var = "source")
