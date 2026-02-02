# Purpose: to generate population Pyramids given a (age, sex, population) data set
# Author: Hans Aisake
# Dated Created: 2026-01-02

# Load libraries
library(tidyverse)

# Read data
setwd("M:/HBA/Consulting/Team Members/Hans Aisake/GitHubRepos/Population-Segment-Projections")
data <- read_csv("population_pyramid_input.csv")

# Create a basic bar chart for one gender
basic_plot <-  ggplot(
  data, 
  aes(
    x = age, 
    fill = sex, 
    y = ifelse(
      test = sex == "M", 
      yes = -population, 
      no = population
    )
  )
) + 
  geom_bar(stat = "identity") 

# Create population pyramids for both genders and combine them
population_pyramid <- basic_plot +
  scale_y_continuous(
    labels = abs, 
    limits = max(data$population) * c(-1,1)
  ) + 
  coord_flip() + 
  theme_minimal() +
  labs(
    x = "Age", 
    y = "Population", 
    fill = "Age", 
    title = "Population Pyramid"
  )

# should be about 1/3 male, 2/3 female
# data %>% group_by(sex) %>% summarise( tot = sum(population))

population_pyramid