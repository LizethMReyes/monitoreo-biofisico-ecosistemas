#Eliminar en la tabla dentro de los parametros los valores que esten fuera de rango (como 0, etc.)

setwd("C:/Users/Administrador/Documents/BD_Estandarizada")

rm(list = ls()) # clear the workspace

product <- "LST_Day_1km" # set the product (and band)

# Note: this script must be run from the same directory that contains the statistics file.
stat_fname <- paste("statistics_", product, ".csv", sep='') 

#### Load required packages. You may need to run install.packages('package') if you have not used these before.
library(ggplot2) #package for plotting
library(viridis)
library(viridisLite) # package for nice color scheme

#### Read in data
stat_fname <- paste("statistics_", product, ".csv", sep='')
subset_stats <- read.csv(stat_fname, head=TRUE, sep=",")
summary(subset_stats) # get basic summary information about the data

# Format dates and add to dataframe
dates <- as.Date(subset_stats$dt, format = "%d/%m/%Y")
years <- format(dates, format = "%Y")
n_yrs <- length(unique(years)) # calculate number of years in subset
months <- format(dates, format = "%m")
monthAbbrev <- format(dates, format = "%b")
DOY <- as.numeric(substr(subset_stats$modis_date,6,8)) #to find the day of year (DOY), take the last three digits of date.YYYYDDD. which is an eight digit string

# find the 68% confidence intervals around the mean
y1 <- subset_stats$value_mean + subset_stats$value_standard_deviation
y2 <- subset_stats$value_mean - subset_stats$value_standard_deviation

# add to main data frame
subset_stats <- cbind(subset_stats, DOY, months, years, y1, y2)


#### Figure 1: mean and variation timeseries: subset mean is a dark line and 68% CI is a shaded region  
F1 <- ggplot(subset_stats, aes(x=as.Date(dt, format = "%d/%m/%Y"), y = value_mean)) + 
  geom_ribbon(aes(ymin=y2, ymax=y1), fill = "darkgray") + # draw the shaded area for 68% CI
  geom_line(colour = "#2D708EFF", aes(y=value_mean)) + # draw the line for the mean value
  ggtitle("Subset Mean and 68% CI") + # add a title
  ylab(product) + # add a y-axis label
  xlab("fecha") + # add a x-axis label
  theme_bw() + # set the plot theme
  theme(plot.title = element_text(lineheight=.8, face="bold", size=20), axis.title.x = element_text(face="bold", size=20), axis.title.y = element_text(face="bold", size=20), axis.text.x = element_text(size=16), axis.text.y = element_text(size=16)) # set optional theme elements

F1

#### Figure 2: mean monthly values for the subset
F2 <- ggplot(subset_stats, aes(factor(months), value_mean)) +
  geom_boxplot(fill="#2D708EFF") + 
  geom_jitter(width = 0) + 
  ggtitle("Subset Values by Month") + 
  scale_x_discrete(breaks= months, labels=monthAbbrev) + 
  xlab("Month") + 
  ylab(product) + 
  theme_bw() +
  theme(plot.title = element_text(lineheight=.8, face="bold", size=20), legend.position="none", axis.title.x = element_text(face="bold", size=20), axis.text.x = element_text(angle=90, vjust=0.5, size=16), axis.title.y = element_text(face="bold", size=20), axis.text.y = element_text(size=16)) +
  guides(fill="none")

F2

F3 <- ggplot(subset_stats, aes(factor(years), value_mean)) +
  geom_boxplot(fill="#2D708EFF") + 
  geom_jitter(width = 0) + 
  ggtitle("Subset Values by Year") + 
  scale_x_discrete(breaks= years, labels=years) + 
  xlab("Year") + 
  ylab(product) + 
  theme_bw() +
  theme(plot.title = element_text(lineheight=.8, face="bold", size=20), legend.position="none", axis.title.x = element_text(face="bold", size=20), axis.text.x = element_text(angle=90, vjust=0.5, size=16), axis.title.y = element_text(face="bold", size=20), axis.text.y = element_text(size=16)) +
  guides(fill="none")

F3

F4 <- ggplot(subset_stats, aes(x=value_mean)) + 
  geom_histogram(bins=15, fill="#2D708EFF", color="white") + 
  ggtitle("Distribution of Subset Mean Values") + 
  theme(plot.title = element_text(lineheight=.8, face="bold", size=20)) + 
  ylab("Frequency") + 
  xlab(product) + 
  theme_bw() +
  theme(plot.title = element_text(lineheight=.8, face="bold", size=20), legend.position="none", axis.title.x = element_text(face="bold", size=20), axis.text.x = element_text(angle=90, vjust=0.5, size=16), axis.title.y = element_text(face="bold", size=20), axis.text.y = element_text(size=16))

F4

F5 <- ggplot(subset_stats, aes(x=DOY, y=value_mean, color=years)) + 
  scale_color_viridis(discrete=T) + 
  geom_point(size=3) + 
  geom_smooth(aes(factor=years), se=FALSE, size=1.2) + 
  ggtitle("Subset Area Mean Value by Day of Year") + 
  theme(plot.title = element_text(lineheight=.8, face="bold", size=20)) + 
  xlab("Day of Year") + 
  ylab(product) + 
  theme_bw() +
  theme(plot.title = element_text(lineheight=.8, face="bold", size=20), axis.title.x = element_text(face="bold", size=20), axis.text.x = element_text(angle=90, vjust=0.5, size=16), axis.title.y = element_text(face="bold", size=20), axis.text.y = element_text(size=16)) 

F5

#La grafica llamada "F5" al correrlo sale error debido a que se está utilizando l paquete de viridisLite, por lo que los comandos se cambiaron

F6 <- ggplot(subset_stats, aes(factor(months), value_mean)) +
  geom_boxplot(fill="#2D708EFF") + 
  geom_jitter(width = 0) +  
  facet_wrap(~ years, ncol=3) +
  ggtitle("Subset Values by Month") + 
  scale_x_discrete(breaks=months, labels=monthAbbrev) + 
  xlab("Month") + 
  ylab(product) + 
  theme_bw() +
  theme(plot.title = element_text(lineheight=.8, face="bold", size=20), legend.position="none", axis.title.x = element_text(face="bold", size=20), axis.text.x = element_text(angle=90, vjust=0.5, size=16), axis.title.y = element_text(face="bold", size=20), axis.text.y = element_text(size=16))

F6


