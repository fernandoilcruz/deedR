#' Geographic Aggregation
#'
#' @description Check ID and name of geographic aggregations. For municipalities, latitude and longitude are also available.
#'
#' @param ag Aggregation category. There are  four valid options:
#' * "municipio" (the default): for municipalities.
#' * "corede": for coredes, a state-specific planning regionalization.
#' * "meso": for IBGE's mesoregions.
#' * "micro": for IBGE's microregions.
#'
#' @param sort This is used for sorting names from A to Z ("ASC") or Z to A ("DESC").Default is "ASC".
#'
#' @return a data.frame.
#' @export
#'
#' @examples
#' geoagreg()
#' geoagreg(ag = "municipio")
#' geoagreg(ag = "corede", sort = "DESC")
#'
geoagreg <-
  function(ag,
           sort){

    ag <- ifelse(missing(ag),"municipio",ag)

    sort <- ifelse(missing(sort),"ASC",sort)

    x <- paste0(
      "https://dados.dee.rs.gov.br/api/ag.php?",
      "ag=",ag,
      "&",
      "sort=",sort
    )

    jsonlite::fromJSON(x)
  }
