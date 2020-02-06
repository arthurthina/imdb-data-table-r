library(data.table)
library(dplyr)
imdb_titles <- fread("title.basics.tsv")
imdb_ratings <- fread("title.ratings.tsv")
dim(imdb_titles)
dim(imdb_ratings)

imdb <- merge(imdb_titles, imdb_ratings, by = "tconst")

glimpse(imdb)
imdb$startYear <- as.numeric(imdb$startYear)
colSums(sapply(imdb, is.na))
sum(duplicated(imdb))
print(unique(imdb$genres))
summary(imdb$averageRating)

horror_imdb <- imdb[genres %like% "Horror" & startYear >= 1995 & startYear <= 2018] %>% 
   .[titleType == "movie" & averageRating >= 7.9 & numVotes > 100,
    .(primaryTitle, averageRating, numVotes, startYear, genres)] %>%
   .[order(-averageRating)]
print(horror_imdb)
