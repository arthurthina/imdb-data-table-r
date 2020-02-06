library(data.table)
library(sqldf)
imdb_titles <- fread("title.basics.tsv")
imdb_ratings <- fread("title.ratings.tsv")

imdb <- merge(imdb_titles, imdb_ratings, by = "tconst")

sqldf("select primaryTitle, averageRating, numVotes, startYear, genres 
      from imdb 
      where genres LIKE '%horror%'
      and titleType = 'movie' 
      and startYear > '2000'
      and averageRating > 7.7
      and numVotes > 200")

