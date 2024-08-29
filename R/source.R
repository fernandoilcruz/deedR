#' Source
#'
#' @description Get sources list from system
#' @return data.frame
#'
#' @import jsonlite tidyverse
#'
#' @export
#'
#' @examples
#' source()
#'
source <-
  function(){

    x <- paste0(
      "https://dados.dee.rs.gov.br/api/fonte.php"
    )

    jsonlite::fromJSON(x) |>
      tibble::as_tibble() |>
      dplyr::rename(var_id_source = id,
                    name_id_source = nome)
  }
