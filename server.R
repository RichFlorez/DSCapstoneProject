biGram <-  readRDS(file = "./biGram.rds")
triGram <-  readRDS(file = "./triGram.rds")
quadGram <-  readRDS(file = "./quadGram.rds")

shinyServer(function(input, output, session) {

  wordPrediction <- reactive({
    text <- input$text
    textInput <- cleanInput(text)
    wordCount <- length(textInput)
    wordPrediction <- nextWordPrediction(wordCount,textInput)})
    output$predictedWord <- renderPrint(wordPrediction())

  wordPrediction10 <- reactive({
    text <- input$text
    textInput <- cleanInput(text)
    wordCount <- length(textInput)
    wordPrediction10 <- nextWordPrediction10(wordCount,textInput)})
    output$predictedWord2 <- renderPrint(cat(wordPrediction10()[2]))
    output$predictedWord3 <- renderPrint(cat(wordPrediction10()[3]))
    output$predictedWord4 <- renderPrint(cat(wordPrediction10()[4]))
    output$predictedWord5 <- renderPrint(cat(wordPrediction10()[5]))
    output$predictedWord6 <- renderPrint(cat(wordPrediction10()[6]))

  wordPrediction50 <- reactive({
    text <- input$text
    textInput <- cleanInput(text)
    wordCount <- length(textInput)
    wordPrediction50 <- nextWordPrediction50(wordCount,textInput)})
    output$predictedWord50 <- renderPrint(cat(wordPrediction50()[1:25]))
    
  wordcloud_rep <- repeatable(wordcloud)
  
  output$wrdcld <- renderPlot({
    v <- table(wordPrediction50()[1:25])
    wordcloud_rep(names(v), v, scale=c(2,0.5), 
      min.freq = 1, max.words=Inf, random.color=TRUE, rot.per=.2,
      colors=brewer.pal(8, "Dark2"))
  })
})  

