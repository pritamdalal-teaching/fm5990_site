#########################
## Using this Tutorial ##
#########################
# 1. Start a new R session.

# 2. Create a new R script file via File > New File > R Script. 

# 3. Go to the Tutorials section of the course website.  Copy the
#    contents of "04 Dataframe Slicing" and paste it into the file
#    you just created.

# 4. Pritam will have guided you verbally to this point.  Now complete
#    steps 5-8.

# 5. Create a folder called dataframe-slicing on your Desktop. 

# 6. Save the current R script as dataframe-slicing.R in the folder
#    called dataframe-slicing that you created on your Desktop in 
#    step 5.

# 7. Wait for further instructions.



##################
## Getting Data ##
##################
# 1. Change the working directory in your R session to the dataframe-
#    slicing folder on your Desktop.
##> setwd("your folder path here")


# 2. Go to the Data section of course website and click the link that
#    Options Intro.  This will start a download of a file called
#    data_options_intro.csv.

# 3. Save data_options_intro.csv into the the folder on your desktop
#    called dataframe-slicing.




#####################################
## Installing and Loading Packages ##
#####################################
# 1. For this tutorial we are going to be using the two packages 
#    from the tidyverse: dplyr and readr.


# 2. If you still don't have them, install them now.
##> install.packages("dplyr") 
##> install.packages("readr")


# 3. Now let's load the packages so that we can use them.
##> library(dplyr)
##> library(readr)



#############################
## Reading Data from a CSV ##
#############################
# 1. Let's read in the options data that's in our working directory.
##> df_options <- readr::read_csv("data_options_intro.csv")


# 2. We can use the nrow() function to see how many rows are in 
#    df_options.
##> nrow(df_options)



################################################
## Subsetting by Row Number and Column Number ##
################################################
# 1. Let's take a look at df_options both in the console and also 
#    using the View() function.
##> df_options
##> View(df_options)



# 2. A dataframe is simply a set of rows of data, and simulta-
#    neously, collections of columns.



# 3. At any given time, each row has a number associated with it.
#    And each number has a column associated with it.



# 4. We can access the data in a dataframe using these rows and 
#    column number.  The syntax is dataframe[row_num, col_num].
##> df_options[1, 1]
##> df_options[3, 6]



# 5. You can assign these values to variables if you want.
##> first_trade_date <- df_options[1, 1]
##> third_strike <- df_options[3, 6]



# 6. You can grab an entire row by omitting a column number.  The 
#    following code grabs the entire third row.
##> df_options[3, ]
##> third_row <- df_options[3, ]



# 7. You can grab an entire column by ommitting a row number.  The
#    following code grabs the entire sixth column
##> df_options[ ,6] 
##> sixth_column <- df_options[ ,6]



# 8. Exercise: Try the following code for yourself and describe in 
#    words what happens.
##> df_options[1:3, ]
##> df_options[ , 1:3]



# 8. Exercise: Try the following code for yourself and describe in 
#    words what happens.
##> df_options[c(1,3,5), ]
##> df_options[, c(1,3,5)]




################################## 
##  $-notation aka "cash-money" ##
##################################
# 1. It is often useful to refer to columns of a dataframe by
#    their names.


# 2. This is where cash-money notation comes in handy.
##> df_options$strike
##> df_options$implied_vol



# 3. A bit of R nerdery:  The objects that get returned with cash-
#    money notation are vectors.  A dataframe is a "list" of
#    vectors all of the same length.


# 4. Exercise: What kind of object do you get back when you use
#    the [,] notation on the dataframe df_options?



##########################
## Self-Study Materials ##
##########################
# 1. I think the best way to learn about how to utilize this slicing
#    is to practice doing data analysis that you care about.
#    However, if you want to dig into the details a bit more, here
#    are a couple of resources (they are a bit advanced).


# 2. Advanced R by Hadley Wickham
#    https://adv-r.hadley.nz/ 
#    Chapters 4-5


# 3. Jenny Bryan's Purr Tutorial 
#    https://jennybc.github.io/purrr-tutorial/
#    Vectors and Lists