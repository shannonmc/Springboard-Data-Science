# 0: Load the data in RStudio

library(readr)
refine_original <- read_csv("~/Springboard Data Science/UNIT 3/Data Wrangling Exercise 1 Basic Data Manipulation/refine_original.csv")
View(refine_original)
library(dplyr)
library(tidyr)

refine <- data.frame(refine_original)

# 1: Clean up brand names

## define functions

remove_space <- function(s) {gsub(pattern = " ", s, replace = "")}

revise_names <- function(name, matches, correct_name){
  namePattern <- grepl(matches, name);
  name[namePattern] <- correct_name
  name
}

starts_with <- c("ph", "fi", "ak", "van", "uni")
correct_names <- c("philips", "philips", "akzo", "van houten", "unilever")

## correct company names

refine <- refine %>% mutate(company = remove_space(company) %>% tolower)

for (i in 1:length(starts_with)){
  refine <- refine %>% mutate(company = revise_names(name = company, matches = starts_with[i], correct_name = correct_names[i]))
}


# 2: Separate product code and number

refine <- separate(refine, Product.code...number, c("product_code",  "product_number"), sep = "-")

# 3: Add product categories

categories <- c(p = "Smartphone", v = "TV", x = "Laptop", q = "Tablet")
refine <- refine %>% mutate(category = categories[product_code])


# 4: Add full address for geocoding

refine <-  refine %>% mutate(full_address = paste(address, city, country, sep = ", "))

# 5: Create dummy variables for company and product category

companies <- unique(refine$company)

for(name in companies) {
  n <- paste("company", name, sep = "_")
  refine[[n]] <- as.numeric(refine$company == name)
}

categories <- unique(refine$company)

for(cat in categories) {
  p <- paste("product", tolower(cat), sep="_")
  refine[[p]] <- as.numeric(refine$category == cat)
}

# 6: Submit the project on Github

refine_clean <- write.csv(refine, "~/Springboard Data Science/UNIT 3/Data Wrangling Exercise 1 Basic Data Manipulation/refine_clean.csv")

