library(tidyverse)

# Works database
works <- read_csv("20210226-stats/works-20210226.csv") %>%
  rename(creation_date = `creation date`) %>%
  select(-`...7`);
works$creation_year <- sapply(works$creation_date,year);
N <- nrow(works);

# Counts of works by language
l <- works %>% group_by(language) %>% tally() %>% arrange(desc(n)) %>% rename(count=n);
l <- l %>% filter(count>1000) %>% 
  mutate(language = factor(language, l %>% arrange(desc(count)) %>% pull(language)));
l$percentage = 100 * l$count / N;
write_csv(l, "derived_data/language_counts.csv");

# Counts of ratings
ratings <- tags %>% filter(type=="Rating" & canonical==TRUE);
ratings$percentage <- ratings$cached_count / N;
ratings %>% select(id,name,cached_count,percentage) %>% 
  write_csv("derived_data/ratings_counts.csv");

# Counts of archive warnings
archwarn <- tags %>% filter(type=="ArchiveWarning" & canonical==TRUE);
archwarn$percentage <- archwarn$cached_count / N;
archwarn %>% select(id,name,cached_count,percentage) %>% 
  write_csv("derived_data/warnings_counts.csv");

# Counts of categories
categ <- tags %>% filter(type=="Category" & canonical==TRUE);
categ$percentage <- categ$cached_count / N;
categ %>% select(id,name,cached_count,percentage) %>% 
  write_csv("derived_data/categories_counts.csv");


# Number of works per year
works %>% group_by(creation_year) %>% tally() %>%
  ggplot(aes(creation_year,n)) + geom_col(fill="#CC0000") + 
  geom_text(aes(label = n), vjust = -1, colour = "black", size = 2.75) +
  ggtitle("Number of Works Published Per Year") + xlab("Creation Year") + 
  ylab("Number of Works") + scale_x_continuous(breaks = seq(2008, 2021, by = 1)) +
  theme(plot.title = element_text(hjust=0.5));
ggsave("figures/worksperyear.jpg",width=8,height=5);

# Completion status
works %>% group_by(complete) %>% tally() %>%
  ggplot(aes(complete,n)) + geom_col(fill="lightblue") +
  geom_text(aes(label = n), vjust = -0.5, colour = "black", size = 3) +
  ggtitle("Completion Status of Works") + xlab("Complete?") + ylab("Number of Works") +
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE)) +
  theme(plot.title = element_text(hjust=0.5),
        axis.title = element_text(size=8),
        axis.text = element_text(size=7));
ggsave("figures/completion.jpg",width=5,height=4);

# Restricted status
works %>% group_by(restricted) %>% tally() %>%
  ggplot(aes(restricted,n)) + geom_col(fill="pink") +
  geom_text(aes(label = n), vjust = -0.5, colour = "black", size = 3) +
  ggtitle("Restricted Status of Works") + xlab("Restricted?") + ylab("Number of Works") +
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE)) +
  theme(plot.title = element_text(hjust=0.5),
        axis.title = element_text(size=8),
        axis.text = element_text(size=7));
ggsave("figures/restricted.jpg",width=5,height=4);

# Histograms of word counts
ggplot(works %>% filter(word_count<1e4), aes(word_count)) + 
  geom_histogram(fill="green3",color="white") +
  ggtitle("Word Counts of Published Works (10000 Words and Under)") + 
  xlab("Word Count") + ylab("Number of Works") +
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE)) +
  theme(plot.title = element_text(hjust=0.5))
ggsave("figures/wordcounts_10000.jpg",width=8,height=5);

ggplot(works %>% filter(word_count<5e4), aes(word_count)) + 
  geom_histogram(fill="green3", color="white") +
  ggtitle("Word Counts of Published Works (50000 Words and Under)") + 
  xlab("Word Count") + ylab("Number of Works") +
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE)) +
  theme(plot.title = element_text(hjust=0.5));
ggsave("figures/wordcounts_50000.jpg",width=8,height=5)
