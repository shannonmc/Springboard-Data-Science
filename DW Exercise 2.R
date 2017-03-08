#0: Load the data in RStudio ==================================================================================

library(readr)
titanic_original <- read_csv("~/Springboard Data Science/UNIT 3/Data Wrangling Exercise 2 Dealing with missing values/titanic_original.csv")
View(titanic_original)

library(dplyr)
library(tidyr)

titanic <- data.frame(titanic_original)

# 1: Port of embarkation =====================================================================================

titanic$embarked[is.na(titanic$embarked)] <- "S"

# 2: Age =====================================================================================================

mean_age <- mean(titanic$age, na.rm = TRUE)

# other ways to populate missing values
median_age <- median(titanic$age, na.rm = TRUE)
sd_age <- sd(titanic$age, na.rm = TRUE)

# mean_age is 29.8813
# median_age is 29.8813
# sd_age is 12.87828
# mean and/or median would be the more appropriate values in this case since there likely would not be as many 12 year olds

titanic$age[is.na(titanic$age)] <- mean_age

# 3: Lifeboat ================================================================================================

titanic$boat[is.na(titanic$boat)] <- "None"

# 4: Cabin ===================================================================================================

c <- !is.na(titanic$cabin)
titanic$has_cabin_number <- as.numeric(c)


# 5: Submit the project on Github  ===========================================================================

titanic_clean <- write.csv(titanic, "~/Springboard Data Science/UNIT 3/Data Wrangling Exercise 2 Dealing with missing values/titanic_clean.csv")
