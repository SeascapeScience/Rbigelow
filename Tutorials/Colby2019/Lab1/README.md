# Lab 1: Data analysis in R: Oceanographic profile
## ES 383 September 2018

This lab serves as an introduction to the data analysis, visualization, and interpretation that you will conduct throughout the semester. The tools that are introduced here can be used to graph and analyze data in your labs, data you collect in the field, and data from your independent project. You can use the exercises here as a template for your future analyses.

Moreover, this lab provides experience in writing code—a skill that is becoming increasingly relevant in almost every field.

You will use files from sampling done along the Damariscotta Estuary. The data set used here is:	Lab01example.csv – CTD data from the deep station

It will be most useful to you in the long term to install R and R-studio on your own computer. However, if you prefer, we can set you up to use R-server, so that you can use R through a web browser.

### INSTALLING R and R-STUDIO

1.  Install R program at: http://cran.rstudio.com/
This site has options for download for Linux, Mac, and Windows
 
2.  Install r-studio  (R interface)
http://www.rstudio.com/products/rstudio/download/
Under “installers” you should see options for Mac and Windows

### GRAPHING

Some basic tips on scientific figures

1. Display information as clearly and simply as possible
2. Label axes (with units in parentheses) and any other critical information
3. Provide details in the figure caption. Don't restate information that should be clear from the figure. However, sometimes it might be helpful to call out a key feature.
4. A title above the figure us optional, but usually not needed. 
5. Font should be an easily readable size

Here's a nice reference:

Rougier, Nicolas P., Michael Droettboom, and Philip E. Bourne. "Ten simple rules for better figures." (2014): PLoS Computational Biology e1003833.
http://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1003833

Here's an example of what to watch out for:

<img src="https://github.com/SeascapeScience/Rbigelow/blob/master/Tutorials/Colby2018/Lab1/BadFigure.png" width="500">

Problems: 	
 - Axes are not labeled.
 - Numbers overlap with axes.
 - What does “Series 1” mean? 
 - The line of data is difficult to follow.
 - One side of the rectangle has no line.
 - Font is pizelated and difficult to read.

**Note**: Using the literature as a guide is very helpful, but be careful: there are lots of bad figures in the literature. If a figure is difficult to follow, it's probably not a good figure. Make a mental note of what is wrong with it so you can avoid that.

### PLOTTING A PROFILE IN R -- A REFERENCE EXAMPLE

This is a step-by step quick reference for loading in data and making a basic plot. These commands should work mostly as-is, except for the working directory in step 1. There are lots of details that are brushed over here. Those details are covered in the accompanying presentation.

1. Launch R-studio and navigate to the directory you want to work in.

   ```setwd('~/Work/Labs/Lab01/')```  

   This is an example. You’ll need to decide where the directory is that you want to work in and use that path inside the quotes.
   
   **_Make sure to download the file_ Lab01example.csv _into this same directory._**

   You can also use the commands under the “files” tab in the lower right. 

   This command, `setwd()`, is for “set working directory”. This can be any directory on your computer, but you should think about how you want to organize your data, your labs, etc. For this example, make sure that the file you want to plot is in this directory. 

2. Install and load the ggplot2 package by running this code:

   ```
   install.packages("ggplot2")
   library("ggplot2")
   ```
   You only need to install a package once, but you need to reload it every time you start a new session.
   
3. Load the data you want to plot. Here, the file name is “Lab01example.csv”. The data contained in that file are loaded into a variable called “DATA”. Note: Different file formats will be read in differently. We’ll cover this.

   ```
   DATA <- read.csv('Lab01example.csv')
   ```  

   In the command above, we didn’t have to call the variable “DATA”. We could have called it something else, like “STATION_4”, “X”, or “Pinocchio”.

4. Look at a summary of what is in this variable.

   ```
   summary(DATA)
   ```  
   
   Something like this will show on the screen, summarizing the data in “DATA”:  

   ```
   Depth..M.        Temp..deg.C.    Salinity..PSU.    Density..kg.m.3. 
    Min.   :  0.166   Min.   : 8.871   Min.   : 0.8708   Min.   : 0.2984  
    1st Qu.: 17.636   1st Qu.:10.526   1st Qu.:32.9609   1st Qu.:25.1233  
    Median : 44.685   Median :10.892   Median :33.2506   Median :25.4006  
    Mean   : 47.196   Mean   :10.857   Mean   :32.3029   Mean   :24.7033  
    3rd Qu.: 74.919   3rd Qu.:11.271   3rd Qu.:33.4374   3rd Qu.:25.6468  
    Max.   :101.451   Max.   :11.380   Max.   :33.4619   Max.   :25.7321  
   ```
   You can learn more about “DATA” with these function:
   ```
   str(DATA)  #  Compactly display the internal structure of the R object "DATA"
   head(DATA) #  Returns the first parts of the data frame "DATA"
   tail(DATA) #  Returns the last parts of the data frame "DATA"
   ```

5. To plot a basic oceanographic profile with ggplot. You can plot temperature (column 2: "Temp..deg.C.") against depth (column 1: "Depth..M.") with ggplot:

   ```
   ggplot(DATA, aes(x=Temp..deg.C., y=-Depth..M.)) + geom_point()
   ```  
   
   And finally, here is an example of some of the options to make the figure nicer (note the functions for labeling axes (xlab(), ylab()), setting the axis limits (xlim(), ylim()). There are lots of other options to customize the figure.
   
   ```
   ggplot(DATA, aes(x=Temp..deg.C., y=-Depth..M.)) + geom_point() +
      xlab("Temperature (deg C)") + ylab("Depth (m)") +
      xlim(10,11.5) + ylim(-100, 0)
   ```
   Note the warning message we received:
   ```
   Warning message:
   Removed 33 rows containing missing values (geom_point).
   ```
   That is normal when data in your input data.frame (here “DATA”) are outside the range you are plotting.
   
6. Save the figure using these two commands:

   ```
   dev.copy(png,'ExampleFigure.png')
   dev.off()
   ```
   You can also use the ggplot function ggsave()
   ```
   ggsave('ExampleFigure-ggsave.png')
   ```
   
<img src="https://github.com/nmayot/Rbigelow/blob/nico-updates/Tutorials/Colby2019/Lab1/ExampleFigure-ggsave.png" width="350" height="350">

### ASSIGNMENT (in lab)

1. The figure is starting to look better, but still needs work.

   Here is a list of arguments that can be used with the `ggplot()` command can be found in these resources:  

   https://www.rdocumentation.org/packages/graphics/versions/3.5.1/topics/par  

   And a series of plotting example you can run here:

   https://www.rdocumentation.org/packages/graphics/versions/3.5.1/topics/plot

   Experiment with some of the graphical parameters to improve the quality of the figure. Make as high a quality figure as you can. 

   Write an R script that loads in the data file, plots the profile (as a high quality figure), and saves the figure as a file. **Email the R script and the image file at the end of the lab.**

2.  Use the R script you wrote for question 1 and make minor modifications to plot profiles of the other parameters in this dataset. We will discuss the features of the profiles together. **Email the images from all profiles at the end of lab.**


