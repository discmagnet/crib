library(tidyr)
library(utils)

#Creating a Deck
suits <- rep(c('h','d','s','c'), each =13)
cards <- rep(c('A',2:9, 'T', 'J','Q','K'),4)
deck <- data.frame(cards, suits)
deck <- unite(deck, col = 'card', sep = '')
deck <- as.vector(deck$card)

#Hand
#Where we'll take an input of 5-6 cards from the user depending on how many
# cards they are dealt

full_hand <- c('Ah', 'Ac', '3d', '2d', '6h')



#Going through all the combos of four cards in the hand

hand_combos <- function(hand){
        
        potential_turn_cards <- deck[! deck %in% hand]
        
        
        df <- data.frame(matrix(ncol = 7, nrow = 0))
        colnames(df) <- c('Hand','Minimum', '1st Quartile','Median',
                          '3rd Quartile','Maximum','Mean')
        
        #For a five card hand
        if (length(hand) == 5){
                
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
        
        
        if (length(hand) == 6){
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

