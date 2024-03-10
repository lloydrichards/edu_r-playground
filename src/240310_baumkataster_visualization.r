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
    type = as.factor(baumtyp),
    quarter = as.factor(quartier),
    year = as.factor(pflanzjahr),
    genus = as.factor(baumgattunglat),
    species = as.factor(baumartlat),
    category = as.factor(kategorie),
    size = as.factor(baumtyp),
    ) %>%
    select(poi_id, status, type, quarter, year, genus, species, category, size)

# examine structure
str(tidy_data)
head(tidy_data)

# how many trees are there of each species?
grouped <- tidy_data %>%
group_by(genus, species)%>%
summarize(count= n())%>%
arrange(desc(count))

#    genus    species       count
#    <fct>    <fct>         <int>
#  1 Acer     platanoides    4700
#  2 Malus    domestica      4258
#  3 Carpinus betulus        4141
#  4 Platanus x hispanica    3094
#  5 Betula   pendula        3091
#  6 Acer     campestre      2964
#  7 Aesculus hippocastanum  2390
#  8 Fraxinus excelsior      2364
#  9 Taxus    baccata        2337
# 10 Pinus    sylvestris     2314

# visualize the top 10 species
top_10 <- grouped %>% head(10)

print(top_10)

ggplot(top_10, aes(x = reorder(species, count), y = count)) +
    geom_bar(stat = "identity") +
    coord_flip() +
    labs(title = "Top 10 species in the dataset",
         x = "Species",
         y = "Count")

# visualize the top 10 species by quarter using small multiples
top_10_quarter <- tidy_data %>%
    group_by(quarter, genus) %>%
    summarize(count = n()) %>%
    arrange(desc(count)) %>%
    filter(count > 20)

ggplot(top_10_quarter, aes(x = reorder(genus, count), y = count, fill = quarter)) +
    geom_bar(stat = "identity") +
    labs(title = "Top 10 genus by quarter",
         x = "Genus",
         y = "Count") +
    facet_wrap(~quarter) +
    theme(legend.position = "none",
            axis.text.x = element_text(angle = 90, hjust = 1, size = 4),
            )
    
# save the plot
ggsave("output/240310_by_quarter.png", width = 30, height = 30, units = "cm")