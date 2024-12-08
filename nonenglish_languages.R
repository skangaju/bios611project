library(tidyverse)
l <- read_csv("derived_data/language_counts.csv");

# Histogram of non-English languages
ggplot(l %>% filter(language!="en"), aes(language,count)) + 
  geom_col(fill="orange2") + ggtitle("Counts of Non-English Language Works") +
  xlab("Language Code") + ylab("Number of Works") +
  geom_text(aes(label = count), vjust = -1, colour = "black", size = 2.5) +
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE)) +
  theme(plot.title = element_text(hjust=0.5),
        axis.title = element_text(size=8));
ggsave("figures/nonenglish_languages.jpg",width=6,height=4)
