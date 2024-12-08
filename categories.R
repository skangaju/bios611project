library(tidyverse)
categ <- read_csv("derived_data/categories_counts.csv");

# Bar chart of categories
categ %>% ggplot(aes(reorder(name,id),cached_count)) + geom_col(fill="#CC0000") +
  ggtitle("Categories of Published Works") + xlab("Category") + ylab("Number of Works") +
  geom_text(aes(label = cached_count), vjust = -0.75, colour = "black", size = 2.75) +
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE)) +
  theme(plot.title = element_text(hjust=0.5),
        axis.title = element_text(size=8),
        axis.text = element_text(size=7));
ggsave("figures/categories.jpg",width=5,height=4)