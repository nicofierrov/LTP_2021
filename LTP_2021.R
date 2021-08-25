# SERVICIOS COLEGIOS ------------------------------------------------------

rm(list = ls())
graphics.off()
opar <- par()

# LIBRERIAS ---------------------------------------------------------------

library(htmltools)
library(urltools)
library(httr)
library(sf)

Serv <- "https://services2.arcgis.com/J9qwSAKUNamTZp6S/arcgis/rest/services"

dataURI <- httr::parse_url(url = Serv)

dataURI$path <- paste(dataURI$path,
                      "Geoprovee/FeatureServer/0/query", 
                      sep = "/")

dataURI$query <- list(where = "Cla_LTP = '1'", # LTP
                      outfields = "*", # Variables que quiero extraer
                      returnGeometry = "true", # Devuelve geometria 
                      f = "geojson")

request <- httr::build_url(url = dataURI)

LTP2021 <- sf::st_read(dsn = request)

# Guardando .csv
write.csv(x = LTP2021, file = "LTP2021.csv")