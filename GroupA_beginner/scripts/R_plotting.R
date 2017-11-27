# install.packages('ggplot2')
library(ggplot2)
# install.packages('akima')
library(akima)
library(RColorBrewer)
dat <- read.csv("data/mendota_temp.csv", 
                colClasses = c(sampledate = "Date"))

# show working directory
getwd()
setwd()

# explore the data
str(dat)
summary(dat)

# assignment
x = 2
x <- 2

dat_clean <- filter(dat, wtemp >= 0)
# three ways to do the same thing
summary(dat_clean[,6])
summary(dat_clean$wtemp)
summary(dat_clean[,'wtemp'])

# how R handles NA values

x <- c(1:5, NA)
x
mean(x)
mean(x, na.rm = TRUE)
mean(x, na.rm = T)
?mean

# make plots!

plot(x = dat_clean$month, y = dat_clean$wtemp,
     xlab = "Month", ylab = "Water Temp", col = 'blue')
?par

# histogram
hist(dat_clean$year4, col = 'blue')

# use ggplot to make plots
ggplot(dat_clean, aes(x = month, y = wtemp)) +
  geom_point(aes(color = depth)) +
  facet_wrap(~year4)

# interpolate water temperature through whole water column
?interp

# use dplyr to manipulate the dataset

dat_interp <- select(dat_clean, sampledate, depth, wtemp)
dat_interp <- rename(dat_interp, 
                     x = sampledate,
                     y = depth, 
                     z = wtemp)

dat_interp <- interp(x = dat_interp$x, 
                     y = dat_interp$y,
                     z = dat_interp$z,
                     xo = seq(min(dat_interp$x, na.rm = TRUE), max(dat_interp$x), 1),
                     yo = seq(0, max(dat_interp$y), by = 0.2), 
                     extrap = FALSE, 
                     linear = TRUE)
head(dat_interp)
str(dat_interp)

# put it into dataframe format
dat_interp <- interp2xyz(dat_interp, data.frame = TRUE)

# plot interpolated data
ggplot(dat_interp, aes(x = x, y = y, z = z, fill = z)) +
  geom_tile()+
  scale_y_reverse()

dat_interp <- mutate(dat_interp, 
                     date = as.Date(x, origin = "1970-01-01"))

ggplot(dat_interp, aes(x = date, y = y, z = z, fill = z)) +
  geom_tile()+
  scale_y_reverse()

display.brewer.all()
my.cols <- brewer.pal(11, "Spectral")

ggplot(dat_interp, aes(x = date, y = y, z = z, fill = z)) +
  geom_tile()+
  scale_y_reverse() +
  scale_fill_gradientn(colors = rev(my.cols))
