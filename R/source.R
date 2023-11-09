#' Source
#'
#' @description Get sources list from system
#' @return data.frame
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
      tibble::as_tibble()
  }
