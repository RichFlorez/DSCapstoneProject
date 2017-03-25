## Header
shinyUI(navbarPage("Coursera Data Science Capstone Project", 
  theme = shinytheme("superhero"),
                   
## App Tab
tabPanel("Word Prediction Application",
  fluidRow(
    column(3),
    column(6,
      tags$div(textInput("text", 
        label = h3("Enter Text Here:"),
        value = ),
          p(em(h6("***Two & three word phrases work best***"))),
          tags$hr(),
          h4("Top Predicted Word:"),
          tags$span(style="color:chartreuse",
          tags$strong(tags$h3(textOutput("predictedWord")))),
          tags$hr(),
          h4("Next 5 Predicted Words:"),
          tags$span(style = "color:aquamarine", tags$strong(tags$h5(textOutput("predictedWord2")))),
          tags$span(style = "color:aquamarine", tags$strong(tags$h5(textOutput("predictedWord3")))),
          tags$span(style = "color:aquamarine", tags$strong(tags$h5(textOutput("predictedWord4")))),
          tags$span(style = "color:aquamarine", tags$strong(tags$h5(textOutput("predictedWord5")))),
          tags$span(style = "color:aquamarine", tags$strong(tags$h5(textOutput("predictedWord6")))),
          tags$hr(),
          h4("WordCloud:"),
          plotOutput("wrdcld"),
          align="center")
            ),
            column(3)          
    )
 ), 

## Info Tab 
tabPanel("Product Info",
        fluidRow(
          tags$h4("Instructions:"),
          tags$h6("Simply enter a short (2 or 3 word) phrase of English text and wait for the following results:"),
          tags$h6("1. The most likely next word in your phrase"),
          tags$h6("2. The following 5 most likely words (if avail.)"),
          tags$h6("3. A Top 25 WordCloud of your phrase (if avail.)"),
          tags$hr(),
          tags$h4("Example:"),
          img(src="https://richflorez.github.io/DSCapstoneProject/WrdPredAppEx.png"),
          tags$hr(),
          tags$h4("Resources:"),
          tags$h6(a("GitHub Repository", href="https://github.com/RichFlorez/DSCapstoneProject")),
          tags$h6(a("RPubs Milestone Report", href="http://rpubs.com/RichFlorez/251813")),
          align="center")
            ),
            column(3),

## Footer
hr(),
  tags$h6(a("Created by Rich Florez - 2017", href="http://www.richflorez.com"))
))

