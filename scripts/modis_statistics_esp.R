#Eliminar en la tabla dentro de los parametros los valores que esten fuera de rango (como 0, etc.)

setwd("C:/LSIG")

rm(list = ls()) # limpiar el espacio de trabajo

product <- "LST_Day_1km" # escoger producto y su banda (en caso de productos multibanda)

# Nota: este script debe correr sobre el mismo directorio donde se encuentra el archivo de estadísticas.
stat_fname <- paste("statistics_", product, ".csv", sep='') 

#### Cargar librerías. Puede ser que se requiera correr install.packages('package') si no han sido usados antes.
library(ggplot2) # librería para gráficos
library(viridis) # librería para colores
library(viridisLite) # librería para colores en una versión RStudio 2023.12.0+369 o más actual

#### Leer los datos
stat_fname <- paste("statistics_", product, ".csv", sep='')
subset_stats <- read.csv(stat_fname, head=TRUE, sep=",")
summary(subset_stats) # obtener resúmen básico de los datos

# Dar formato a fechas y añadir al dataframe, revisar el formato de fecha original y en su caso cambiar "%d/%m/%Y" por el formato adecuado en la lista dates
dates <- as.Date(subset_stats$dt, format = "%d/%m/%Y")
years <- format(dates, format = "%Y")
n_yrs <- length(unique(years)) # calcular el número de años del dataframe
months <- format(dates, format = "%m")
monthAbbrev <- format(dates, format = "%b")
DOY <- as.numeric(substr(subset_stats$modis_date,6,8)) #para encontrar el día del año (DOY), tomar los últimos datos de modis_date.YYYYDDD. el cual es un caracter de 8 dígitos

# encontrar el intervalo de confianza correspondiente al 68% de los datos alrededor del promedio
y1 <- subset_stats$value_mean + subset_stats$value_standard_deviation
y2 <- subset_stats$value_mean - subset_stats$value_standard_deviation

# añadir el subconjunto de datos previo al dataframe
subset_stats <- cbind(subset_stats, DOY, months, years, y1, y2)


#### Figura 1: subconjunto de datos, promedio y variación de la serie de tiempo: el promedio es una línea azul y el intervalo de confianza se representa como un área sombreada gris
F1 <- ggplot(subset_stats, aes(x=as.Date(dt, format = "%d/%m/%Y"), y = value_mean)) + 
  geom_ribbon(aes(ymin=y2, ymax=y1), fill = "darkgray") + # dibuja el área sombreada 68% CI
  geom_line(colour = "#2D708EFF", aes(y=value_mean)) + # dibuja la línea del promedio
  ggtitle("Promedio y 68% CI") + # añade el título
  ylab(product) + # añade etiqueta del eje y
  xlab("fecha") + # añade etiqueta del eje x
  theme_bw() + # ajusta el fondo del gráfico
  theme(plot.title = element_text(lineheight=.8, face="bold", size=20), axis.title.x = element_text(face="bold", size=20), axis.title.y = element_text(face="bold", size=20), axis.text.x = element_text(size=16), axis.text.y = element_text(size=16)) # ajuste de los elementos del gráfico

F1

#### Figura 2: valores promedio por mes
F2 <- ggplot(subset_stats, aes(factor(months), value_mean)) +
  geom_boxplot(fill="#2D708EFF") + 
  geom_jitter(width = 0) + 
  ggtitle("valores promedio para cada mes") + 
  scale_x_discrete(breaks= months, labels=monthAbbrev) + 
  xlab("Mes") + 
  ylab(product) + 
  theme_bw() +
  theme(plot.title = element_text(lineheight=.8, face="bold", size=20), legend.position="none", axis.title.x = element_text(face="bold", size=20), axis.text.x = element_text(angle=90, vjust=0.5, size=16), axis.title.y = element_text(face="bold", size=20), axis.text.y = element_text(size=16)) +
  guides(fill="none")

F2

F3 <- ggplot(subset_stats, aes(factor(years), value_mean)) +
  geom_boxplot(fill="#2D708EFF") + 
  geom_jitter(width = 0) + 
  ggtitle("Valores promedio para cada año") + 
  scale_x_discrete(breaks= years, labels=years) + 
  xlab("Año") + 
  ylab(product) + 
  theme_bw() +
  theme(plot.title = element_text(lineheight=.8, face="bold", size=20), legend.position="none", axis.title.x = element_text(face="bold", size=20), axis.text.x = element_text(angle=90, vjust=0.5, size=16), axis.title.y = element_text(face="bold", size=20), axis.text.y = element_text(size=16)) +
  guides(fill="none")

F3

F4 <- ggplot(subset_stats, aes(x=value_mean)) + 
  geom_histogram(bins=15, fill="#2D708EFF", color="white") + 
  ggtitle("Distribución de valores promedio") + 
  theme(plot.title = element_text(lineheight=.8, face="bold", size=20)) + 
  ylab("Frecuencia") + 
  xlab(product) + 
  theme_bw() +
  theme(plot.title = element_text(lineheight=.8, face="bold", size=20), legend.position="none", axis.title.x = element_text(face="bold", size=20), axis.text.x = element_text(angle=90, vjust=0.5, size=16), axis.title.y = element_text(face="bold", size=20), axis.text.y = element_text(size=16))

F4

F5 <- ggplot(subset_stats, aes(x=DOY, y=value_mean, color=years)) + 
  scale_color_viridis(discrete=T) + 
  geom_point(size=3) + 
  geom_smooth(aes(factor=years), se=FALSE, size=1.2) + 
  ggtitle("Área promedio por día del año") + 
  theme(plot.title = element_text(lineheight=.8, face="bold", size=20)) + 
  xlab("Día del año") + 
  ylab(product) + 
  theme_bw() +
  theme(plot.title = element_text(lineheight=.8, face="bold", size=20), axis.title.x = element_text(face="bold", size=20), axis.text.x = element_text(angle=90, vjust=0.5, size=16), axis.title.y = element_text(face="bold", size=20), axis.text.y = element_text(size=16)) 

F5

#La grafica llamada "F5" al correrlo sale error debido a que se está utilizando el paquete de viridisLite, los comandos se cambiaron respecto script original

F6 <- ggplot(subset_stats, aes(factor(months), value_mean)) +
  geom_boxplot(fill="#2D708EFF") + 
  geom_jitter(width = 0) +  
  facet_wrap(~ years, ncol=3) +
  ggtitle("Valores promedio para cada mes y año") + 
  scale_x_discrete(breaks=months, labels=monthAbbrev) + 
  xlab("Mes") + 
  ylab(product) + 
  theme_bw() +
  theme(plot.title = element_text(lineheight=.8, face="bold", size=10), legend.position="none", axis.title.x = element_text(face="bold", size=10), axis.text.x = element_text(angle=90, vjust=0.5, size=10), axis.title.y = element_text(face="bold", size=10), axis.text.y = element_text(size=5))

F6


