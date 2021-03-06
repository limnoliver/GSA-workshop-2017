# script for GLEON workshop
# Group A (beginners): Intro to visualization in R
library(akima)
library(dplyr)
library(ggplot2)
library(lubridate)
library(rLakeAnalyzer)
library(RColorBrewer)

# read in Lake Mendota temperature profiles
dat <- read.csv('GroupA_beginner/data/mendota_temp.csv', stringsAsFactors = FALSE,
                colClasses = c(sampledate = "Date"))

# look at the structure of the data
str(dat)
head(dat)
tail(dat)

# clean
summary(dat) # notice there are missing values we may want to get rid of, data that clearly has issues
hist(dat$depth)
hist(dat$wtemp)

ggplot(dat, aes(x = month, y = wtemp)) +
  geom_point() +
  facet_wrap(~year4)

ggplot(dat, aes(x = factor(month), y = wtemp)) +
  geom_boxplot() + 
  facet_wrap(~year4)

dat <- filter(dat, wtemp > 0)
dat <- filter(dat, !is.na(wtemp))

# some simple plots of the data
# histograms
# scatterplots
# boxplots

plot(dat$depth ~ dat$sampledate)

# plot temp through time
surface <- filter(dat, depth == 0)
deep <- filter(dat, depth == 20)
plot(surface$wtemp ~ surface$sampledate)
plot(surface$wtemp ~ surface$sampledate, col = 'blue', pch = 16)
points(deep$wtemp ~ deep$sampledate, col = 'green', pch = 16)
?par

# that's all fine, but what we really want is an 
# interpolated plot that shows smooth depth contours
# ?interp

dat2 <- select(dat, sampledate, depth, wtemp) %>%
  rename(x = sampledate, y = depth, z = wtemp)

dat.interp <- interp(x = dat2$x, y = dat2$y, z = dat2$z, 
                     xo= seq(min(dat2$x), max(dat2$x), by = 1), yo = seq(0, max(dat2$y), by = 0.2), 
                     extrap = FALSE, linear = TRUE)

dat.interp <- interp2xyz(dat.interp, data.frame = TRUE)

# clean up dates using dplyr
dat.interp.df <- dat.interp %>%
  filter(x %in% as.numeric(dat$sampledate)) %>% # I don't want interp to interpolate days where we don't have data, so let's drop those
  mutate(date = as.Date(x, origin = "1970-01-01")) %>% # interp turned our dates into integers, let's put them back as dates
  mutate(day = yday(date)) %>% # create a variable that is day of the year for prettier plotting
  mutate(year = year(date)) # create a four digit year

# create a color palette to use for temperature
my.cols <- brewer.pal(11, "Spectral")

# plot our interpolated data
ggplot(dat.interp.df, aes(x = day, y = y, z = z, fill = z)) +
  geom_tile() +
  scale_y_reverse() +
  scale_fill_gradientn(colours = rev(my.cols), na.value = 'gray') + 
  facet_wrap(~year, ncol = 2) +
  theme_bw() 

# filter to years with most complete data
dat.short <- filter(dat, year4 %in% c(2010:2014))

