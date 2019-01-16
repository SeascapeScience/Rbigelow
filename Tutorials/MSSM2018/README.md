<!DOCTYPE html>
<html>
    <head>
    </head>
    <body>

<A HREF="https://tuvalabs.com/upload/d/041a45c6c6834afaa5b9f28efe995ac3/">Boothbay Temperature Data</A><BR>
1. Is Boothbay Harbor warming? <BR>
2. How fast is it warming? <BR>
3. Is the rate of warming getting faster? <BR>
4. Is the rate different at different times of year? <BR>
<BR>
<BR>
<a href="https://tuvalabs.com/upload/d/7d9cec72b4af4fcb9b5da32b6314e8c2/">CTD Profile Data</a><br>
1. How does temperature vary with depth?<BR>
2. How do the other variables vary with depth? Why do the profiles look the way they do?<BR>
3. Which variables correlate with each other and why?<BR>
4. What patterns are there when you add a third variable as a color?<BR>
<BR>
<BR>
	<a href="http://rstudio.bigelow.org/">R Studio Server</a><BR>
	<BR>
	Some useful lines of code:<BR>
	DATA=read.csv('Lab01example.csv')<BR>
	plot(DATA$Temp..deg.C.,-DATA$Depth..M.)<BR>
	DATA=read.csv('Colby_cruise_data_2012-2017.csv')<BR>
	newData=DATA[which(DATA$Month==10),]<BR>
	plot(newData$Temperature,newData$Depth..m.)<BR>
	</body>
</html>
