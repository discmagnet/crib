library(tidyr)
library(utils)

#Creating a Deck
suits <- rep(c('h','d','s','c'), each =13)
cards <- rep(c('A',2:9, 'T', 'J','Q','K'),4)
deck <- data.frame(cards, suits)
deck <- unite(deck, col = 'card', sep = '')
deck <- as.vector(deck$card)

