library(tidyverse)
ratings <- read_csv("derived_data/ratings_counts.csv");

# Bar chart of ratings
ratings %>% ggplot(aes(reorder(name,id),cached_count)) + geom_col(fill="#CC0000") +
  ggtitle("Ratings of Published Works") + xlab("Rating") + ylab("Number of Works") +
  geom_text(aes(label = cached_count), vjust = -1, colour = "black", size = 3) +
  theme(plot.title = element_text(hjust=0.5));
ggsave("figures/ratings.jpg",width=7.5,height=5)