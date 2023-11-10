#' Geographic Aggregation Composition
#'
#' @description The geographic aggregation composition. Be aware that municipalities do not have
#'
#' @param ag Aggregation category. There are  three valid options:
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
#' geoagregcomp(ag = "meso", id = 10, period = 2020)
#'
geoagregcomp <-
  function(ag,
           id,
           period){

    x <- paste0(
      "https://dados.dee.rs.gov.br/api/composicao_ag.php?",
      "ag=",ag,
      "&id=",id,
      "&periodo=",period
      ) |>
      jsonlite::fromJSON()

    return(x)

  }
