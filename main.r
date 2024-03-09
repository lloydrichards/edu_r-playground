library(tidyr);
library(dplyr);
library(ggplot2);

# Load data
data <- read.csv("data/baumkataster.csv");

# Summarize data
summary(data);
head(data);

# Plot data
ggplot(data, aes(x=pflanzjahr)) +
  geom_histogram(binwidth=1, fill="blue", color="black") +
  theme_tufte();


