library(tidyr);
library(dplyr);
library(ggplot2);

# Load data
data <- read.csv("data/baumkataster.csv");

# Turn data into a tibble
raw_tibble <- as_tibble(data);

tidy_data <- raw_tibble %>%
    mutate(poi_id,
    status = as.factor(status),
    baumtyp = as.factor(baumtyp),
    quartier = as.factor(quartier),
    pflanzjahr = as.Date(ISOdate(pflanzjahr,1,1)),
    baumgattunglat = as.factor(baumgattunglat),
    baumartlat = as.factor(baumartlat),
    kategorie,
    )

# examine structure
str(tidy_data)

# how many trees are there of each species? max - 4747
tidy_data %>%
group_by(baumgattunglat, baumartlat)%>%
summarize(count= n())%>%
arrange(desc(count))