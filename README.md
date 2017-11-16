# GSA workshop 2017

This is a repository for materials related to the visualization in R workshop held at GLEON 19. The morning session will be focused on individuals who are new to R, and thus we will cover the basics of programming, importing/exporting data, and basic visualizations. The afternoon session will be focused on individuals who have some R skills, and thus will focus on more advanced data visualization skills.

# Before you come to the workshop...

1) Download and install both R and RStudio. If you already have these installed, please update them both.
2) Install the R packages we will use for the course. You can do so by copying and pasting the following code into the RStudio console and hitting enter.

  ```install.packages('dplyr', 'ggplot2', 'akima', 'lubridate')```

2) Download the data for the course, which is different depending on which session you are in. [Group A (beginner) session data](https://minhaskamal.github.io/DownGit/#/home?url=https://github.com/limnoliver/GSA-workshop-2017/tree/master/GroupA_beginner/data) focuses on Lake Mendota, WI temperature profiles. [Group B (intermediate) session data](https://minhaskamal.github.io/DownGit/#/home?url=https://github.com/limnoliver/GSA-workshop-2017/tree/master/GroupB_intermediate/data) includes the Lake Mendota, WI temperature profiles, a database of water quality information for many lakes across the U.S., and a shape file from Acton Lake, OH. 
3) Create a new R Project called "GSA_workshop_2017" and create three folders within this project: "data", "scripts", and "figures".
4) Move the downloaded data into your "data" folder within the project directory. 
