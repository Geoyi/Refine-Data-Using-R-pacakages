setwd("C:/Data Science Fundation with R/Springboard GitHub")
list.files("C:/Data Science Fundation with R/Springboard GitHub")
library('dplyr')
library('tidyr')

#read the data from the file
refine <- read.table("refine_original.csv",header = TRUE, sep = "," )

#1: Clean up brand names: correct all the compay name to lower case and replace the oler 'compay' col.
refine$company <- tolower(refine$company)

#check the out the whole table again.
View(refine)

#2: Separate product code and number in library 'tidyr'
refine <- refine %>% separate(Product.code...number, c("product_code","product_number"), sep= "-")

# add a new list of products and it's product code
list<- list(product_code = c('p','v','x','q'),categories = c('smartphone','TV','Laptop','Tablet'))

# 3: Add product categories: join two table between list and refine

refine <- merge(refine,list, by = "product_code", all = TRUE)


#Define a function that could covert lowercase to title
simpleCap <- function(x) {
  s <- strsplit(x, " ")[[1]]
  paste(toupper(substring(s, 1,1)), substring(s, 2),
        sep="", collapse=" ")
}

# 4: Add full address for geocoding: unify the field
refine_Final <- unite_(refine, "Fulladdress",c("country", "city", "address"),sep= ", ")

refine_Final$Fulladdress <- simpleCap(refine_Final$Fulladdress)

write.csv(refine_Final, file = "Refine_Final Dataset.csv")
