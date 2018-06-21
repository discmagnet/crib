# Cribbage Hand Evaluator

## Collaborators

Kyle Kumbier

Ford Hannum

## Notes

Check out this link. He made a similar algorithm and he lays out the methodology he used.

https://cliambrown.com/cribbage/methodology.php

## *`scored`* function

> The "scored" function calculates the total points in a standard cribbage hand after the player discards. Inputs are the 4 remaining cards in the player's hand and the flipped card. The output is the number of points of the player's hand.

### Determine Points from 15's

Explanation here...

### Determine Points from Pairs

Explanation here...

### Determine Points from Runs



### Determine Presence of Flush

To determine if all the cards in your hand are all the same suit, we test if your first card is the same suit as the rest of your cards using an `if else` statement. If you have a flush and the "flipped" card is also the same suit, you get a bonus point.

```
  if(s1 == s2 & s1 == s3 & s1 == s4){
    if(s1 == s5) flush <- 5 # the "flipped" card is also the same suit
      else flush <- 4 # flush, but no bonus point
  } else flush <- 0
```

### Determine Presence of Knobs

This may be the stupidest rule of the game. If you hold a Jack in your hand and it is the same suit as the "flipped" card, you get a bonus point (knobs). This can be determined with a simple `for` loop and `if else` statement.

```
  for(i in 1:4){
    if(ranks[i] == "J" & suits[i] == suits[5]) knobs <- 1
      else knobs <- 0
  }
```