# Load packages -----------------------------------------------------------

library(tidyverse)

# Read data ---------------------------------------------------------------

articles_by_year <- read_csv("data/scopus_data.csv", skip = 7) %>% 
  select(
    year = YEAR,
    n    = X2
  )

# Make plot ---------------------------------------------------------------

arts_plot <- ggplot(data = articles_by_year) +
  geom_point(mapping = aes(x = year, y = n)) +
  geom_line(mapping = aes(x = year, y = n)) +
  scale_x_continuous(breaks = seq(from = 1981, to = 2018, by = 1)) +
  scale_y_continuous(breaks = seq(from = 0, to = 1500, by = 100)) +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 90)) +
  labs(x = "Year", y = "Articles")

# Uncomment lines below to save plot
# ggsave(
#   filename = "figs/fig1.tiff",
#   plot = arts_plot, width = 20, height = 10, dpi = 600, units = "cm"
# )