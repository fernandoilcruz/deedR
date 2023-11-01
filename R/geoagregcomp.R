#' Geographic Aggregation Composition
#'
#' @description The geographic aggregation composition
#'
#' @param ag Aggregation category. There are  four valid options:
#' * "municipio" (the default): for municipalities.
#' * "corede": for coredes, a state-specific planning regionalization.
#' * "meso": for IBGE's mesoregions.
#' * "micro": for IBGE's microregions.
#' @param id Greographic unit ID
#' @param period Year
#'
#' @return data.frame
#' @export
#'
#' @examples
#' geoagregcomp(ag = "municipio", id = 22, period = 2004)
#'
geoagregcomp <-
  function(ag,
           id,
           period){

    x <- paste0(
      "https://dados.dee.rs.gov.br/api/composicao_ag.php?",
      "ag=",ag,
      "&id",id,
      "&periodo",period
      )

    jsonlite::fromJSON(x)

  }
