scored <- function(hand){
  # ==================================================================================
  # The "scored" function calculates the total points in a standard cribbage hand
  # after the player discards. Inputs are the 4 remaining cards in the player's hand
  # and the flipped card. The output is the number of points of the player's hand.
  
  # Note that cards are entered as follows:
  #   - value of card (A, 2, 3, 4, 5, 6, 7, 8, 9, T, J, Q, K)
  #   - suit of card (h = hearts, d = diamonds, s = spades, c = clubs)
  #   - example = Eight of hearts ~ 8h
  
  library(tidyr)
  library(utils)
  
  # ==================================================================================
  # Determine Ranks and Suits
  r1 <- substr(hand[1],1,1)
  r2 <- substr(hand[2],1,1)
  r3 <- substr(hand[3],1,1)
  r4 <- substr(hand[4],1,1)
  r5 <- substr(hand[5],1,1)
  ranks <- c(r1,r2,r3,r4,r5)
  
  s1 <- substr(hand[1],2,2)
  s2 <- substr(hand[2],2,2)
  s3 <- substr(hand[3],2,2)
  s4 <- substr(hand[4],2,2)
  s5 <- substr(hand[5],2,2)
  suits <- c(s1,s2,s3,s4,s5)
  
  # ==================================================================================
  # Determine Values and Orderings
  value <- function(rank){
    if(rank == "A") value <- 1
    else if (rank == "2") value <- 2
    else if (rank == "3") value <- 3
    else if (rank == "4") value <- 4
    else if (rank == "5") value <- 5
    else if (rank == "6") value <- 6
    else if (rank == "7") value <- 7
    else if (rank == "8") value <- 8
    else if (rank == "9") value <- 9
    else if (rank == "T") value <- 10
    else if (rank == "J") value <- 10
    else if (rank == "Q") value <- 10
    else if (rank == "K") value <- 10
  }
  v1 <- value(r1)
  v2 <- value(r2)
  v3 <- value(r3)
  v4 <- value(r4)
  v5 <- value(r5)
  values <- c(v1,v2,v3,v4,v5)
  
  ordering <- function(rank){
    if(rank == "A") value <- 1
    else if (rank == "2") value <- 2
    else if (rank == "3") value <- 3
    else if (rank == "4") value <- 4
    else if (rank == "5") value <- 5
    else if (rank == "6") value <- 6
    else if (rank == "7") value <- 7
    else if (rank == "8") value <- 8
    else if (rank == "9") value <- 9
    else if (rank == "T") value <- 10
    else if (rank == "J") value <- 11
    else if (rank == "Q") value <- 12
    else if (rank == "K") value <- 13
  }
  o1 <- ordering(r1)
  o2 <- ordering(r2)
  o3 <- ordering(r3)
  o4 <- ordering(r4)
  o5 <- ordering(r5)
  orders <- c(o1,o2,o3,o4,o5)
  
  # ==================================================================================
  # Determine Points from 15's
  fifteens <- 0
  
  for (i in 2:5){
          combos <- combn(values, i)
          sums <- colSums(combos)
          true <- sums == 15
          count <- sum(true, na.rm = TRUE)
          fifteens <- fifteens + count
  }
  # ==================================================================================
  # Determine Points from Pairs
  pair <- 0
  
  combos <- combn(ranks, 2)
  for (i in 1:10){
          if (combos[1,i] == combos[2,i]){
                  pair <- pair + 1
          }
  }
  
  # ==================================================================================
  # Determine Points from Runs (Lengths of 3, 4, and 5)
  run_vector <- c(rep(0,50),3,rep(0,50),3,rep(0,12),6,0,6,6,4,rep(0,59),3,rep(0,7),3,
                  rep(0,16),3,rep(0,15),3,3,rep(0,8),6,0,0,0,6,0,6,0,4,rep(0,4),9,0,
                  12,12,8,0,9,12,8,9,8,8,5)

  sorted <- orders[order(orders)]
  diff <- vector()
  ones <- vector()
  zero <- vector()
  for (i in 1:4){
    diff[i] <- sorted[i+1] - sorted[i]
    ones[i] <- diff[i] == 1
    zero[i] <- diff[i] == 1 | diff[i] == 0 
  }
  runs <- run_vector[sum(2^(which(rev(c(zero,ones)))-1))]
  
  # ==================================================================================
  # Determine Presence of Flush
  #
  # NOTE: Points awarded for a Flush apply to a player's HAND, not the CRIB
  #       All cards need to be the same suit in the CRIB
  #       Might need to include an input in the function making the distinction
  #       between a HAND and the CRIB
  
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
  
  for (i in 1:4){
    if (ranks[i] == "J" & suits[i] == suits[5]){
      knobs <- 1
      } else{
        knobs <- 0
      }
  }
  # ==================================================================================
  # Sum Total Points
  
  points <- 2*fifteens + 2*pair + runs + flush + knobs
  return(points)
}