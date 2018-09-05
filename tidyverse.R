##################
## Introduction ##
##################
# 1. The tidyverse is a collection of packages that are very 
#    popular among Data Scientists.  These packages focus on 
#    data manipulation and visualization.

# 2. The reason for the popularity of the tidyverse is that there
#    is a common focus on usability and uniformity.

# 3. This different from a lot of the rest of R, because of the 
#    ad hoc nature of package development.

# 4. If you want to do data analysis with R.  I highly recommend
#    you focus your efforts on learning the tidyverse.

# 5. We will use the tidyverse all the time in FM 5990

# 6. To learn more checkout www.tidyverse.org.


#################################
## Installing/Loading Packages ##
#################################
# 1. Let's install and load the packages that we will need.
##> install.packages("readr")
##> install.packages("dplyr")
##> install.packages("ggplot2")



#2. Now let's load these packages so they are available in our 
#   current evironment.
##> library(readr)
##> library(dplyr)
##> library(ggplot2)


###########################
## Reading Data from CSV ##
###########################
# 1. In order to analyze data you need to read it into R from 
#    an external source.

# 2. R allows for many ways to do this, but today we are going
#    to focus on reading from a CSV file, which is a special kind
#    of text file.

# 3. We are going to read in the files using a function in the
#    readr package.
##> options <- readr::read_csv("option_data.csv")


# 4. You'll see some gibberish printed out about column
#    specifications.  Don't worry about this.

# 5. If you look at the environment window you can see a new
#    variable called options.

# 6. This is variable is a dataframe.  Dataframe is the main
#    type of object used for a doing data analysis.

# 7. You can view this dataframe by either printing it to the 
#    console or by using the View() function.
##> options
##> View(options)


# 8. This dataframe constains EOD options prices from 8/16/2013.



############################
## Filtering Data (dplyr) ##
############################
# 1. There are four different underlyings represented in our
#    data set: SPY, QQQ, IWM, DIA.

# 2. Suppose we only want to look at the SPY options, we can
#    use the filter() function from the dplyr package for this.
##> options_spy <- dplyr::filter(options, underlying == "SPY")
##> View(options_spy)



################################
## Visualizing Data (ggplot2) ##
################################
# 1. The tidyverse allows for data visualization through the 
#    ggplot2 package.

# 2. Visualization is complext in nature, so I just want to show
#    you this to demonstrate some what is possible in ggplot2
ggplot(data = options) +
  geom_line(mapping=aes(x=strike,y=implied_vol,color=underlying)) +
  geom_point(mapping=aes(x=strike,y=implied_vol,color=underlying))


