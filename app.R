library(shiny)
library(tidyr)
library(utils)
library(dplyr)
source('https://raw.githubusercontent.com/discmagnet/crib/master/scored.R')
source('https://raw.githubusercontent.com/discmagnet/crib/master/algorithm.R')

# Creating the 52-Card Deck
suits <- rep(c('h','d','s','c'), each =13)
cards <- rep(c('A',2:9, 'T', 'J','Q','K'),4)
deck <- data.frame(cards, suits)
deck <- unite(deck, col = "card", c(cards,suits), sep = "")

ui <- fluidPage(
  
  titlePanel("Cribbage Hand Evaluator"),
  sidebarLayout(
    sidebarPanel(
      radioButtons(inputId = "r1",
                  label = "Card 1 Rank",
                  choices = c("A","2","3","4","5","6","7","8","9","10" = "T","J","Q","K"),
                  inline = TRUE,
                  selected = character(0)
                  ),
      radioButtons(inputId = "s1",
                  label = "Card 1 Suit",
                  choices = c("Club"="c","Spade" = "s","Heart" = "h","Diamond" = "d"),
                  inline = TRUE,
                  selected = character(0)
                  ),
      radioButtons(inputId = "r2",
                  label = "Card 2 Rank",
                  choices = c("A","2","3","4","5","6","7","8","9","10" = "T","J","Q","K"),
                  inline = TRUE,
                  selected = character(0)
                  ),
      radioButtons(inputId = "s2",
                  label = "Card 2 Suit",
                  choices = c("Club"="c","Spade" = "s","Heart" = "h","Diamond" = "d"),
                  inline = TRUE,
                  selected = character(0)
                  ),
      radioButtons(inputId = "r3",
                  label = "Card 3 Rank",
                  choices = c("A","2","3","4","5","6","7","8","9","10" = "T","J","Q","K"),
                  inline = TRUE,
                  selected = character(0)
                  ),
      radioButtons(inputId = "s3",
                  label = "Card 3 Suit",
                  choices = c("Club"="c","Spade" = "s","Heart" = "h","Diamond" = "d"),
                  inline = TRUE,
                  selected = character(0)
                  ),
      radioButtons(inputId = "r4",
                  label = "Card 4 Rank",
                  choices = c("A","2","3","4","5","6","7","8","9","10" = "T","J","Q","K"),
                  inline = TRUE,
                  selected = character(0)
                  ),
      radioButtons(inputId = "s4",
                  label = "Card 4 Suit",
                  choices = c("Club"="c","Spade" = "s","Heart" = "h","Diamond" = "d"),
                  inline = TRUE,
                  selected = character(0)
                  ),
      radioButtons(inputId = "r5",
                  label = "Card 5 Rank",
                  choices = c("A","2","3","4","5","6","7","8","9","10" = "T","J","Q","K"),
                  inline = TRUE,
                  selected = character(0)
                  ),
      radioButtons(inputId = "s5",
                  label = "Card 5 Suit",
                  choices = c("Club"="c","Spade" = "s","Heart" = "h","Diamond" = "d"),
                  inline = TRUE,
                  selected = character(0)
                  ),
      radioButtons(inputId = "r6",
                  label = "Card 6 Rank (if applicable)",
                  choices = c("N/A"="","A","2","3","4","5","6","7","8","9","10" = "T","J","Q","K"),
                  inline = TRUE
                  ),
      radioButtons(inputId = "s6",
                  label = "Card 6 Suit (if applicable)",
                  choices = c("N/A"="","Club"="c","Spade" = "s","Heart" = "h","Diamond" = "d"),
                  inline = TRUE
                  )
    ),
    mainPanel(
      tableOutput("eval")
    )
  )
)

server <- function(input, output){
  
    card1 <- reactive({paste(input$r1,input$s1,sep = "")})
    card2 <- reactive({paste(input$r2,input$s2,sep = "")})
    card3 <- reactive({paste(input$r3,input$s3,sep = "")})
    card4 <- reactive({paste(input$r4,input$s4,sep = "")})
    card5 <- reactive({paste(input$r5,input$s5,sep = "")})
    card6 <- reactive({paste(input$r6,input$s6,sep = "")})
    full_hand <- reactive({c(card1(),card2(),card3(),card4(),card5(),card6())})
    hand_out <- reactive({algorithm(full_hand())})
    output$eval <- renderTable(hand_out())
    
}

shinyApp(ui = ui, server = server)