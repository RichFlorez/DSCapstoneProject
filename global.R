library(shinythemes) 
library(shiny)
library(NLP)
library(tm)
library(stringr)
library(wordcloud)
library(RColorBrewer)
library(stylo)

biGram <-  readRDS(file = "./biGram.rds")
triGram <-  readRDS(file = "./triGram.rds")
quadGram <-  readRDS(file = "./quadGram.rds")

dataCleaner <- function(text){
  cleanText <- tolower(text)
  cleanText <- removePunctuation(cleanText)
  cleanText <- removeNumbers(cleanText)
  cleanText <- str_replace_all(cleanText, "[^[:alnum:]]", " ")
  cleanText <- stripWhitespace(cleanText)
  return(cleanText)
}

cleanInput <- function(text){
  textInput <- dataCleaner(text)
  textInput <- txt.to.words.ext(textInput, language="English.all", preserve.case = TRUE)
  return(textInput)
}

nextWordPrediction <- function(wordCount,textInput){
  if (wordCount>=3) {
    textInput <- textInput[(wordCount-2):wordCount] 
  }
  else if(wordCount==2) {
    textInput <- c(NA,textInput)   
  }
  else {
    textInput <- c(NA,NA,textInput)
  }
  wordPrediction <- as.character(quadGram[quadGram$Uni==textInput[1] & 
     quadGram$Bi==textInput[2] & 
     quadGram$Tri==textInput[3],][1,]$Quad)
  if(is.na(wordPrediction)) {
    wordPrediction <- as.character(triGram[triGram$Uni==textInput[2] &
      triGram$Bi==textInput[3],][1,]$Tri)
  if(is.na(wordPrediction)) {
    wordPrediction <- as.character(biGram[biGram$Uni==textInput[3],][1,]$Bi)
  } 
}
cat(wordPrediction)
}
  
nextWordPrediction10 <- function(wordCount,textInput){
  if (wordCount>=3) {
    textInput <- textInput[(wordCount-2):wordCount] 
  }
  else if(wordCount==2) {
    textInput <- c(NA,textInput)   
  }
  else {
    textInput <- c(NA,NA,textInput)
  }
  wordPrediction10 <- as.character(quadGram[quadGram$Uni==textInput[1] & 
    quadGram$Bi==textInput[2] & 
    quadGram$Tri==textInput[3],][2:6,]$Quad)
  if(is.na(wordPrediction10)) {
    wordPrediction10 <- as.character(triGram[triGram$Uni==textInput[2] &
      triGram$Bi==textInput[3],][2:6,]$Tri)
  if(is.na(wordPrediction10)) {
    wordPrediction10 <- as.character(biGram[biGram$Uni==textInput[3],][2:6,]$Bi)
  }
}
cat(wordPrediction10)
}

nextWordPrediction50 <- function(wordCount,textInput){
  if (wordCount>=3) {
    textInput <- textInput[(wordCount-2):wordCount]
  }
  else if(wordCount==2) {
    textInput <- c(NA,textInput)
  }
  else {
    textInput <- c(NA,NA,textInput)
  }
  wordPrediction50 <- as.character(quadGram[quadGram$Uni==textInput[1] &
    quadGram$Bi==textInput[2] &
    quadGram$Tri==textInput[3],][1:25,]$Quad)
  if(is.na(wordPrediction50)) {
    wordPrediction50 <- as.character(triGram[triGram$Uni==textInput[2] &
     triGram$Bi==textInput[3],][1:25,]$Tri)
    if(is.na(wordPrediction50)) {
      wordPrediction50 <- as.character(biGram[biGram$Uni==textInput[3],][1:25,]$Bi)
    }
}
print(wordPrediction50)
}

