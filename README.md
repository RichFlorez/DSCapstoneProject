# Coursera Data Science Capstone Project

## Word Prediction App

This is my Coursera Data Science Capstone project repository. The goal of this project was to build a Shiny application that will predict the next word of a short phrase for a mobile device user in order to save time on keystrokes. 

It utilzes the following methods, techniques, and applications:
- NLP (Natural Language Processing)
- Corpus creation
- Tokenization
- N-Grams
- Stupid Back-off Algorithms
- Shiny
- WordCloud
- RPresenter

## Relevant Project Links

Shiny App Link: https://richflorez.shinyapps.io/WordPredApp/

RPresenter Pitch Deck Link: http://rpubs.com/RichFlorez/WordPredApp

RPubs Milestone Report Link: http://rpubs.com/RichFlorez/251813

Personal Website: http://www.richflorez.com

## Notes for Further App Development

Corpus creation did not utilize:
- Stem word removal
- Stop word removal
- Profanity word removal

Stem and stopword removal only netted a modest decrease in the corpus size and therefore did not significantly improve the application's performance in terms of both speed and accuracy. Accuracy seemed to have been greatly affected by these two removal steps.

Instead a small sample of the entire corpus was used, only 1% of the entire data set, and both the stopwords and stemwords were kept inthe sample corpus. This proved to be the best combination of speed and accuracy as tested by data file size and natural spoken language predictions respectively. 

However, it should be noted that the larger corpus sizes tested iteratively in this project, 2%, 2.5% and 3%, did produce better WordCloud vizualizations.
