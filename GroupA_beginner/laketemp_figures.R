# script for GLEON workshop
# Group A (beginners): Intro to visualization in R
library(akima)
library(dplyr)
library(ggplot2)
library(lubridate)
library(rLakeAnalyzer)

# read in Lake Mendota temperature profiles
dat <- read.csv('data/mendota_temp.csv', stringsAsFactors = FALSE,
                colClasses = c(sampledate = "Date"))

# look at the structure of the data
str(dat)
head(dat)
tail(dat)

# clean
summary(dat) # notice there are missing values we may want to get rid of, data that clearly has issues

dat <- filter(dat, wtemp > 0)
dat <- filter(dat, !is.na(wtemp))

# some simple plots of the data
# histograms
# scatterplots
# boxplots

# plot temp through time

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

# calculate thermocline using thermo.depth from package rLakeAnalyzer

thermocline <- data.frame(date = NA,
                          thermo_depth = NA)

for (i in 1:length(unique(dat.short$sampledate))) {
  temp.date <- unique(dat.short$sampledate)[i]
  temp.dat <- filter(dat.short, sampledate == temp.date)
  wtr <- temp.dat$wtemp
  depths <- temp.dat$depth
  thermo <- thermo.depth(wtr, depths, seasonal = FALSE)
  thermocline$thermo_depth[i] <- ifelse(is.na(thermo), NA, thermo)
  thermocline$date[i] <- temp.date
}
