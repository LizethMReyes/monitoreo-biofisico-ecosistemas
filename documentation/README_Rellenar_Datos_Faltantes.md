# Código para Rellenar Datos Faltantes de Precipitación Acumulada Diaria de Estaciones Meteorológicas

**Autores:** Fernanda Serna, Lizeth Reyes  
**Fecha:** 10 de junio de 2022  
**Contacto:** ssocialsig@institutomora.edu.mx  
**Repositorio:** [monitoreo-biofisico-ecosistemas](https://github.com/LizethMReyes/monitoreo-biofisico-ecosistemas?tab=readme-ov-file)  

---

## Generalidades
Este documento muestra cómo visualizar los datos de precipitación acumulada diaria obtenidos de las estaciones del Servicio Meteorológico Nacional (SMN). A través del programa Google Earth se puede consultar y acceder a los datos de dichas estaciones. En la misma página donde se descargan los datos se puede acceder al Manual de usuario que explica cómo hacer uso de estos datos. Esta información se compara con los patrones de precipitación acumulada diaria que estima Daymet, los cuales pueden accederse a través de la plataforma TESVIS o mediante script en Python, el cual se puede encontrar en la carpeta extracción de datos de este repositorio. Debido a que los datos de estaciones suelen presentar vacíos de información, se recomienda emplear este script para completar los datos faltantes. El algoritmo se basa en un modelo de distribución Gamma que se caracteriza por presentar un sesgo hacia los valores más pequeños y una dispersión mayor hacia los valores más altos. Se generan gráficos de ajuste a un modelo gamma para que el usuario decida si la estimación de los datos faltantes es adecuada.

## Fuentes de Datos
Los datos a analizar son archivos de texto CSV que se generan a partir de la herramienta mencionada arriba, que llevan por nombre `datos_completos.csv`. El primer archivo corresponde a datos de una estación del SMN y el segundo a los datos de Daymet para la misma locación de la estación del SMN. En este ejemplo se utilizan los datos de estaciones que se encuentran en la cuenca del Río Usumacinta en México, que corresponden a un caso de análisis de los patrones de precipitación en esta zona para el periodo 1980 a 2021.

## Requerimientos
- R v.4.2.x
- Asegurarse de que los datos de entrada sean:
  1. `est_numero_de_la_estacion.csv` (por ejemplo: `est_29011.csv`)
  2. `numero_de_la_estacion.csv` (por ejemplo: `29011.csv`)
  
Estos archivos deben encontrarse en el directorio de trabajo.

## Salidas
1. Gráficos de dispersión mensuales de los datos observados rellenados por gamma y de los datos de Daymet.
2. Archivo CSV que genera los parámetros conjuntos, nombrado como `parametros_numero_de_la_estacion.csv`.
3. Archivo CSV que junta los datos observados de la estación, los datos generados por Daymet y los datos observados rellenados por gamma, nombrando como `X1_numero_de_la_estacion.csv`.
4. Gráfico de dispersión que correlaciona los datos generados por Daymet y los datos observados rellenados por gamma.
5. Gráfico que muestra la descomposición de las series de tiempo divididos en: observados, tendencia, estacional y aleatorio.
6. Gráfico de tendencia comparativo de los datos observados con los datos observados rellenados con gamma.
7. Gráfico de tendencia comparativo de los datos rellenados por gamma y los generados con Daymet.

Para mayores detalles sobre el proyecto y las fuentes de datos, acceder al DOI en Zenodo.

---
