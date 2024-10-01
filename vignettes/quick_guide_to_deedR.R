## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  fig.width = 10, 
  fig.height = 10,
  comment = "#>"
)

## ----setup, warning = FALSE, message = FALSE, results = FALSE, echo = TRUE----
#Development version of the package
library(devtools)
devtools::install_github("fernandoilcruz/deedR")
#Load the package
library(deedR)

## -----------------------------------------------------------------------------
library(devtools)
devtools::install_github("fernandoilcruz/deedR")

deedR::geoagreg(ag = "corede")

## -----------------------------------------------------------------------------
deedR::geoagregcomp(ag = "corede", geo_id = 7)

## -----------------------------------------------------------------------------
vars_corede_ex_2013 <-
  deedR::vars(contains = "Idese") |> 
  dplyr::filter(stringr::str_detect(string = var_name, pattern = "2013", negate = TRUE))

vars_corede_ex_2013

## -----------------------------------------------------------------------------
ids <- 
  vars_corede_ex_2013 |>
  dplyr::select(var_id) |> 
  dplyr::pull()
  

deedR::vardetails(var_id = ids)

## ----eval = FALSE-------------------------------------------------------------
#  help(package = "deedR", "getdata")

## -----------------------------------------------------------------------------
data_muni <-  
  deedR::getdata(var_id = ids, ag = "municipio", period = "all", add_names = TRUE) |>
  dplyr::mutate(value = 
                  value |>
                  stringr::str_replace_all(",","\\.") |>
                  as.numeric())
  
data_corede <- deedR::getdata(var_id = ids, ag = "corede", period = "all", add_names = TRUE) |>
  dplyr::mutate(value = 
                  value |>
                  stringr::str_replace_all(",","\\.") |>
                  as.numeric())

data_meso <- deedR::getdata(var_id = ids, ag = "meso", period = "all", add_names = TRUE) |>
  dplyr::mutate(value = 
                  value |>
                  stringr::str_replace_all(",","\\.") |>
                  as.numeric())

data_micro <- deedR::getdata(var_id = ids, ag = "micro", period = "all", add_names = TRUE) |>
  dplyr::mutate(value = 
                  value |>
                  stringr::str_replace_all(",","\\.") |>
                  as.numeric())

data_estado <- 
  deedR::getdata(var_id = ids, ag = "estado", period = "all", add_names = TRUE) |>
  dplyr::mutate(value = 
                  value |>
                  stringr::str_replace_all(",","\\.") |>
                  as.numeric())

## -----------------------------------------------------------------------------
ft_table <-
  deedR::geoagregall2() |>
  dplyr::select(-period)

ft_table

