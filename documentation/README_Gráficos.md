# Código para Visualizar Coordenadas Paralelas de Series de Tiempo

**Autores:** Fernanda Serna [![ORCID](https://img.shields.io/badge/ORCID-0000--0002--1825--0097-green.svg)](https://orcid.org/0000-0002-7179-0009), Lizeth Reyes [![ORCID](https://img.shields.io/badge/ORCID-0000--0002--1825--0097-green.svg)](https://orcid.org/0009-0004-2110-4877)

**Fecha:** 10 de junio de 2023  
**Contacto:** ssocialsig@institutomora.edu.mx  
**Repositorio:** [![Repositorio](https://img.shields.io/badge/GitHub-Repo-blue.svg)](https://github.com/LizethMReyes/monitoreo-biofisico-ecosistemas?tab=readme-ov-file) [Monitoreo biofísico de ecosistemas para apoyar la gestión de recursos 🌱🌞🦎🌎📑📊](https://github.com/LizethMReyes/monitoreo-biofisico-ecosistemas?tab=readme-ov-file)

---

## Generalidades
Este código muestra cómo visualizar los datos de diversas variables como el índice de vegetación realzado (EVI, por sus siglas en inglés) y la evapotranspiración real (ET) para una cobertura de vegetación en el territorio de México. Además, se añade una serie de tiempo de la precipitación acumulada diaria obtenida de una o más estaciones del Servicio Meteorológico Nacional (SMN), ubicada dentro del polígono de la cobertura analizada.

## Fuentes de Datos
Los datos a analizar son archivos de formato Excel que se generaron a partir de la consulta en la herramienta [APPEARS](https://appeears.earthdatacloud.nasa.gov/) para las variables EVI y ET. En el caso de los datos de estaciones meteorológicas, estos se obtuvieron en la página del [SMN](https://smn.conagua.gob.mx/es/climatologia/informacion-climatologica/informacion-estadistica-climatologica), a través de Google Earth. El nombre de la tabla de entrada es `BD_Fracc_EVA.xlsx`. En este ejemplo se utilizan los datos de coberturas de la cuenca del Río Usumacinta en México.

## Requerimientos
- R v.4.2.x
- Asegurarse de que los datos de entrada se encuentren en el directorio de trabajo.

## Salidas
1. Gráficos de series de tiempo paralelos de ET y EVI.
2. Gráfico de precipitación en formato de barras.

Para mayores detalles sobre el proyecto y las fuentes de datos, acceder al [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.13984409.svg)](https://doi.org/10.5281/zenodo.13984409)
 en Zenodo.

---
