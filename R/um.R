#' Unity of Measurement
#'
#' @description Get list of unity of measurement from system
#'
#' @return data.frame
#'
#' @import jsonlite tidyverse
#'
#' @export
#'
#' @examples
#' um()
um <-
  function(){

    x <- paste0(
      "https://dados.dee.rs.gov.br/api/unid_medida.php"
    )

    jsonlite::fromJSON(x) |>
      tibble::as_tibble() |>
      dplyr::rename(
        um_id = id,
        um_name = nome,
        um_acronym = sigla
      )
  }
