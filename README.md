# Bigelow | R Tutorials

## Contents
 - Tutorials for learning R
 - Tutorials for simple plotting/analyzing oceanographic data


## Example 1: Installing, loading, plotting, correlation

This is a walk-through tutorial on R. We cover some of the very basics using an example file (Example01.csv). The commands used here can also be found in the file Example01.R. This tutorial is intended as a brief introduction. There is much more documentation on these and other functional capabilities of R. 

### Installing R and R-studio

1.  Install R program at: http://cran.rstudio.com/
This site has options for download for Linux, Mac, and Windows
 
2.  Install r-studio  (R interface)
http://www.rstudio.com/products/rstudio/download/
Under “installers” you should see options for Mac and Windows

### Loading

1. Launch R-studio and navigate to the directory you want to work in. You can either do this from the command line directly, or from the drop-down menus. From the command line, the command is setwd.

```setwd('~/Work/Teaching/R/')```

Note: This folder directory will depend where you have placed the example files. The other option to entering this command is to go to “Session” in the file menu, select “Set Working Directory”, and select “Choose Directory”.

2. To load the data, use this command:

```DATA <- read.csv('Example01.csv')```

The command read.csv loads in .csv files. There are other commands for loading other types of file (e.g. read.xls). The file name is given in quotes (these can be single or double quotes). In this example, we’ve read the file into a variable called “DATA”. This could have been any name we choose (e.g. Experiment1, TempData, X, Stuff
, etc.).

Now the data is loaded. You should see a variable called DATA in your Environment window. You can click on it to see what it in it. To view a summary of the data, type:

```summary(DATA)```

You should see an output with summary information.

```
Temperature       Rate       
 Min.   :1.0   Min.   : 2.100  
 1st Qu.:2.5   1st Qu.: 4.350  
 Median :4.0   Median : 6.800  
 Mean   :4.0   Mean   : 7.914  
 3rd Qu.:5.5   3rd Qu.:10.300  
 Max.   :7.0   Max.   :17.200
```

### Plotting

The data file has two columns: one for temperature and one for rate. To plot them, type:

```plot(DATA[,1],DATA[,2])```

The plot should appear in the “Plots” tab in R-studo. This plots the 1st column on the x-axis and the 2nd column on the y-axis. The “1” and “2” in the command indicate the columns. For a dataset with more columns, you can change these numbers to plot other variables.

Another option is to use the column names themselves, with double brackets:

```plot(DATA[['Temperature']],DATA[['Rate']])```

There are a number of plotting options to make the plot look nicer. For example, try:

```plot(DATA[,1],DATA[,2],type='l',col='blue',lwd=5)```

More options for plotting can be found in R help files.

Corellation
To run a correlation test

```cor.test(DATA[,1],DATA[,2])```

You should see an output like this:
```
Pearson's product-moment correlation

data:  DATA[, 1] and DATA[, 2]
t = 8.5727, df = 5, p-value = 0.000356
alternative hypothesis: true correlation is not equal to 0
95 percent confidence interval:
 0.7908199 0.9953752
sample estimates:
     cor 
0.967625
```
