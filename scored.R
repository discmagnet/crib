library(tidyr)
suits <- rep(c('h','d','s','c'), each =13)
cards <- rep(c('A',2:9, 'T', 'J','Q','K'),4)
deck <- data.frame(cards, suits)
deck <- unite(deck, col = 'card', sep = '')
deck <- as.vector(deck$card)

scored <- function(c1,c2,c3,c4,c5){
  # ==================================================================================
  # The "scored" function calculates the total points in a standard cribbage hand
  # after the player discards. Inputs are the 4 remaining cards in the player's hand
  # and the flipped card. The output is the number of points of the player's hand.
  
  # Note that cards are entered as follows:
  #   - value of card (A, 2, 3, 4, 5, 6, 7, 8, 9, T, J, Q, K)
  #   - suit of card (h = hearts, d = diamonds, s = spades, c = clubs)
  #   - example = Eight of hearts ~ 8h
  
  # ==================================================================================
  # Determine Ranks
  r1 <- substr(c1,1,1)
  r2 <- substr(c2,1,1)
  r3 <- substr(c3,1,1)
  r4 <- substr(c4,1,1)
  r5 <- substr(c5,1,1)
  
  # ==================================================================================
  # Determine Values
  value <- function(rank){
    if(rank == "a") value <- 1
    else if (rank == "2") value <- 2
    else if (rank == "3") value <- 3
    else if (rank == "4") value <- 4
    else if (rank == "5") value <- 5
    else if (rank == "6") value <- 6
    else if (rank == "7") value <- 7
    else if (rank == "8") value <- 8
    else if (rank == "9") value <- 9
    else if (rank == "t") value <- 10
    else if (rank == "j") value <- 10
    else if (rank == "q") value <- 10
    else if (rank == "k") value <- 10
  }
  v1 <- value(r1)
  v2 <- value(r2)
  v3 <- value(r3)
  v4 <- value(r4)
  v5 <- value(r5)
  
  # ==================================================================================
  # Initialize Points to Zero
  points <- 0
  
  # ==================================================================================
  # Determine Points from 15's
  fifteens <- 0
  
  # ==================================================================================
  # Determine Points from Pairs
  pair <- 0
  
  # ==================================================================================
  # Determine Points from Runs (Lengths of 3, 4, and 5)
  runs <- 0
  
  # ==================================================================================
  # Determine Suits
  s1 <- substr(c1,2,2)
  s2 <- substr(c2,2,2)
  s3 <- substr(c3,2,2)
  s4 <- substr(c4,2,2)
  s5 <- substr(c5,2,2)
  
  # ==================================================================================
  # Determine Presence of Flush
  flush <- 0
  if(s1 == s2 & s1 == s3 & s1 == s4){
    if(s1 == s5){
      flush <- 5
    } else{
      flush <- 4
    }
  } else{
    flush <- 0
  }
  # ==================================================================================
  # Determine Presence of Knobs
  knobs <- 0
  
  # ==================================================================================
  # Sum Total Points
  points <- points + fifteens + pair + runs + flush + knobs
  return(points)
}
