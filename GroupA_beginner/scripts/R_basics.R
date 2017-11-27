# install.packages('dplyr')
library(dplyr)

# This is a comment

# R is a calculator
5+5
5^5
5*5

# objects
x <- 5+5
x
x2 <- x + 5

name_random <- "Bob"
str(name_random)
str
?str
str()

??structure

# create a vector
vec1 <- c(1,2,3)
?c
str(vec1)

vec1[2]

# create vectors quickly
vec2 <- 1:100
vec3 <- seq(from = 2, to = 3, by = 0.01)
?seq

# explore the data
summary(vec3)
max(vec3)
sd(vec3)

mean(1,10)
?mean
mean(c(1, 10))
y <- c(1,10)
mean(y)
mean(1:10)

# create a data frame
obs_value <- 10:20
site <- c(rep(c("A", "B"), 5), "C")
site

df <- data.frame(site_name = site,
                 values = obs_value) 
str(df)
dim(df)
df[5, 1]

# manipulate our data frame
df2 <- filter(df, site_name != "C")
df2 <- mutate(df2, conv_values = values/10)
df2

# rename our columns
names(df2)

# drop a column, two ways to do the same thing
df2 <- select(df2, site_name, conv_values)
df2 <- select(df2, -values)

# rename a column
df2 <- rename(df2, values = conv_values)
?rename
names(df2)




