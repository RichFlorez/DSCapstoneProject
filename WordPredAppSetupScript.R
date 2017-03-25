## Environment Set Up

library(dplyr) #for working with data frames
library(tidyr) #for splitting ngrams into separate cols
library(NLP) #NLP infrastructure, req for tm
library(tm) #for text mining
library(SnowballC) #for stemming
library(slam) #algorithms for arrays and matrices


## Data Import

blogs <- readLines("~/Documents/CourseraDataScienceSpecialization/10DataScienceCapstoneProject/final/en_US/en_US.blogs.txt", warn = FALSE, encoding = "UTF-8")

news <- readLines("~/Documents/CourseraDataScienceSpecialization/10DataScienceCapstoneProject/final/en_US/en_US.news.txt", warn = FALSE, encoding = "UTF-8")

twitter <- readLines("~/Documents/CourseraDataScienceSpecialization/10DataScienceCapstoneProject/final/en_US/en_US.twitter.txt", warn = FALSE, encoding = "UTF-8")


## Tidying Up the DataSets

blogsCln <- iconv(blogs, "latin1", "ASCII", sub="")

newsCln <- iconv(news, "latin1", "ASCII", sub="")

twitterCln <- iconv(twitter, "latin1", "ASCII", sub="")


## Sample Data Set Creation

set.seed(1234) #use this to reproduce results

sampleSize <- .01 #to more easily change sample size

sampleCombinedData <- c(sample(blogsCln, length(blogsCln) * sampleSize),
                        sample(newsCln, length(newsCln) * sampleSize),
                        sample(twitterCln, length(twitterCln) * sampleSize))


## Corpus Creation

sampleDataCorpus <- VCorpus(VectorSource(sampleCombinedData))
sampleDataCorpus <- tm_map(sampleDataCorpus, removeNumbers)
sampleDataCorpus <- tm_map(sampleDataCorpus, removePunctuation)
#sampleDataCorpus <- tm_map(sampleDataCorpus, removeWords, stopwords("en"))
#sampleDataCorpus <- tm_map(sampleDataCorpus, stemDocument, language = "en")
sampleDataCorpus <- tm_map(sampleDataCorpus, stripWhitespace)
sampleDataCorpus <- tm_map(sampleDataCorpus, tolower)
sampleDataCorpus <- tm_map(sampleDataCorpus, PlainTextDocument)


## DataSet N-Gram Tokenization

biGramTokenizer <- function(x)
  unlist(lapply(ngrams(words(x), 2), paste, collapse = " "), use.names = FALSE)

tdmBiGram <- TermDocumentMatrix(sampleDataCorpus, control = list(tokenize = biGramTokenizer))

freqBiGram <- rowapply_simple_triplet_matrix(tdmBiGram,sum)
freqBiGram <- freqBiGram[order(freqBiGram,decreasing=TRUE)]
biGram <- as.data.frame(freqBiGram)
biGram <- data.frame(words = row.names(biGram),biGram)
names(biGram)[2] = "Frequency"
row.names(biGram) <- NULL
biGram <- as.data.frame(biGram) %>% separate(words, into = paste("W", 1:2, sep = "_"))
names(biGram)[1] = "Uni"
names(biGram)[2] = "Bi"

triGramTokenizer <- function(x)
  unlist(lapply(ngrams(words(x), 3), paste, collapse = " "), use.names = FALSE)

tdmTriGram <- TermDocumentMatrix(sampleDataCorpus, control = list(tokenize = triGramTokenizer))

freqTriGram <- rowapply_simple_triplet_matrix(tdmTriGram,sum)
freqTriGram <- freqTriGram[order(freqTriGram,decreasing=TRUE)]
triGram <- as.data.frame(freqTriGram)
triGram <- data.frame(words = row.names(triGram),triGram)
names(triGram)[2] = "Frequency"
row.names(triGram) <- NULL
triGram <- as.data.frame(triGram) %>% separate(words, into = paste("W", 1:3, sep = "_"))
names(triGram)[1] = "Uni"
names(triGram)[2] = "Bi"
names(triGram)[3] = "Tri"

quadGramTokenizer <- function(x)
  unlist(lapply(ngrams(words(x), 4), paste, collapse = " "), use.names = FALSE)

tdmQuadGram <- TermDocumentMatrix(sampleDataCorpus, control = list(tokenize = quadGramTokenizer))

freqQuadGram <- rowapply_simple_triplet_matrix(tdmQuadGram,sum)
freqQuadGram <- freqQuadGram[order(freqQuadGram,decreasing=TRUE)]
quadGram <- as.data.frame(freqQuadGram)
quadGram <- data.frame(words = row.names(quadGram),quadGram)
names(quadGram)[2] = "Frequency"
row.names(quadGram) <- NULL
quadGram <- as.data.frame(quadGram) %>% separate(words, into = paste("W", 1:4, sep = "_"))
names(quadGram)[1] = "Uni"
names(quadGram)[2] = "Bi"
names(quadGram)[3] = "Tri"
names(quadGram)[4] = "Quad"

## Save N-grams to Project Folder

setwd("~/myApp/WordPredApp")
saveRDS(biGram, file = "./biGram.rds")
saveRDS(triGram, file = "./triGram.rds")
saveRDS(quadGram, file = "./quadGram.rds")




