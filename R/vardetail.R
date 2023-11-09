#' Check vars details
#'
#' @description Check the details of a variable, by searching for it's id.
#'
#' @param id Variable's ID. It can be a single string or a vector.
#'
#' @return A tibble
#' @export
#'
#' @examples
#' vardetails(id = 4049)
#' vardetails(id = c(4049,4031))
#'
vardetails <-
  function(id){

    n <- length(id)

    if(missing(id)){
      stop("Choose an ID for the id argument. You can use the DEEDadosR::vars function to search for the id you wish.")
    }else{
      if(n == 1){
        x <- paste0("https://dados.dee.rs.gov.br/api/var.php",
                    "?id=",id) |>
          jsonlite::fromJSON() |>
          tibble::as_tibble()
      }else{
        x <- id |>
          map_df(.f = function(id){
            paste0("https://dados.dee.rs.gov.br/api/var.php",
                   "?id=",id) |>
              jsonlite::fromJSON() |>
              tibble::as_tibble()
          })
      }
    }
    return(x)
  }


