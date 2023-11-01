#' List, filter and sort variables' ID and name
#'
#' @param sort Optional. A character string. Either "ASC" to sort from A to Z or "DESC" to sort from Z to A.
#' @param contains Optional. A character string to filter from the list of variables.
#'
#' @return a tibble
#' @export
#'
#' @examples
#' #Run this to see the full list of variables
#' vars()
#'
#' #You can also add arguments to filter and sort the list of variables
#' vars(sort = "ASC",contains = "Agricultura")
#'
#'
#'
#'
vars <-
  function(sort=NULL,
           contains = NULL){

    #Return url
    if(is.null(sort)){
      url <- paste0("https://dados.dee.rs.gov.br/api/var_list.php")
    }else{
      if(sort == "ASC"){
        url <- paste0("https://dados.dee.rs.gov.br/api/var_list.php?sort=",sort)
      }else{
        if(sort == "DESC"){
          url <- paste0("https://dados.dee.rs.gov.br/api/var_list.php?sort=",sort)
        }else{
          stop("Error. Choose ASC or DESC when using the optional argument sort.")
        }
      }
    }


    #Return vars list
    if(is.null(contains)){
      vars_list <- jsonlite::fromJSON(url) |>
        as_tibble()
    }else{
      vars_list <- jsonlite::fromJSON(url) |>
        as_tibble() |>
        dplyr::filter(stringr::str_detect(string = nome,pattern = contains))
    }

    return(vars_list)

  }
