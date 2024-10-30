# Gráficos de Estadísticas de Datos del Sensor MODIS

**Autores:** Abigail Juárez [![ORCID](https://img.shields.io/badge/ORCID-0000--0002--1825--0097-green.svg)](https://orcid.org/0009-0001-3942-5976), Claudia Coronel [![ORCID](https://img.shields.io/badge/ORCID-0000--0002--1825--0097-green.svg)](https://orcid.org/0000-0002-8773-495X), Lizeth Reyes [![ORCID](https://img.shields.io/badge/ORCID-0000--0002--1825--0097-green.svg)](https://orcid.org/0009-0004-2110-4877)

**Fecha:** 14 de octubre de 2024  
**Contacto:** ssocialsig@institutomora.edu.mx  
**Script modificado a partir de:** Plot Statistics Output from the MODIS Global and Fixed Site Tools  
**Autor original:** ORNL DAAC  
**Fecha original:** April 4, 2018  
**Contacto para ORNL DAAC:** uso@daac.ornl.gov  
**Repositorio original:** [![Repositorio](https://img.shields.io/badge/GitHub-Repo-blue.svg)](https://github.com/LizethMReyes/monitoreo-biofisico-ecosistemas?tab=readme-ov-file) [Monitoreo biofísico de ecosistemas para apoyar la gestión de recursos 🌱🌞🦎🌎📑📊](https://github.com/LizethMReyes/monitoreo-biofisico-ecosistemas?tab=readme-ov-file) 


---

## Generalidades
Este documento muestra cómo visualizar las estadísticas generadas por el  [MODIS Global Tool](https://modis.ornl.gov/cgi-bin/MODIS/global/subset.pl) y el  [MODIS Fixed Sites Tool](https://modis.ornl.gov/sites/) a cargo de ORNL DAAC. Actualmente, se ofrecen 2 herramientas:
- **ORNL DAAC.** 2017. MODIS Collection 6 Land Products Fixed Sites Subsetting and Visualization Tool. ORNL DAAC, Oak Ridge, Tennessee, USA. [DOI](https://doi.org/10.3334/ORNLDAAC/1567)
- **ORNL DAAC.** 2017. MODIS Collection 6 Land Products Global Subsetting and Visualization Tool. ORNL DAAC, Oak Ridge, Tennessee, USA. [DOI](https://doi.org/10.3334/ORNLDAAC/1379)

## Fuentes de Datos
Los datos a analizar son archivos de texto CSV que se generan a partir de cualquiera de las herramientas mencionadas, que llevan por nombre `statistics_[modis_product_band].csv`. En este ejemplo se utilizan las estadísticas de MOD11A2 (Temperatura de Superficie Terrestre) calculadas para el sitio fijo que el usuario elija. Se sugiere el conjunto de datos del sitio **Sonora Alamos**, ya que es un sitio del cual somos coproductores de datos. [Información del sitio Sonora Alamos](https://modis.ornl.gov/sites/?id=mx_sonora_alamos_mid_secondary_tropical_dry_forest).

Una vez solicitado el o los productos, las estadísticas descriptivas se encuentran disponibles en la sección de descarga de datos de la herramienta, específicamente en la pestaña **Summary Statistics**. Nota: es necesario acceder como usuario de Earthdata; en caso de no tener un usuario asignado, registrar uno a partir del botón **Sign in** en la esquina superior derecha de la herramienta.

Si se quiere probar este script, se acompaña con 2 conjuntos de datos de temperatura de superficie.

## Requerimientos
- R v.3.x
- Asegurarse de que los datos de entrada `statistics_[modis_product_band].csv` se encuentren en el directorio de trabajo.

## Salidas
1. Gráfico del valor promedio y la variación de un subconjunto de los datos (68% de los datos alrededor del promedio), respecto del tiempo.
2. Gráfico de dispersión de promedios por mes.
3. Gráfico de dispersión de promedios por año.
4. Histograma de todos los valores promedio.
5. Series de tiempo de valores promedio mostrando la variación por día del año y curvas suavizadas ajustadas para cada año.
6. Gráficos de dispersión de valores promedio agrupados por mes y año.

---
