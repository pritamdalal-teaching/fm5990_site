##############################
## How to use this Tutorial ##
##############################
# 1. Open this .R file in a new RStudio session and save it on your
#    Desktop.

# 2. Use the setwd() function to change the working directory of 
#    your RStudio session your Desktop.

# 3. Go to the Data section of the class website and download the 
#    data set called OCC Volume Report.  Save data_occ_201808.csv
#    your Desktop. 


#############
## Context ##
#############
# 1. Liquidity is an important concept in finance and trading.

# 2. We say that an instrument is liquid when two conditions are met:
#    - bid-ask spreads are narrow
#    - large quantities can be traded without moving the price

# 3. These two conditions are usually met when there is large daily
#    trading volume.

# 4. Today we are going to perform an analysis on data that is 
#    published by the OCC.

# 5. The question that we are trying to answer is: which underlyings
#    have the highest options trading volumes?

# 6. Along the way we are going to use a variety of the data 
#    manipulation functions of the dplyr package from the tidyverse.


#####################
## Reading In Data ##
#####################
# 1. First let's load readr and dplyr packages.
##> library(dplyr)
##> library(readr)


# 2. Next let's read in the OCC volume data into a dataframe.
##> df_occ <- readr::read_csv("data_occ_201808.csv")


# 3. Let's view this dataframe by printing in two ways.
##> df_occ
##> View(df_occ)


# 4. Exercise: How many rows and columns does df_occ have.


# 5. Exercise: Let's take a crack at guessing what each of the
#              columns means.


# 6. This is total option volume data published by the OCC for 
#    August 2018.  This is the data we want but we need to manipulate,
#    filter, and aggregate it in various ways.



################################
## Refactoring actdate Column ##
################################
# 4. One thing that we can notice is that the actdate was read in as 
#    a <chr>, rather than a <date>.
##> class(df_occ$actdate)


# 5. We can modify this by using the as.Date() function.  There are a
#    variety of as.*() function that you may have to use from time-to-
#    time.  Changing one data type to another data type is a very
#    common task in programming, so all languages will have function-
#    ality like this.


# 6. As a preliminary step, let's see what happens when we apply the 
#    as.Date() function to the first element of df_occ$actdate.
##> df_occ$actdate[1]
##> as.Date(df_occ$actdate[1], "%m/%d/%Y")
##> class(as.Date(df_occ$actdate[1], "%m/%d/%Y"))


# 7. The second argument of the as.Date() function tells R how to
#    interpret the characters as a date.  Don't worry about it too 
#    much, just copy what I do.  You can read more about it in the 
#    online documentation for as.Date().


# 8. What do you think will happen if we apply as.Date() to the 
#    entire column df_occ$actdate?
##> as.Date(df_occ$actdate, "%m/%d/%Y")


# 9. We can now change the refactor the entire column with the 
#    following code.
##> df_occ$actdate <- as.Date(df_occ$actdate, "%m/%d/%Y")



# 10. If we print our dataframe to the console we can now see that 
#     actdate is now a <date> column instead of a <chr> column.
##> df_occ 
##> class(df_occ$actdate)




##################################
## Checking Which Dates We Have ##
##################################
# 1. What we are suppose to have is a report consisting of just
#    August.  Let's make sure this is the case by using
#    dplyr::distinct.
##> dplyr::distinct(df_occ, actdate)
##> min(dplyr::distinct(df_occ, actdate)$actdate)
##> max(dplyr::distinct(df_occ, actdate)$actdate)  




# 2. From the above tests we can really only determine that there
#    aren't any days outside of the month of August 208 in this data.
#    If you want to be more exact, you can use the bizdays package
#    and make sure that all the trade dates are represented in the
#    OCC report.


# 3. Challenge: How can we check how many underlyings are represented
#               in the data set.



##############################
## Grouping and Summarizing ##
##############################
# 1. Let's take a look at our full report again.
##> df_occ


# 2. This data is actually far more granular than we need.  It is 
#    broken up by exchange, account type, puts/calls, and trade date.


# 3. We really only care about total volume, over the entire month, 
#    for each underlying.


# 4. In order to get what we want, let's first group our data by 
#    underlying using the dplyr::group_by().
##> df_occ_grouped <- dplyr::group_by(df_occ, underlying)



# 5. If we print both df_occ and df_occ_grouped to the console, 
#    they look very similar except the latter has "Groups: ..."
#    printed.  It is a grouped dataframe.
##> df_occ_grouped


# 7. Nothing special really happens with a grouped dataframe until
#    we use a dplyr:summarize().
##> dplyr::summarize(df_occ_grouped, volume = sum(quantity))


# 8. This is ultimately the monthly volume report that we want, but
#    we'll spruce it up a bit.


# 9. However, before we do that, let's notice that in order to come
#    up with this report we first created and intermediate variable
#    called df_occ_grouped.  For a simple query like this, it's not
#    such a big deal, but creating intermediate variables will be
#    cumbersome in more complex situations.  So we'll introduce the 
#    pipe operator to get around this.


# 10. In order to use the pipe operator we will need to install and
#     load the magrittr package.
##> install.packages("magrittr")
##> library(magrittr)


# 11. Here is how we can rewrite the work we did above with the 
#     pipe operator.
##> df_occ %>% group_by(underlying) %>% summarize(volume=sum(quantity))


# 12. The keyboard shortcut for the pipe operator is:
#     shift + ctrl/cmd + M. Practice it a few times.
##> # %>% %>% %>% %>% %>% %>% %>% 




#########################
## Reordering the Rows ##
#########################
# 1. Let's add a dplyr::arrange() function to order the rows by 
#    volume so that the underlyings with the most trading are at the
#    top of the list
##> df_occ %>%  group_by(underlying) %>% 
##>             summarize(monthly_volume = sum(quantity)) %>% 
##>             arrange(desc(monthly_volume))




#####################################
## Let's Add A Daily Volume Column ##
#####################################
# 1. Challenge:  It's often more useful to look at average daily 
#                trading volume rather than total monthly volume.
#                Why??? 


# 2. We will add a daily_volume column using the dplyr::mutate() 
#    function.


# 2. Challenge: There were 23 trading days in August 2018.  
#               How can you confirm this with the report we have?


# 3. Now let's use a mutate function to add a daily_volume row.
##> df_occ %>% group_by(underlying) %>% 
##>            summarize(monthly_volume = sum(quantity)) %>%
##>            mutate(daily_volume = volume/23) %>% 
##>            arrange(desc(monthly_volume))



##################################
## Viewing A Subset of the Data ##
##################################
# 1. Challenge: Add a dplyr::filter() statement so that the report 
#               only includes SPY, QQQ, IWM, DIA.


# 2. Challenge: Add a dplyr::select() statement so that the report 
#               only includes underlying and daily_volume.


# 3. Challenge: Add a dplyr::top_n() statement to select the top 100 
#               most traded underlyings.

