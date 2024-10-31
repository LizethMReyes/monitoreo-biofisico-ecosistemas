# Código para Completar Datos de Estaciones Meteorológicas: Proyecto Huamantla

Este repositorio contiene un script para completar datos de precipitación acumulada diaria en estaciones meteorológicas como parte del proyecto Huamantla. Este código fue adaptado para el proyecto y se basa en un script original diseñado para rellenar datos faltantes de precipitación acumulada diaria.

- **Autores del script original:** Fernanda Serna [![ORCID](https://img.shields.io/badge/ORCID-0000--0002--1825--0097-green.svg)](https://orcid.org/0000-0002-7179-0009), Lizeth Reyes [![ORCID](https://img.shields.io/badge/ORCID-0000--0002--1825--0097-green.svg)](https://orcid.org/0009-0004-2110-4877)
- **Fecha del script original:** 10 de junio de 2022
- **Autores de esta versión:** Abigail Juárez [![ORCID](https://img.shields.io/badge/ORCID-0000--0002--1825--0097-green.svg)](https://orcid.org/0009-0001-3942-5976), Lizeth Reyes [![ORCID](https://img.shields.io/badge/ORCID-0000--0002--1825--0097-green.svg)](https://orcid.org/0009-0004-2110-4877)
- **Fecha de actualización:** 10 de junio de 2023
- **Contacto:** [ssocialsig@institutomora.edu.mx](mailto:ssocialsig@institutomora.edu.mx)
- **Repositorio en GitHub:** [Análisis de precipitación](https://github.com/LizethMReyes/Analisis_de_Precipitacion)

---

## Generalidades

Este documento detalla el proceso de visualización y análisis de datos de precipitación acumulada diaria obtenidos de las estaciones del Servicio Meteorológico Nacional (SMN). A través de Google Earth, se pueden consultar y acceder a estos datos, así como al *Manual de Usuario*, el cual explica cómo utilizarlos.

El enfoque del proyecto es analizar patrones de precipitación en el estado de Tlaxcala, México, durante el periodo de 1980 a 2020. Los datos de las estaciones meteorológicas se comparan con estimaciones de precipitación diaria de *Daymet*, accesibles mediante la plataforma TESVIS o scripts en Python disponibles en la carpeta de *extracción de datos* de este repositorio. El objetivo es aplicar un algoritmo basado en modelos de distribución gamma para estimar datos faltantes.

---

## Fuentes de Datos

Los datos de entrada se obtienen de archivos en formato CSV generados a partir de los archivos *EstacionesClimatologicas.kmz*. Estos archivos contienen datos climáticos de estaciones meteorológicas en Tlaxcala, México, y son clave para el análisis de precipitación acumulada en el periodo de 1980-2020.

Además, los datos estimados por *Daymet* permiten una comparación directa con los registros de las estaciones y sirven como referencia para evaluar el rendimiento del modelo gamma en el relleno de datos faltantes.

## Requerimientos

- **Software**: R v.4.2.x
- **Datos de entrada**:
  - Archivos CSV en el siguiente formato:
    - `est_numero_de_la_estacion.csv` (ejemplo: `est_21007.csv`)
    - `numero_de_la_estacion.csv` (ejemplo: `21007.csv`)
- Asegúrate de que los archivos de entrada estén en el directorio de trabajo.

## Salidas

El script genera los siguientes resultados:

1. **Gráficos de dispersión**: Visualizan los datos observados rellenados mediante el modelo gamma y los datos de *Daymet*.
2. **Parámetros conjuntos**: Un archivo CSV con los parámetros del modelo nombrado como `parametros_numero_de_la_estacion.csv`.
3. **Archivo combinado**: Un archivo CSV (`X1_numero_de_la_estacion.csv`) que consolida los datos observados de la estación, los generados por *Daymet* y los rellenados con el modelo gamma.
4. **Gráfico de correlación**: Dispersión de los datos generados por *Daymet* frente a los datos observados rellenados con gamma.
5. **Descomposición de series de tiempo**: Visualización de la serie temporal en sus componentes de datos observados, tendencia, estacionalidad y ruido.
6. **Comparación de series de tiempo**:
   - Gráfico comparativo de datos observados y datos observados rellenados con gamma.
   - Gráfico comparativo de datos observados rellenados con gamma y datos generados por *Daymet*.

---

## Más Información

Para mayores detalles sobre el proyecto y las fuentes de datos, acceder al [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.13984409.svg)](https://doi.org/10.5281/zenodo.13984409)
 en Zenodo.

---

Si tienes alguna pregunta o necesitas más ayuda, contacta a los autores a través del correo proporcionado. ¡Gracias por tu interés en este proyecto!

