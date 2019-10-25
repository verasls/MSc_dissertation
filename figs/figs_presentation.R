# Load packages -----------------------------------------------------------

library(tidyverse)
library(readxl)

# Read data ---------------------------------------------------------------

acc <- read_csv("data/Waist_Calorimetry (2018-03-10)__ID_41__3_aval-IMU.csv", skip = 10) %>% 
  select(
    Timestamp,
    aX = "Accelerometer X",
    aY = "Accelerometer Y",
    aZ = "Accelerometer Z"
  ) %>% 
  mutate(
    VM = sqrt(aX^2 + aY^2 + aZ^2)
  )

# Indirect calorimetry
calorimetry <- read_excel(
  "data/4th__Cardiorespiratory__046.xlsx", skip = 3, col_names = FALSE
  ) %>% 
  select(
    time = "X__1",
    VO2 = "X__7",
    VCO2 = "X__8"
  ) %>% 
  mutate(
    kcal = (3.941 * (VO2 / 1000)) + (1.106 * (VCO2 / 1000))
  )
calorimetry$time <- str_replace(calorimetry$time, ":", "")
calorimetry$time <- as.numeric(calorimetry$time)

# Plot --------------------------------------------------------------------

acc_plot <- ggplot(data = acc) +
  geom_line(mapping = aes(x = Timestamp, y = VM))


# Uncomment lines below to save plot
# ggsave(
#   filename = "figs/accelerometry_plot.pdf", 
#   plot = acc_plot,
#   width = 14, height = 8
# )

cal_plot <- ggplot(data = calorimetry) +
  geom_point(mapping = aes(x = time, y = kcal))

# Uncomment lines below to save plot
# ggsave(
#   filename = "figs/calorimetry_plot.pdf", 
#   plot = cal_plot,
#   width = 14, height = 8 
# )