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

## -----------------------------------------------------------------------------

my_data <- 
  ft_table |>
  dplyr::left_join(
    data_muni,
    by = c("geo_id_municipio" = "geo_id",
           "geo_name_municipio" = "geo_name")
  ) |>
  dplyr::rename(value_municipio = value) |> 
  dplyr::left_join(
    data_micro,
    by = c("geo_id_micro" = "geo_id",
           "geo_name_micro" = "geo_name",
           "var_id" = "var_id",
           "var_name" = "var_name",
           "year" = "year",
           "unit" = "unit",
           "note" = "note")
  ) |> 
  dplyr::rename(value_micro = value) |>
  dplyr::left_join(
    data_meso,
    by = c("geo_id_meso" = "geo_id",
           "geo_name_meso" = "geo_name",
           "var_id" = "var_id",
           "var_name" = "var_name",
           "year" = "year",
           "unit" = "unit",
           "note" = "note")
  ) |> 
  dplyr::rename(value_meso = value) |>
  dplyr::left_join(
    data_corede,
    by = c("geo_id_corede" = "geo_id",
           "geo_name_corede" = "geo_name",
           "var_id" = "var_id",
           "var_name" = "var_name",
           "year" = "year",
           "unit" = "unit",
           "note" = "note")
  ) |>
  dplyr::rename(value_corede = value) |>
  dplyr::left_join(
    data_estado,
    by = c("geo_id_estado" = "geo_id",
           "geo_name_estado" = "geo_name",
           "var_id" = "var_id",
           "var_name" = "var_name",
           "year" = "year",
           "unit" = "unit",
           "note" = "note")
  ) |>
  dplyr::rename(value_estado = value) |>
  dplyr::filter(geo_name_municipio == "Gramado")


## -----------------------------------------------------------------------------
library(ggplot2)
#Transform the data to better fit our ggplot
idese <-
  my_data |>
  dplyr::mutate(year = paste0("01-01-",year) |> lubridate::dmy()) |>
  tidyr::gather(
    key = agregation,
    value = value,
    value_municipio,value_micro,value_meso,value_corede,value_estado
  ) |>
  dplyr::mutate(agregation = stringr::str_remove_all(agregation,"value_"))

#Build the graphs
idese_plot <-
  idese |>
  ggplot2::ggplot(
    ggplot2::aes(x = year,
                 y = value,
                 colour = agregation)
  ) +
  ggplot2::geom_line() +
  ggplot2::facet_wrap(~var_name, scales = "free_y", labeller = ggplot2::label_wrap_gen(width=20)) +
  ggplot2::theme(strip.text = ggplot2::element_text(size=8)) +
  ggplot2::ggtitle(label = "Gramado",
                   subtitle = "Idese and components")

#Plot it!
idese_plot


