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

Boy! This was a fun one! There isn't a lot of code for this part, but a lot of work went in on the side. Let's dive in!

The first thing I have to do is obtain the "order" of your cards, e.g. show that a Jack is 1-card lower than a Queen. This was similar to obtaining the "values" of each card for finding 15's.

```
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
```
Once I have the "order" of each card, I can sort them from smallest to biggest. This is done using the `order()` function in R, which returns a permutation that can be used for indexing. For example: `order(c(3,8,4,1,5))` would return `(2,5,3,1,4)`.

```
sorted <- orders[order(orders)]
```
With the cards now arranged in ascending order, I can take the difference between each card. There are 5 cards total, so there will be 4 differences total. The values of these differences are the indicators we need to identify runs. Specifically, we are interested in difference values of '0' and '1'. A difference of '0' indicates a pair; a difference of '1' indicates there is a 1-card increment, creating a run.

### Determine Presence of Flush

To determine if all the cards in your hand are the same suit, we test if your first card is the same suit as the rest of your cards using an `if else` statement. If you have a flush and the "flipped" card is also the same suit, you get a bonus point.

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