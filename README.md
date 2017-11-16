# GSA workshop 2017

This is a repository for materials related to the visualization in R workshop held at GLEON 19. The morning session will be focused on individuals who are new to R, and thus we will cover the basics of programming, importing/exporting data, and basic visualizations. The afternoon session will be focused on individuals who have some R skills, and thus will focus on more advanced data visualization skills.

# Before you come to the workshop...

## Install Software
1) [Download](http://cran.stat.sfu.ca/) and install the latest version of R. Please update R if you are using an R version < 3.4.1.
2) [Download](https://www.rstudio.com/products/rstudio/download/) and install RStudio. If you already have RStudio installed, please update to the latest version (In RStudio, navigate to Tools > Check for Updates).
3) Install the R packages we will use for the course. You can do so by copying and pasting the following code into the RStudio console and hitting enter. ```install.packages(c('dplyr', 'ggplot2', 'akima', 'lubridate'))```

## Download Data

1) Download the data for the course, which is different depending on which session you are in. [Group A (beginner) session data](https://minhaskamal.github.io/DownGit/#/home?url=https://github.com/limnoliver/GSA-workshop-2017/tree/master/GroupA_beginner/data) focuses on Lake Mendota, WI temperature profiles. [Group B (intermediate) session data](https://minhaskamal.github.io/DownGit/#/home?url=https://github.com/limnoliver/GSA-workshop-2017/tree/master/GroupB_intermediate/data) includes the Lake Mendota, WI temperature profiles, a database of water quality information for many lakes across the U.S., and a shape file from Acton Lake, OH. 

2) Click on the above links to download the data, which will download a zipped folder called "data" to your computer. Unzip this folder. 

## Create a new project in R
1) Open RStudio and create a new R Project called "GSA_workshop_2017" (File > New Project...).  Create three folders within this project: "data", "scripts", and "figures". This can be done from the bottom right pane within RStudio under the "Files" tab (click "New Folder"). 

2) Move all of the downloaded data into your "data" folder within the project directory. 
