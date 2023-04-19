library(tidyverse)
library(scales)
library(ggthemr)
ggthemr('fresh')
library(ggrepel)

pd <- position_stack(0.65, reverse = T)

# load population file
getwd()
csv_file_path <- file.path(getwd(),'Documents/GitHub/regional_forecast/contextual/output/cacogpop_components_long_2020_2022.csv')
pdf_file_path <- file.path(getwd(),'Documents/GitHub/regional_forecast/contextual/plots/cacogpop_components_long_2020_2022.pdf')

popest <-
  read.csv(file_path)

# get a total series to show on plot as population net totals
popest_tot <-
  popest %>% filter(year > 2012) %>% group_by(region, year) %>%
  summarise(total = sum(value),
            .groups = 'drop') %>%
  as.data.frame()


pt <- ggplot(
  popest %>% filter(year > 2012 & variable != 'RESIDUAL'),
  aes(fill = variable,
      y = value,
      x = year)
) +
  scale_y_continuous(labels = scales::comma) +
  scale_x_continuous(labels =  as.integer) +
  geom_hline(yintercept = 0, color = 'black') +
  geom_bar(stat = 'identity', position = pd) +
  geom_line(
    data = popest_tot,
    aes(x = year, y = total),
    size = 1.5,
    color = "black",
    linetype = 2,
    inherit.aes = F
  ) +
  #geom_point(data=popest_tot,aes(x = year, y = total), size = 1.5, color="white",inherit.aes = F)+
  geom_point(
    data = popest_tot,
    aes(x = year, y = total),
    shape = 16,
    size = 2.5,
    fill = "white",
    color = "white"
  ) +
  geom_point(
    data = popest_tot,
    aes(x = year, y = total),
    shape = 1,
    size = 2.5,
    fill = "white"
  ) +
  geom_text(
    data = popest_tot,
    aes(
      x = year,
      y = total,
      #label=formatC(total/1000, format="f", big.mark=",", digits=0)),
      label = sprintf("%+3.1f%s", total / 1000, 'k')
    ),
    inherit.aes = F,
    color = 'white',
    angle = 90,
    hjust = -.15,
    size = 3.5
  ) +
  theme(
    axis.text.x = element_text(
      angle = 90,
      size = 11,
      hjust = 0.5,
      vjust = 0.5
    ),
    axis.text.y = element_text(angle = 0, size = 11),
    strip.text = element_text(face = "bold", size = 11),
    legend.text = element_text(size = 11),
    panel.border = element_rect(colour = "black", fill = NA),
    legend.position = "bottom"
  ) +
  #xlab('') + ylab('') +
  facet_wrap( ~ region, scales = 'free', ncol = 4) +
  guides(col = guide_legend(nrows = 1)) +
  labs(
    fill = '' ,
    title = sprintf('COG Regions Population Components of Change'),
    subtitle = "Sources:U.S. Census Bureau, Population Estimates\nhttps://www2.census.gov/programs-surveys/popest/datasets/2020-2022/counties/totals/co-est2022-alldata.csv\nhttps://www2.census.gov/programs-surveys/popest/datasets/2010-2020/counties/totals/co-est2020-alldata.csv",
    caption = paste(
      'Line and labels represent net change from all sources, in 1000s',
      format(Sys.time(), "%a %b %d %Y %H:%M:%S"),
      sep = '\n'
    )
  )
pt

ggsave(
  pdf_file_path,
  width = 17,
  height = 11
)
