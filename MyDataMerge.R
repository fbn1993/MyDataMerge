# This script builds the managers dataset
# and populates it with data

# Load data from previous session
column_names <- c("Date", "Country", "Gender", "Age", "Q1", "Q2", "Q3", "Q4", "Q5")

# Enter data into vectors before constructing the data frame
date_col <- c("2018-15-10", "2018-01-11", "2018-21-10", "2018-28-10", "2018-01-05")
country_col <- c("US", "US", "IRL", "IRL", "IRL")
gender_col <- c("M", "F", "F", "M", "F")
age_col <- c(32, 45, 25, 39, 99) # 99 is one of the values in the age attribute - will require recoding
q1_col <- c(5, 3, 3, 3, 2)
q2_col <- c(4, 5, 5, 3, 2)
q3_col <- c(5, 2, 5, 4, 1)
q4_col <- c(5, 5, 5, NA, 2) # NA is inserted in place of the missing data for this attribute
q5_col <- c(5, 5, 2, NA, 1)

# Construct a data frame using the data from all vectors above
managers <- data.frame(date_col, country_col, gender_col, age_col, q1_col, q2_col, q3_col, q4_col, q5_col)

# Add column names to data frame using column_names vector
colnames(managers) <- column_names

# Recode the incorrect 'age' data to NA
managers$Age[managers$Age == 99] <- NA

# Create a new attribute called AgeCat and set valuess
# in AgeCat to the following if true:
# <= 25 = Young
# >= 26 & <= 44 = Middle Aged
# >= 45 = Elderly
# We will also recode age 'NA' to Elder

managers$AgeCat[managers$Age >= 45] <- "Elder"
managers$AgeCat[managers$Age >= 26 & managers$Age <= 44] <- "Middle Aged"
managers$AgeCat[managers$Age <= 25] <- "Young"
managers$AgeCat[is.na(managers$Age)] <- "Elder"

# Recode AgeCat so that is ordinal and factored with the
# order Young, Middle aged, Elder
# We'll srore the ordinal factored data in variable 'AgeCat'
AgeCat <- factor(managers$AgeCat, order = TRUE, levels = c("Young", "Middle Aged", "Elder"))

# Replace managers's AgeCat attribute with newly ordinal foctored data
managers$AgeCat <- AgeCat

# Create a new column called 'summary_col' that
# contains a summary of each row
summary_col <- managers$Q1 + managers$Q2 + managers$Q3 + managers$Q4 + managers$Q5
summary_col

# Add summary_col to the end of the data frame
managers <- data.frame(managers, summary_col)


# Calculate mean value for each row
mean_value <- rowMeans(managers[5:9])

# Add mean_value to end of managers data frame
managers <- data.frame(managers, mean_value)

# Show data frame contents
managers

# Change the name of this column to "mean value"
names(managers)[12] <- "mean value"

# Change name of summary_col to "Answer total"
names(managers)[11] <- "Answer total"

# Show 
str(managers)

new_managers_data <- read.csv(file = "MoreData(1).csv")
str(new_managers_data)

head(managers)
head(new_managers_data)

attach(new_managers_data)
converted_date <- as.Date(Date,"%m/%d/%Y")
converted_date <- format(converted_date,"%d/%m/%Y")
converted_date
detach(new_managers_data)
new_managers_data$Date <- converted_date
head(new_managers_data)

attach(managers)
converted_date <- as.Date(Date, "%Y-%d-%m") 
converted_date <- format(converted_date,"%d/%m/%Y")
converted_date
detach(managers)
managers$Date <- converted_date
head(managers)
names(new_managers_data)
include_list <- subset(new_managers_data, select = c(6, 3, 7, 4, 8:12))
include_list

blank_vectors <- c("AgeCat", "Answer total", "mean value")
include_list[, blank_vectors] <- NA


attach(include_list)
include_list$AgeCat[Age >= 45] <- "Elder"
include_list$AgeCat[Age >= 26 & Age <= 44] <- "Middle Aged"
include_list$AgeCat[Age <= 25] <- "Young"
include_list$AgeCat[is.na(Age)] <- "Elder"
detach(include_list)

# Calculate Answer total
attach(include_list)
include_list$'Answer total' <- Q1 + Q2 + Q3 + Q4 + Q5

# Calculate mean value for each row
include_list$'mean value' <- rowMeans(include_list[5:9])
detach(include_list)


managers
include_list
managers <- rbind(managers, include_list)
managers
#install.packages("dplyr")
#install.packages("tidyverse")
#library(tidyverse)
#new_managers_data2 <- new_managers_data %>% select(6,3,7,4, 8:12) 
#head(managers)
#head(new_managers_data2)
#new_managers_data2$AgeCat <- NA
# new_managers_data2$total <- NA
#new_managers_data2$MeanValue <- NA
#head(new_managers_data2)
#rbind(managers, new_managers_data2)
