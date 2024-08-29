#' @title deetree
#'
#' @description
#' This function function plots the DEEDados tree. It is useful for exploring the available datasets at DEEDados.
#'
#'
#' @return A Json Tree
#'
#' @import jsonlite jsTreeR httr tidyverse
#'
#' @export
#'
#' @examples
#' deetree()
#'
deetree <-
  function(){

    url_arvore <- paste0("https://dados.dee.rs.gov.br/api/arvore.php")

    api <- httr::GET(url_arvore)

    api_content <- base::rawToChar(api$content)

    data <- jsonlite::fromJSON(api_content,
                                simplifyVector = FALSE)

    jsTreeR::jstree(data$children,
                    checkboxes = T,
                    search = T
                    )
  }
