rm(list=ls())

library(readxl)
library(forecast)
library(xts)
library(lubridate)
library(cowplot)
library(ggplot2)
library(gridExtra)

ruta="C:/Users/ferna/Documents/Evapotranspiración AlejandroAlcudia/03 datos faltantes/gráficos/Base_datos_Final-171122.xlsx"

#........Gráficos de Pastizal Cuenca Alta.....................................
#Leemos base de datos
PastizalCA=read_excel(ruta,sheet="Pastizal_CA",range="A1:M272",col_names=T)
#Leemos como fecha la primer columna
PastizalCA$Fecha=as.Date(PastizalCA$Fecha,format=c("%Y-%m-%d"))

#Revisamos rango de cada variable
ET=PastizalCA$Promedio_C_Alta_Pastizal_ET
range(ET)
EVI=PastizalCA$C_Alta_Pastizal_EVI
range(EVI)
Precip=PastizalCA$Mediana_CA_Pastizal_SMN
range(Precip)
#Como ET y EVI tienen rangos más pequeños vamos a fusionarlas 
#en una gráfica
N=range(ET)[2]/range(EVI)[2]#aprox 8
#Precip estará en otro gráfico por tener la escala más pequeña


#Generamos las gráficas
tabla1=data.frame("fecha"=PastizalCA$Fecha,"ET"=ET,"EVI"=EVI)
tabla2=data.frame("fecha"=PastizalCA$Fecha,"Precip"=Precip)


graf1=ggplot(tabla1,aes(x=fecha))+
        geom_line(aes(y=ET),colour="black",linetype=5)+
        geom_line(aes(y=EVI*30),size=1,colour="springgreen4")+
        theme_minimal() +  
        #theme(panel.grid = element_blank())+
        labs(y="ET(mm)",x="Time full")+
        scale_y_continuous(sec.axis=sec_axis(~./30,name="EVI"))+
        theme(axis.text.y   = element_text(size=12),
              axis.text.x   = element_text(size=12),
              axis.title.y  = element_text(size=12),
              axis.title.x  = element_text(size=12),
              panel.border = element_rect(colour = "black", fill=NA))
graf2=ggplot(tabla2)+geom_col(aes(x=fecha,y=Precip),colour="royalblue4")+ 
        theme_minimal() +
        labs(y="Precipitation(mm)",x="Time full")+
        theme(axis.text.y   = element_text(size=12),
              axis.text.x   = element_text(size=12),
              axis.title.y  = element_text(size=12),
              axis.title.x  = element_text(size=12),
              panel.border = element_rect(colour = "black", fill=NA))
#graf2=ggplot(tabla2)+geom_line(aes(x=fecha,y=EVI),colour="springgreen4")+ 
#        theme_minimal() +
#        labs(title="EVI",y="EVI")#+theme(panel.grid = element_blank())


x11()
grid.arrange(graf1, graf2)
#