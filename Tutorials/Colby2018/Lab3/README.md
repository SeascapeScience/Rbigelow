# Lab 3: Visualizing 2D patterns in oceanographic cruise data


This lab focuses on visualizing temporal and spatial patterns in oceanographic cruise data i.e. how do parameters vary upriver compared with the open ocean or how do parameters vary with depth or how does one station change over the season? The tools you are introduced to here can be used to graph and analyze data in your labs, your independent research projects and the cruise data gathered throughout the semester. Be sure to save any scripts that you develop so you can continue to use them.

# A. Visualization of discrete data using contour plots

In this section, we are going to visualize how parameters vary at each station for each cruise.

## A1. Importing data

We are going to look at some of the discrete data, taken from the Niskin bottles. To do this, we need to create another csv file from the Colby_cruise_data_2012-2017.xlsx sheet like last week. But let's start by setting our working directory.

```{r}
setwd('C:/Users/Catherine/Documents/REUColbyCoding/CMdev/RbigelowCMdev/Lab03_2018')
```

### Creating discrete data csv file

1. Open Colby_cruise_data_2012-2017.xlsx
2. Open a new blank Excel file
2. Go to the "discrete data" tab
3. Select and copy the following columns: date, cruise, station, depth, SiO4,	NO3+2,	PO4,	NH4,	Bacteria Conc,	Viral Conc,	Chl Total,	CHL <20um,	CHL<3um,	Flowcam Biomass.
5. Paste the columns into the blank Excel file
6. Delete the rows from 2012 - 2015 and 2017 i.e. so the only year left is 2016.
7. Delete the dates column and the top two rows (the row of units and the row contain the units of a few of the columns)
8. Press CTRL-F on Windows, or the Command-F on a Mac, to bring up the "Find and Replace" window.
9. Go to the Replace tab, enter "Cruise" in the "Find What" box and nothing in the "Replace with" box, hit "Replace all"
10. Repeat 9 for the word "BLOS" and close the window
11. Save the file as a CSV (Comma Delimited) with a sensible name e.g. Colby_discrete_data_2016.csv

### Importing the data

Let's import the data as before.

```{r}
# read in the whole csv file
discreteDATA <- read.csv('Colby_discrete_data_2016.csv', header = TRUE)
```

## A2. Data wrangling and creating contour plots

We are going to create a contour plot for the surface data, for station vs cruise. To do this we are going to use the `plotly` library, so let's import the package, and load it into our workspace

```{r}
install.packages("plotly")

library("plotly")
```

Now we can extract the surface data from our `DATA` data frame and plot the result.

```{r}
#extracting data with a depth of less than 5m
surface = discreteDATA[discreteDATA$Depth < 5,]

#plotting the contour plot
p = plot_ly(x= surface$ID, y = surface$Station, z = surface$NO3.2, 
        type = "contour")

#adding the axis labels and title
layout(p, xaxis = list(title = 'Cruise number'), yaxis = list(title = 'Station number'), 
      title = "NO3.2 (uM)")
```
![](https://github.com/SeascapeScience/Rbigelow/blob/master/Tutorials/Colby2018/Lab3/discreteContourPlot.png)


# B. Visualization of continuous data using section plots

In this section, we are going to visualize spatial changes in terms of depth and station for a given cruise.

## B1. Importing and wrangling data

For this section, we are going to use the csv file we made last day which contains all the continuous CTD profiles, and extract out one cruise.

```{r}
#importing the CTD data
CTDdata <- read.csv('Colby_cruise_data_2012-2017.csv')

#making a list of the dates of each cruise
dates <- unique(CTDdata[['Date']])

#extracting data for the cruise on September 8th 2016
cruiseData <- CTDdata[CTDdata[['Date']] == dates[17],]
```

We could use the same plotting function as before to plot e.g. Temperature:

```{r}
# plotting the contour plot
p <- plot_ly(x = cruiseData$Station, y = cruiseData$Depth, z = cruiseData$Temperature, 
              type = "contour", contours = list(showlines = FALSE))

#adding the labels and reversing the y-axis
layout(p,yaxis = list(autorange = "reversed",title = 'Depth (m)'),
       xaxis = list(title = 'Station number'), 
       title = "Temperature (deg C)")
```
![](https://github.com/SeascapeScience/Rbigelow/blob/master/Tutorials/Colby2018/Lab3/ctdContourPlot.png)

We end up with distinct bands at the deeper depths. This is because of the interpolation that has been done by the plotting function. Stations 1 - 3 are 50m or shallower, hence the only data at the deep depths are from station 4. The plotting function then assumes that is the value at that depth for all stations, which is incorrect. Let's try a different method instead.

## B2. Coding technique: for-loops

When you want to repeat the same bit of code a certain number of times, a for-loop can be your friend. For example, if you would like to plot a section for each cruise, rather than type out the code for each cruise individually, we can just write it once and iterate or *loop* over the code. 

Let's start with a simple example:

#### Example: print the statement "hello" four times
```{r}
for (ii in 1:4) {
  print("hello")
}
```

#### Example: print the statement "hello" four times, including the number at the start of the statement e.g. "1 hello"
```{r}
for (ii in 1:4) {
  print(paste(ii,"hello"))
}
```

## B3. Plotting oceanographic section

For this method, we'll make use of the fields package, which provides tools for analyzing and visualizing spatial data.

```{r}
library("fields")
```

To do this plot, we are goint to need to manipulate our data a bit more. We need to make our Temperature data into a matrix, where each row represents a depth, and each column represents a different station. The depth data are not consistent; they are all at irregular intervals. Therefore, to put the temperature data into a matrix, we are going to need to bin the data into regular depth intervals of 1m.

```{r}

stationLat <- c(43+54.130/60, 43+51.8/60, 43+48.56/60, 43+44.87/60)

#creating an empty matrix with 100 rows (i.e. for 100 depths) and 4 columns (i.e. one for each station)
TEM <- matrix(NA,nrow = 100, ncol = 4)

#looping through each station
for (st in 1:4){
  #looping through each depth interval (from 1m to 100m)
  for (j in 1:100){
    #extracting the relevant station from the cruiseData data frame
    stationData <- cruiseData[cruiseData$Station == st,]
    
    #binned temperature value for given depth interval
    temp = mean(stationData[ceiling(stationData$Depth)==j,'Temperature']) 
    
    #assinging the binned temperature to the j-th row and st-th column of the TEM matrix
    TEM[j,st] <- temp
  }
}
```

Now we've created our matrix, we can plot the temperature section.

```{r}
image.plot(x=stationLat[4:1],y=-100:-1,t(TEM[100:1,4:1]),
           zlim=c(8,20),
           col=tim.colors(24),
           xlab='Latitude (deg N)',
           ylab='Depth (m)',
           main='Cruise 20160908',
           legend.lab='Temperature (C)',
legend.line=2.5)

```
![](https://github.com/SeascapeScience/Rbigelow/blob/master/Tutorials/Colby2018/Lab3/tempSection1.png)

#### Example: How do we change the color scheme?

1. We can use one of the R color palettes e.g. `heat.colors`, `terrain.colors`, `topo.colors` as the `col` argument in place of the `tim.colors` argument. 
2. We can use one of the Color Brewer palettes. Color Brewer was a project which created a lot of different color palettes for thematic maps. There are different types of color palettes depending on your needs (e.g. sequential color scale, diverging color scale, quantative scales). It has a cool web-interface (http://colorbrewer2.org/#) where you can play around with the palettes. What is good about Color Brewer is the sequential color palettes (the type we used in our above section plot) are made from at most 3 colors, and are altered by changing the hue. This makes the maps colorblind-friendly and prevents artificial sharp edges between color changes. R has a package for the Color Brewer palettes. Check out the help to see a list of the sequential palette names you can use.


```{r}
library("RColorBrewer")
```

```{r}

colpal <- colorRampPalette(brewer.pal(9,'YlOrRd'))   # make colors

image.plot(x=stationLat[4:1],y=-100:-1,t(TEM[100:1,4:1]),
           zlim=c(8,20),
           col=colpal(60),
           xlab='Station',
           ylab='Depth (m)',
           main='Cruise 20160908',
           legend.lab='Temperature (C)',
legend.line=2.5)
```
![](https://github.com/SeascapeScience/Rbigelow/blob/master/Tutorials/Colby2018/Lab3/tempSection2.png)

## B4. Coding technique: Functions

Functions are blocks of code which when called, perform a specific task. Usually you give them an input and they give you an output. We've used lots of different R in-built functions e.g. `read.csv`, `image.plot`, etc. We can write our own functions for our own specific tasks.

#### Example: write a function which adds two numbers

```{r}
addition <- function(a,b){
  return(a+b)
}

addition(9,3)
```

Let's write a function which turns a variable from the CTDdata into a matrix (for plotting as a segment). To do this, we'll just copy the code from above and wrap it in a function.

```{r}
col2matrix <- function(columnName){
  
  #creating an empty matrix with 100 rows (i.e. for 100 depths) and 4 columns (i.e. one for each station)
  TEM <- matrix(NA,nrow = 100, ncol = 4)
  
  #looping through each station
  for (st in 1:4){
    #looping through each depth interval (from 1m to 100m)
    for (j in 1:100){
      #extracting the relevant station from the cruiseData data frame
      stationData <- cruiseData[cruiseData$Station == st,]
      
      #binned temperature value for given depth interval
      temp = mean(stationData[ceiling(stationData$Depth)==j,columnName]) 
      
      #assinging the binned temperature to the j-th row and st-th column of the TEM matrix
      TEM[j,st] <- temp
    }
  }
  return(TEM)
}

```



# Assignment (in lab)

Qs1
a. Plot a contour plot for different discrete variables. Can you figure out how to change the color scheme? 

b. Try plotting a station-by-depth contour plot for 1 cruise (instead of station-by-cruise)

c. Try plotting a depth-by-cruise contour plot for 1 station.

d. Try plotting a contour plot of your choice for a different cruise.


Qs2
Plot an oceanographic section for different variables from the CTD casts (use the `col2matrix` function we just wrote to wrangle your data into the correct format). Remember to change the limits of the color scale by adjusting the `zlim` argument to `image.plot`.

