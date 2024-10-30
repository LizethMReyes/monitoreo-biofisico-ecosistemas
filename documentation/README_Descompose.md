# Descomposición de Series de Tiempo de Variables Biofísicas

**Autor:** Fernanda Serna, Lizeth Reyes lizeth_reyes_irnr@outlook.com [![ORCID](https://img.shields.io/badge/ORCID-0000--0002--1825--0097-green.svg)](https://orcid.org/0009-0004-2110-4877)

**Fecha:** 10 de junio de 2022  
**Contacto:** ssocialsig@institutomora.edu.mx  
**Repositorio:** [![Repositorio](https://img.shields.io/badge/GitHub-Repo-blue.svg)](https://github.com/LizethMReyes/monitoreo-biofisico-ecosistemas?tab=readme-ov-file) [Monitoreo biofísico de ecosistemas para apoyar la gestión de recursos 🌱🌞🦎🌎📑📊](https://github.com/LizethMReyes/monitoreo-biofisico-ecosistemas?tab=readme-ov-file)



---

## Generalidades
Este documento muestra cómo realizar un análisis de descomposición para identificar los componentes de variación estacional, de tendencia y aleatorio que integran una serie de tiempo.

## Fuentes de Datos
Los datos a analizar son archivos de texto CSV que se generan a partir de la herramienta [TESViS](https://daac.ornl.gov/cgi-bin/dataset_lister.pl?p=12), [AppEEARS](https://appeears.earthdatacloud.nasa.gov/) o del conjunto de estaciones meteorológicas del SMN. Los archivos llevan por nombre `variable.csv`. En este ejemplo se utilizan los datos de precipitación y de temperatura del aire de una estación que se encuentra en la cuenca del Río Usumacinta en México, así como el índice EVI para dicha estación. Los datos corresponden a un caso de análisis de los patrones de precipitación, temperatura del aire y EVI en esta zona para el periodo 1980 a 2024.

## Requerimientos
- R v.4.2.x
- Asegurarse de que los datos de entrada `variable.csv` se encuentren en el directorio de trabajo.

## Salidas
1. Gráficos paralelos que muestran la descomposición de las series de tiempo en tendencia, variación estacional y componente aleatorio.

Para mayores detalles sobre el proyecto y las fuentes de datos, acceder al DOI en Zenodo.

---

