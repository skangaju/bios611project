library(tidyverse)
archwarn <- read_csv("derived_data/warnings_counts.csv");

# Bar chart of archive warnings
archwarn %>% ggplot(aes(reorder(name,id),cached_count)) + geom_col(fill="#CC0000") +
  ggtitle("Archive Warnings for Published Works") + 
  xlab("Archive Warning") + ylab("Number of Works") + 
  geom_text(aes(label = cached_count), vjust = -0.5, colour = "black", size = 2.75) +
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE)) +
  theme(plot.title = element_text(hjust=0.5),
        axis.text.x = element_text(angle=-30,hjust=0),
        axis.title = element_text(size=8),
        axis.text = element_text(size=7));
ggsave("figures/warnings.jpg",width=5,height=4.5)