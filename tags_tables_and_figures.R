# Tags database
library(tidyverse)
tags <- read_csv("20210226-stats/tags-20210226.csv");
N <- 7269693;

# Ratings table
ratings <- tags %>% filter(type=="Rating" & canonical==TRUE);
ratings$percentage <- ratings$cached_count / N;
ratings %>% select(id,name,cached_count,percentage) %>% 
  write_csv("derived_data/ratings_counts.csv");

# Archive warnings table
archwarn <- tags %>% filter(type=="ArchiveWarning" & canonical==TRUE);
archwarn$percentage <- archwarn$cached_count / N;
archwarn %>% select(id,name,cached_count,percentage) %>% 
  write_csv("derived_data/warnings_counts.csv");

# Categories table
categ <- tags %>% filter(type=="Category" & canonical==TRUE);
categ$percentage <- categ$cached_count / N;
categ %>% select(id,name,cached_count,percentage) %>% 
  write_csv("derived_data/categories_counts.csv");

# Most active fandoms (bar chart of fandom tag counts)
top_fandoms <- tags %>% filter(name!="Redacted", type=="Fandom", cached_count>5e4,
                               !(id %in% c(7266, 586439, 727114, 1001939)));
top_fandoms %>% mutate(name = factor(name, top_fandoms %>% arrange(desc(cached_count)) %>% pull(name))) %>%
  ggplot(aes(name,cached_count)) + geom_col(fill="blue2") +
  ggtitle("Number of Works Published By Fandom") + xlab("Fandom") + ylab("Number of Works") +
  geom_text(aes(label = cached_count), vjust = -1, colour = "black", size = 2.5) +
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE)) +
  theme(plot.title = element_text(hjust=0.5),
        axis.text.x = element_text(angle=60,hjust=1));
ggsave("figures/worksbyfandom.jpg",width=8,height=8)