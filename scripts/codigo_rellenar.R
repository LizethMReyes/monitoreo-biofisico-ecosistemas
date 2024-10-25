rm(list=ls())
#asignar la ruta adecuada donde se encuentran los datos de entrada
dir="C:/usumacinta/estacion7029"
setwd(dir)

#Bibliotecas y Funciones auxiliares
#-----------------
library("tseries")
library("xts")
library('dplyr')
library('lubridate')
library(imputeTS)
library(forecast)
library(MASS)

#funci?n para simular 1 trayectoria
trayectoria_sim=function(ST,p0,pp,shape,rate){
  #previo al ajuste quitamos NA
  vacios=which(is.na(ST)==T)
  ST1=ST[-vacios]
  #continuamos con trayectoria
  m=length(ST1)
  sim=numeric(m)
  moneda=runif(m,0,1)
  for(i in 1:m){
    if(moneda[i]<p0){sim[i]=0}else{
      sim[i]=rgamma(1,shape=shape,rate=rate)}}
  return(sim)}

#funci?n para simular 1000 trayectorias
trayectorias_sim=function(ST,p0,pp,shape,rate){
  #previo a simulaciones quitamos NA
  vacios=which(is.na(ST)==T)
  ST1=ST[-vacios]
  #continuamos con ajuste
  m=length(ST1)
  Sim=matrix(0,ncol=m,nrow=1000)
  for(j in 1:1000){
    Sim[j,]=trayectoria_sim(m,p0,pp,shape,rate)}
  return(Sim)}

#funci?n que genera 1000 trayectorias simuladas y escoge el mejor candidato
trayectoria=function(m,Sim,ST){
  x=numeric(m)
  x=apply(Sim,2,mean)
  rr=round(cor(sort(ST),sort(x)),4)
  return(list("path"=x,"cor"=rr))}
  
#funci?n que guarda en una lista los datos de precipitaci?n por mes
indicesXmes=function(ST_mes,ST_precip){
  lista=list(NULL)
  for(i in 1:12){
    mes_i=which(ST_mes==i)
    lista[[i]]=ST_precip[mes_i]}
  return(lista)}

#Lista con nombres de meses
Mes=c("Ene","Feb","Mar","Abr","May","Jun","Jul","Ago","Sep","Oct","Nov","Dic")

#funci?n que elabora el ajuste de distribuci?n gamma a un vector de 
#datos de precipitaci?n x mes
Ajuste=function(m,ST){
  #previo al ajuste quitamos NA
  vacios=which(is.na(ST)==T)
  ST1=ST[-vacios]
  #continuamos con ajuste
  x=min(ST1)
  if(x==0){
    y0=which(ST1==0)
    yp=ST1[-y0]
    p0=length(y0)/m
    pp=1-p0
    ajuste=fitdistr(yp,"gamma")
    forma=ajuste$estimate[1]
    tasa=ajuste$estimate[2]
    return(c(p0,pp,forma,tasa))}else{
      ajuste=fitdistr(ST1,"gamma")
      forma=ajuste$estimate[1]
      tasa=ajuste$estimate[2]
      return(c(0,0,forma,tasa))}
}

sim_gamma=function(mes,shape,rate,pp,p0){
  #funcion de probabilidad que genera una observacion cero o gamma
  x=runif(1,0,1)
  if(x<p0){a=0}else{a=rgamma(1,shape=shape,rate=rate)}
  return(a)}

find_leap = function(x){
  #funcion para encontrar dias de a?os bisiestos
  day(x) == 29 & month(x) == 2}

convertir_fecha=function(x){
  y=as.Date(paste(x,collapse="-"))
  return(y)}



#-----------------


#leemos bases de datos de daymet y de SMN
#__________________________________________________________
daymet7029=read.csv("est_7029.csv",header=T,sep=";")
daymet7029_precip=daymet7029$prcp..mm.day.
SMN7029=read.csv("7029.csv",header=T,sep=",")
SMN7029_precip=SMN7029$`Precipitacion`
#__________________________________________________________


#_______Realizamos ajuste de distribuciones gamma y graficamos ajuste___________
#_______________________________________________________________________________

#Generamos vectores de datos x mes
PrecipXmes=indicesXmes(SMN7029$Mes,SMN7029$`Precipitacion`)
#Generamos ajuste de distribuci?n (gamma o alternativa)
#Gr?ficas que muestren el ajuste
#y trayectoria estimada
parametros=matrix(0,ncol=4,nrow=12)

for(i in 1:12){
  precip=PrecipXmes[[i]]
  n=length(precip)
  ajuste_i=Ajuste(n,precip)#vector de par?metros
  parametros[i,]=ajuste_i#matriz que va guardando par?metros
  p_ceros=ajuste_i[1]
  p_posit=ajuste_i[2]
  forma=ajuste_i[3]
  tasa=ajuste_i[4]
  trayect_estimada=trayectoria_sim(precip,p_ceros,p_posit,forma,tasa)
  r1=cor(sort(trayect_estimada),sort(precip[-which(is.na(precip)==T)]))
  r2=round(r1,4)
  #Gr?fica x mes
  x11()
  plot(density(sort(trayect_estimada)),col="blue2",main=paste(c(Mes[i],' corr=',r2),collapse=""),type="p",pch=20)
  points(density(sort(precip)),col="red")
  legend("topright",c("obs","est"),text.col=c("red","blue"),pch=c(1,20),col=c("red","blue2"))
  }

colnames(parametros)=c("p0","pp","forma","tasa")
write.csv(parametros,file="parametros.csv")
#______________________________Rellenar NA__________________________
#___________________________________________________________________

#Generamos fechas para comparar con daymet
start.date=as.Date("1980-01-01")
end.date=as.Date("2021-12-31")
time.index=seq(start.date, by=1, end.date)
time.index2=time.index[find_leap(time.index)==F]#quitamos 29-feb
time.index3=as.Date(NULL)
for(i in 1:dim(SMN7029)[1]){
  time.index3=c(time.index3,convertir_fecha(SMN7029[i,1:3]))}

filas=dim(daymet7029)[1]

X=matrix(0,ncol=2,nrow=filas)
orden_guardado=NULL
for(i in 1:dim(SMN7029)[1]){
  orden_fecha_daymet=which(time.index2==time.index3[i])
  orden_guardado=c(orden_fecha_daymet,orden_guardado)
  X[orden_fecha_daymet,1]=SMN7029$`Precipitacion`[i]}
#rellenamos de NA donde no hay datos de la estacion 7391 del SMN
X[-orden_guardado,1]=rep(NA,filas-length(orden_guardado))
#segunda columna son datos de daymet
X[,2]=daymet7029$prcp..mm.day.
#construimos data.frame con las dos bases de datos
X1=data.frame("fecha"=time.index2,"SMN7029_NA"=X[,1],"daymet7029"=X[,2])
X1$D=as.numeric(format(X1[,1],'%d'))
X1$M=as.numeric(format(X1[,1],'%m'))
X1$A=as.numeric(format(X1[,1],'%Y'))

parametros1=data.frame(parametros)

NAs=which(is.na(X1[,2])==T)
nas=length(NAs)
for(i in 1:nas){
  for(j in 1:12){
    if(X1$M[NAs[i]]==j){
      a=parametros1$forma[j]
      b=parametros1$tasa[j]
      c=parametros1$pp[j]
      d=parametros1$p0[j]
      X1$SMN7029[NAs[i]]=sim_gamma(j,a,b,c,d)}}}


write.csv(X1,file="X1.csv")

ST_SMN7029=ts(X1$SMN7029,start=c(1980,1),end=c(2021,365),freq=365)
ST_daymet7029=ts(X1$daymet7029,start=c(1980,1),end=c(2021,365),freq=365)
x11()
par(mfrow=c(2,1))
plot(ST_SMN7029)
plot(ST_daymet7029)

x11()
plot(sort(X1$SMN7029),sort(X1$daymet7029))

cor(sort(X1$SMN7029),sort(X1$daymet7029))
#  

ST_SMN7029=ts(X1$SMN7029,start=c(1980,1),end=c(2021,365),freq=365)
ST_daymet7029=ts(X1$daymet7029,start=c(1980,1),end=c(2021,365),freq=365)
x11()
plot(decompose(ST_SMN7029))
x11()
plot(decompose(ST_daymet7029))

