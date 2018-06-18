library(tidyr)
library(utils)

# Creating the 52-Card Deck
suits <- rep(c('h','d','s','c'), each =13)
cards <- rep(c('A',2:9, 'T', 'J','Q','K'),4)
deck <- data.frame(cards, suits)
deck <- unite(deck, col = "card", c(cards,suits), sep = "")

# 5- or 6-Card Hand Inputted by the Player

full_hand <- c('Ah', 'Ac', '3d', '2d', '6h')

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
    scores <- list()
    for(j in 1:47){
      flipped <- turn_cards[j]
      count_hand <- c(hand, flipped)
      hand_score <- scored(count_hand)
      scores[j] <- hand_score
    }
    hand_eval[i,] <- c(paste(hand, collapse = ","), round(mean(scores),1), fivenum(scores)) 
  }
}



#Going through all the combos of four cards in the hand

hand_combos <- function(full_hand){
        

        
        #For a five card hand
        if (length(full_hand) == 5){
                
                for (i in 1:5){
                        
                        hand <- full_hand[-i]
                        
                        scores <- list()
                        
                        for (j in 1:47){
                                turn_card <- potential_turn_cards[j]
                                turn_hand <- c(hand, turn_card)
                                hand_score <- scored(turn_hand)
                                scores[j] <- hand_score
                        }
                        
                   row <- c(paste(hand, collapse = ','), fivenum(scores), 
                            round(mean(scores),1))     
                   
                   df[i,] <- row  
                }
        }
        
        
        if (length(full_hand) == 6){
                for (i in 1:15){
                        
                        hand <- combn(hand,4)[,i]
                        
                        scores <- list()
                        
                        for (j in 1:46){
                                turn_card <- potential_turn_cards[j]
                                
                                turn_hand <- c(hand, turn_card)
                                
                                hand_score <- scored(turn_hand)
                                
                                scores[j] <- hand_score
                        }
                        
                        row <- c(paste(hand, collapse = ','), fivenum(scores), 
                                 round(mean(scores),1))     
                        
                        df[i,] <- row  
                }
        }
}

