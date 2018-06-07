scored <- function(card1,card2,card3,card4,flipped){
  # ==================================================================================
  # The "scored" function calculates the total points in a standard cribbage hand
  # after the player discards. Inputs are the 4 remaining cards in the player's hand
  # and the flipped card. The output is the number of points of the player's hand.
  
  # Note that cards are entered as follows:
  #   - value of card (A, 2, 3, 4, 5, 6, 7, 8, 9, T, J, Q, K)
  #   - suit of card (h = hearts, d = diamonds, s = spades, c = clubs)
  #   - example = Eight of hearts ~ 8h
  
  # ==================================================================================
  # Initialize Points to Zero
  points <- 0
  
  # ==================================================================================
  # STEP 1: Determine Points from 15's
  fifteens <- 0
  
  # ==================================================================================
  # STEP 2: Determine Points from Pairs
  pair <- 0
  
  # ==================================================================================
  # STEP 3: Determine Points from Runs (Lengths of 3, 4, and 5)
  runs <- 0
  
  # ==================================================================================
  # STEP 4:
  suit1 <- substr(as.character(card1),2,2)
  
  # ==================================================================================
  # STEP 5: Determine Presence of Flush
  flush <- 0
  
  # ==================================================================================
  # STEP 6: Determine Presence of Knobs
  knobs <- 0
  
  points <- points + fifteens + pair + runs + flush + knobs
  return(suit1)
}