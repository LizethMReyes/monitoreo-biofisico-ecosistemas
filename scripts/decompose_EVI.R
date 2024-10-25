#Limpiar el entorno de R
rm(list = ls()) #Limpia el entorno de trabajo (Elimina las variables y valores)
install.packages("devtools")
#----------------------------------#
# Carga las librerías necesarias.  #
#----------------------------------#
#Paquete ggplotimeseries
devtools::install_github("brisneve/ggplottimeseries")
library(tseries) #Para análisis de series temporales
library(readr) #Para leer archivos CSV
library(ggplottimeseries)
library(ggplot2)
library(tidyr)
#------------------------------------#
#  Define el nombre de las variables #
#------------------------------------#
#Nota: Asegurate de proporcionar la ruta la ruta correcta de tu archivo 
EVI <- read_csv("C:/usumacinta/EVI_2.csv")
#------------------------------------#
#        Visualizar los datos        #
#------------------------------------#
View(EVI)
print(EVI)
#Lista los primeros registros de las tablas
head(EVI)

#---------------------------------------------#
# Identificar las caracteristicas del dataset #
#---------------------------------------------#
#La siguiente línea muestra un resumen estadístico de la tabla
summary(EVI)

#---------------------------------------------#
#       Asignar el tipo de dato correcto      #
#---------------------------------------------#
# Convertir la columna fecha a tipo date
EVI$Date <- as.Date(EVI$Date, format = "%d/%m/%y")
#Convertir la columna de la variable a tipo númerico
EVI$EVI <- as.numeric(EVI$EVI)

#------------------------------------------------------------#
# Verificar que los cambios se hayan aplicado correctamente  #
#------------------------------------------------------------#
summary(EVI)

#------------------------------------------------------------#
# Extraer la variable de la que se desea obtener la descomposición #
#------------------------------------------------------------#
EVI_var <- EVI$EVI

#-------------------------#
# Crear la serie temporal #
#-------------------------#
# `Precipitacion_var`: Vector de datos que contiene las observaciones
# `start`: inicio de la serie temporal--> c(1980, 1). Comienza en el día 1 de 1980
# `end`: final de la serie temporal --> c(2022, 365). Finaliza en el día 365 de 2022
# `freq': indica la frecuencia de muestreo de datos. Diarios: 365. Quincenales: 24. Semanales:12.
serie_temporal <- ts(EVI_var, start=c(2000, 1), end=c(2024, 1), freq=23)

# Descompone las series temporales
descomposicion <- decompose(serie_temporal)

# Gráfica de la descomposición de la serie
plot(descomposicion)


df <- dts2(serie_temporal, type ="additive")
ggdecompose(df)+
  xlab("Date")+
  ylab("Comportamiento de EVI 2000-2024") + 
  theme_minimal()
