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

Once I have the "values" of all the cards (e.g. all face cards worth 10),

```
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
```
I can determine the 10 two-card, 10 three-card, 5 four-card, and 1 five-card combinations utilizing a `for` loop and the `combn()` function. Then, I can count the number of combinations where the sum of the values is 15.

```
for (i in 2:5){
  combos <- combn(values, i)
  sums <- colSums(combos)
  true <- sums == 15
  count <- sum(true, na.rm = TRUE)
  fifteens <- fifteens + count
}
```

### Determine Points from Pairs

In a similar manner, to determine the number of pairs, I also use the `combn()` function. This time I count the number of times the "ranks" are the same among the 10 different two-card combinations.

```
combos <- combn(ranks, 2)
for (i in 1:10){
  if (combos[1,i] == combos[2,i]) pair <- pair + 1
}
```

### Determine Points from Runs

There isn't as much code as you would expect for this part, but A LOT of work went in on the side.

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
With the cards now arranged in ascending order, I can take the difference between each card. There are 5 cards total, so there will be 4 differences total. The values of these differences are the indicators we need to identify runs. Specifically, we are interested in difference values of '0' and '1'. A difference of '0' indicates a pair; a difference of '1' indicates there is a 1-card increment, creating a run. Since I don't care about values greater than '1', I create two logical vectors. The first, `ones`, detects whether the difference is '1'. The second, `zero`, detects whether the difference is '1' *or* '0'.

```
diff <- vector()
ones <- vector()
zero <- vector()
for (i in 1:4){
  diff[i] <- sorted[i+1] - sorted[i]
  ones[i] <- diff[i] == 1
  zero[i] <- diff[i] == 1 | diff[i] == 0 
}
```

Now here's the cool part. If I merge `zero` and `ones` together and change `TRUE` to '1' and `FALSE` to '0', I now have an 8-bit binary number. Long story short, **this binary number can be converted to an integer which can be used to index a vector that returns the points from runs in your hand**.

It would be an understatement to say there are many ways you could make a run, but fortunately, there are only 26 unique ways you can get points from a run according to these unique 8-bit binary identifiers. Don't believe me?! Here they all are:

#### Single Run of 3 *(3 pts)*

Run No. | Card Example   | diff | ones | zero | Binary Code | Index
-------:|:--------------:|:----:|:----:|:----:|:-----------:|:-----
   1    | 3, 3, 6, 7, 8  | 0311 | 0011 | 1011 |  10110011   |  179
   2    | 3, 4, 6, 7, 8  | 1211 | 1011 | 1011 |  10111011   |  187
   3    | 2, 4, 6, 7, 8  | 2211 | 0011 | 0011 |  00110011   |  51
   4    | 3, 6, 7, 8, J  | 3113 | 0110 | 0110 |  01100110   |  102
   5    | 6, 7, 8, J, J  | 1130 | 1100 | 1101 |  11011100   |  220
   6    | 6, 7, 8, J, Q  | 1131 | 1101 | 1101 |  11011101   |  221
   7    | 6, 7, 8, J, K  | 1132 | 1100 | 1100 |  11001100   |  204
   
#### Double Run of 3 *(6 pts)*

Run No. | Card Example   | diff | ones | zero | Binary Code | Index
-------:|:--------------:|:----:|:----:|:----:|:-----------:|:-----
   8    | 3, 6, 6, 7, 8  | 3011 | 0011 | 0111 |  01110011   |  115
   9    | 3, 6, 7, 7, 8  | 3101 | 0101 | 0111 |  01110101   |  117
   10   | 3, 6, 7, 8, 8  | 3110 | 0110 | 0111 |  01110110   |  118
   11   | 6, 6, 7, 8, J  | 0113 | 0110 | 1110 |  11100110   |  230
   12   | 6, 7, 7, 8, J  | 1013 | 1010 | 1110 |  11101010   |  234
   13   | 6, 7, 8, 8, J  | 1103 | 1100 | 1110 |  11101100   |  236

#### Double-Double Run of 3 *(12 pts)*

Run No. | Card Example   | diff | ones | zero | Binary Code | Index
-------:|:--------------:|:----:|:----:|:----:|:-----------:|:-----
   14   | 6, 6, 7, 7, 8  | 0101 | 0101 | 1111 |  11110101   |  245
   15   | 6, 6, 7, 8, 8  | 0110 | 0110 | 1111 |  11110110   |  246
   16   | 6, 7, 7, 8, 8  | 1010 | 1010 | 1111 |  11111010   |  250

#### Triple Run of 3 *(9 pts)*

Run No. | Card Example   | diff | ones | zero | Binary Code | Index
-------:|:--------------:|:----:|:----:|:----:|:-----------:|:-----
   17   | 6, 6, 6, 7, 8  | 0011 | 0011 | 1111 |  11110011   |  243
   18   | 6, 7, 7, 7, 8  | 1001 | 1001 | 1111 |  11111001   |  249
   19   | 6, 7, 8, 8, 8  | 1100 | 1100 | 1111 |  11111100   |  252

#### Single Run of 4 *(4 pts)*

Run No. | Card Example   | diff | ones | zero | Binary Code | Index
-------:|:--------------:|:----:|:----:|:----:|:-----------:|:-----
   20   | 3, 6, 7, 8, 9  | 3111 | 0111 | 0111 |  01110111   |  119
   21   | 6, 7, 8, 9, Q  | 1113 | 1110 | 1110 |  11101110   |  238

#### Double Run of 4 *(8 pts)*

Run No. | Card Example   | diff | ones | zero | Binary Code | Index
-------:|:--------------:|:----:|:----:|:----:|:-----------:|:-----
   22   | 6, 6, 7, 8, 9  | 0111 | 0111 | 1111 |  11110111   |  247
   23   | 6, 7, 7, 8, 9  | 1011 | 1011 | 1111 |  11111011   |  251
   24   | 6, 7, 8, 8, 9  | 1101 | 1101 | 1111 |  11111101   |  253
   25   | 6, 7, 8, 9, 9  | 1110 | 1110 | 1111 |  11111110   |  254

#### Single Run of 5 *(5 pts)*

Run No. | Card Example   | diff | ones | zero | Binary Code | Index
-------:|:--------------:|:----:|:----:|:----:|:-----------:|:-----
   26   | 5, 6, 7, 8, 9  | 1111 | 1111 | 1111 |  11111111   |  255

The following line of code populates the run vector. The correct point values are assigned to their respective indices. 

```
run_vector <- c(rep(0,51),3,rep(0,50),3,rep(0,12),6,0,6,6,4,rep(0,59),3,rep(0,7),3,rep(0,16),3,rep(0,15),3,3,rep(0,8),6,0,0,0,6,0,6,0,4,rep(0,4),9,0,12,12,8,0,9,12,8,9,8,8,5)
```

This final line of code retrieves the correct point value bases on your particular hand.

```
runs <- run_vector[sum(2^(which(rev(c(zero,ones)))-1))+1]
```

[A] `c(zero,ones)` is the Binary Code of your hand.

[B] `rev(A)` reverses the order of the Binary Code, the first step to convert from Binary to Decimal.

[C] `which(B)` returns the indices of where the reversed Binary Code contained 1's.

[D] `sum(2^(C-1))+1` finishes the computation.

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