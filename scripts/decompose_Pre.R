#Limpiar el entorno de R
rm(list = ls())

#-------------------------------------#
# Instalar las librerías necesarias  #
#-----------------------------------#
# Verificar si los paquetes están instalados y si no, instalarlos
if (!requireNamespace("tseries", quietly = TRUE)) {
  install.packages("tseries")
}
if (!requireNamespace("readr", quietly = TRUE)) {
  install.packages("readr")
}
#----------------------------------#
# Carga las librerías necesarias.  #
#----------------------------------#
library(tseries) #Para análisis de series temporales
library(readr) #Para leer archivos CSV

#------------------------------------#
#  Define el nombre de las variables #
#------------------------------------#
#Nota: Asegurate de proporcionar la ruta la ruta correcta de tu archivo 
Precipitacion <- read_csv("C:/usumacinta/Precipitacion.csv")

#------------------------------------#
#        Visualizar los datos        #
#------------------------------------#
View(Precipitacion)
print(Precipitacion)
#Primero registros de las tablas
head(Precipitacion)

#---------------------------------------------#
# Identificar las caracteristicas del dataset #
#---------------------------------------------#
#La siguiente línea muestra un resumen estadístico de la tabla
summary(Precipitacion)

#---------------------------------------------#
#       Asginar el tipo de dato correcto      #
#---------------------------------------------#
# Convertir la columna fecha a tipo date
Precipitacion$Fecha <- as.Date(Precipitacion$Fecha, format = "%d/%m/%y")
#Convertir la columan a tipo númerico
Precipitacion$Precipitacion <- as.numeric(Precipitacion$Precipitacion)

#------------------------------------------------------------#
# Verificar que los cambios se hayan aplicado correctamente  #
#------------------------------------------------------------#
summary(Precipitacion)

#------------------------------------------------------------#
# Extraer la variable de la que se desea obtener la descomposición #
#------------------------------------------------------------#
Precipitacion_var <- Precipitacion$Precipitacion

#-------------------------#
# Crear la serie temporal #
#-------------------------#
# `Precipitacion_var`: Vector de datos que contiene las observaciones
# `start`: inicio de la serie temporal--> c(1980, 1). Comienza en el día 1 de 1980
# `end`: final de la serie temporal --> c(2022, 365). Finaliza en el día 365 de 2022
# `freq': indica la frecuencia de muestreo de datos. Diarios: 365. Quincenales: 24. Mensuales:12.
serie_temporal_diaria <- ts(Precipitacion_var, start=c(1980, 1), end=c(2022, 365), freq=365)

# Descompone las series temporales
descomposicion_diaria <- decompose(serie_temporal_diaria)

# Gráfica de la descomposición de la serie SMN
plot(descomposicion_diaria)

#-------------------------------------------------#
# Comparación de diferentes series temporales    #
#-----------------------------------------------#
#Descomposicion mensual 
serie_temporal_mensual <- ts(Precipitacion_var, start=c(1980, 1), end=c(2022, 365), freq=12)
# Descompone las series temporales
descomposicion_mensual <- decompose(serie_temporal_mensual)
# Gráfica de la descomposición de la serie SMN
plot(descomposicion_mensual)

#Filtro de datos
# Filtrar los datos para los últimos dos años
Periodo_final <- subset(Precipitacion, Fecha > as.Date("2020-12-31"))
# Visualizar el resumen de los datos de los últimos dos años
summary(Periodo_final)
Precipitacion_2021_2022 <- as.numeric(Periodo_final$Precipitacion)
ts_diara_2021 <- ts(Precipitacion_2021_2022, start=c(2021, 1), end=c(2022, 365), freq=365)
des_diaria_2021<- decompose(ts_diara_2021)
plot(des_diaria_2021)


