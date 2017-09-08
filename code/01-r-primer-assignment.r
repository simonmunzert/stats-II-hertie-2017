# ************************************************
### simon munzert
### introduction to R
# ************************************************

source("packages.r")
source("functions.r")

# **************************
# ASSIGNMENT ---------------

## 1: Private study ----------
# a) Work through the file "01-r-primer-vectors.r" to learn how vectors work in R!
 
## 2: Working with vectors ---
# a) Create a vector x with elements [0,4,8,12,16,20].
# b) Create a vector y with elements [3,3,3,4,4,4,4,5,5,5,5,5].
# c) Combine the first five elements of x with elements 2 to 12 of vector y to create a new vector z.
# d) What's the sum of all numbers between 1 and 100? Use the functions you learned in the vectors script to compute it!
# e) What's the sum of all odd numbers between 1 and 100 squared?

## 3: Working with data frames ---
# a) Inspect the "babynames" package! What data does it contain? Focus on the babynames data frame in the following.
# b) Which time period does the data frame cover?
# c) What has been the most frequent name in the US since 1880? (hint: you might need the group_by() as well as the sum())
# d) Use graphical means to determine since which year the name "Kim" became more popular as a female than a male name! (hint: grouping by two variables is helpful here! For the plot, use "year" on the x axis and "total count" on the y axis! Furthermore, this Stackoverflow post helps you understand how to plot two lines in one chart: https://stackoverflow.com/questions/2564258/plot-two-graphs-in-same-plot-in-r)
