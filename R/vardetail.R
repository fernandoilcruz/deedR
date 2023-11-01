#' Check vars details
#'
#' @description Check the details of a variable, by searching for it's id.
#'
#' @param id
#'
#' @return A list
#' @export
#'
#' @examples
#' vardetails(id = 4049)
#'
vardetails <-
  function(id){
    x <- paste0("https://dados.dee.rs.gov.br/api/var.php",
                "?id=",id) |>
      jsonlite::fromJSON()

    return(x)
  }


