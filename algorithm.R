library(tidyr)
library(utils)

# Creating the 52-Card Deck
suits <- rep(c('h','d','s','c'), each =13)
cards <- rep(c('A',2:9, 'T', 'J','Q','K'),4)
deck <- data.frame(cards, suits)
deck <- unite(deck, col = "card", c(cards,suits), sep = "")

# 5- or 6-Card Hand Inputted by the Player

full_hand <- c('Ah', 'Ac', '3d', '2d', '6h', '6s')

turn_cards <- vector()
for (i in 1:52){
  if (!(deck[i,] %in% full_hand)){
    turn_cards <- c(turn_cards, deck[i,])
  }
}

# For 5-Card Hands

hand_eval <- data.frame(matrix(ncol = 8, nrow = 0))
colnames(hand_eval) <- c("Hand","Discard","Average","Minimum",
                         "Q1","Median","Q3","Maximum")

if(length(full_hand) == 5){
  for(i in 1:5){
    hand <- full_hand[-i]
    discard <- full_hand[i]
    scores <- vector()
    for(j in 1:47){
      flipped <- turn_cards[j]
      count_hand <- c(hand, flipped)
      hand_score <- scored(count_hand)
      scores[j] <- hand_score
    }
    hand_eval[i,1] <- paste(hand, collapse = ", ")
    hand_eval[i,2] <- discard
    hand_eval[i,3] <- round(mean(scores),2)
    hand_eval[i,4] <- fivenum(scores)[[1]]
    hand_eval[i,5] <- fivenum(scores)[[2]]
    hand_eval[i,6] <- fivenum(scores)[[3]]
    hand_eval[i,7] <- fivenum(scores)[[4]]
    hand_eval[i,8] <- fivenum(scores)[[5]]
    hand_out <- arrange(hand_eval,desc(Average))
  }
}

# For 6-Card Hands

if(length(full_hand == 6)){
  for (i in 1:15){
    hand <- combn(full_hand,4)[,i]
    discard <- vector()
    for (k in 1:6){
      if (!(full_hand[k] %in% hand)){
        discard <- c(discard, full_hand[k])
      }
    }
    scores <- vector()
    for(j in 1:46){
      flipped <- turn_cards[j]
      count_hand <- c(hand, flipped)
      hand_score <- scored(count_hand)
      scores[j] <- hand_score
    }
    hand_eval[i,1] <- paste(hand, collapse = ", ")
    hand_eval[i,2] <- paste(discard, collapse = ", ")
    hand_eval[i,3] <- round(mean(scores),2)
    hand_eval[i,4] <- fivenum(scores)[[1]]
    hand_eval[i,5] <- fivenum(scores)[[2]]
    hand_eval[i,6] <- fivenum(scores)[[3]]
    hand_eval[i,7] <- fivenum(scores)[[4]]
    hand_eval[i,8] <- fivenum(scores)[[5]]
    hand_out <- arrange(hand_eval,desc(Average))
  }
}