#' Geographic Aggregation
#'
#' @description Check ID and name of geographic aggregations. For municipalities, latitude and longitude are also available.
#'
#' @param ag Character. The aggregation category. There are  four valid options:
#' * "municipio" (the default): for municipalities.
#' * "corede": for coredes, a state-specific planning regionalization.
#' * "meso": for IBGE's mesoregions.
#' * "micro": for IBGE's microregions.
#'
#' @param sort Character. This is used for sorting names from A to Z ("ASC") or Z to A ("DESC").Default is "ASC".
#'
#' @return a data.frame.
#' @export
#'
#' @import jsonlite checkmate tidyverse
#' @importFrom utils data
#'
#' @examples
#' geoagreg()
#' geoagreg(ag = "municipio")
#' geoagreg(ag = "corede", sort = "DESC")
#'
geoagreg <-
  function(ag = "municipio",
           sort = "ASC"){

    #check arguments
    checkmate::assert_character(ag)
    checkmate::assert_character(sort)

    #check available arguments
    ags <- c("municipio", "corede", "meso", "micro")
    if(!ag %in% ags){stop(paste0("Error: the ag argument is only available for "),
                          paste(ags, collapse = ", "))}

    sorts <- c("ASC","DESC")
    if(!sort %in% sorts){stop(paste0("Error: sort argument is only available for"),
                                 paste(sorts, collapse = ", "))}


    #url
    url <-
      paste0(
        "https://dados.dee.rs.gov.br/api/ag.php?",
        "ag=",ag,
        "&",
        "sort=",sort)


    #output
    x <-
      url |>
      jsonlite::fromJSON() |>
      tibble::as_tibble() |>
      dplyr::rename("geo_id" = "id",
                    "geo_name" = "nome")


    return(x)

  }
