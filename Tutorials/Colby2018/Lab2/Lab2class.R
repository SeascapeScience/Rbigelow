DATA <- read.csv("Colby_cruise_data_2012-2017.csv", header = TRUE)

library("ggplot2")

ggplot(data = DATA) +
  geom_point(mapping = aes(x = Temperature, y = Fluorescence), color="skyblue", shape=18, size = 1) +
  xlab('Temperature (deg C)') +
  ylab('Fluorescence (mg/m^3)') +
  coord_cartesian(xlim = c(7,18), ylim = c(0,12))

temp <- DATA[['Temperature']]
fl <- DATA[['Fluorescence']]

corValue <- cor.test(temp,fl, method = "pearson")

model1 <- lm(fl~ temp)

slope <- model1['coefficients'][[1]][[2]]
intercept <- model1['coefficients'][[1]][[1]]

p <- ggplot(data = DATA) +
  geom_point(mapping = aes(x = Temperature, y = Fluorescence), color="skyblue", shape=18, size = 1) +
  geom_smooth(mapping = aes(x = Temperature, y = Fluorescence), method = lm, se = FALSE, color='blue') +
  geom_abline(slope=slope, intercept=intercept, size=1, color='darkblue') +
  stat_function(fun = function(x) intercept + slope*x, size =1, color='blue') +
  xlab('Temperature (deg C)') +
  ylab('Fluorescence (mg/m^3)') +
  coord_cartesian(xlim = c(7,18), ylim = c(0,12))

p + annotate("text", x=9, y = 11, label = paste("Temp = ",format(slope,digits=3),"Fluor + ", 
             format(intercept,digits = 3),sep=""))


model2 <- lm(fl ~ temp + I(temp^2))
model3 <- lm(fl~ temp + I(temp^2) + I(temp^3))

p2 <- model2$coefficients[[1]][[3]]
p1 <- model2['coefficients'][[1]][[2]]
p0 <- model2['coefficients'][[1]][[1]]
q3 <- model3['coefficients'][[1]][[4]]
q2 <- model3['coefficients'][[1]][[3]]
q1 <- model3['coefficients'][[1]][[2]]
q0 <- model3['coefficients'][[1]][[1]]


ggplot(data = DATA) +
  geom_point(mapping = aes(x = Temperature, y = Fluorescence), color="skyblue", shape=18, size = 1) +
  stat_function(fun = function(x) intercept + slope*x, size =1, aes(color='line')) +
  stat_function(fun = function(x) p0 + p1*x + p2*(x^2), size =1.2, aes(color='quadratic')) +
  stat_function(fun = function(x) q0 + q1*x + q2*(x^2) + q3*(x^3), size =1.2, aes(color='cubic')) +
  scale_color_manual("",values = c("darkblue","orange","blue")) +
  xlab('Temperature (deg C)') +
  ylab('Fluorescence (mg/m^3)') +
  coord_cartesian(xlim = c(7,18), ylim = c(0,12))


sum_model1 <- summary(model1)
sum_model2 <- summary(model2)
sum_model3 <- summary(model3)

rsquare <- c(sum_model1$r.squared,sum_model2$r.squared,sum_model3$r.squared)
adjrsquare <- c(sum_model1$adj.r.squared,sum_model2$adj.r.squared,sum_model3$adj.r.squared)
std_error <- c(sum_model1$sigma,sum_model2$sigma,sum_model3$sigma)

pvalue <- c(pf(sum_model1$fstatistic[[1]],sum_model1$fstatistic[[2]],
              sum_model1$fstatistic[[3]],lower.tail = FALSE),
           pf(sum_model2$fstatistic[[1]],sum_model2$fstatistic[[2]],
              sum_model2$fstatistic[[3]],lower.tail = FALSE),
           pf(sum_model3$fstatistic[[1]],sum_model3$fstatistic[[2]],
              sum_model3$fstatistic[[3]],lower.tail = FALSE))

statsData <- data.frame(rsquare,adjrsquare,std_error,pvalue,
                       row.names = c("model1","model2","model3"))

library("broom")
tidy(model1)


source('TSdiagram.R')

TSdiagram(DATA[['Temperature']],DATA[['Salinity']])

TSdiagram(DATA[['Temperature']],DATA[['Salinity..PSU.']],
          DATA[['Fluorescence']],'Fluorescence (mg m^-3)',
          clim=c(0,11))







