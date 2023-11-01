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

    #url_arvore <- paste0("https://dados.dee.rs.gov.br/php2/getjson_arvore.php?exibevariaveis=1")

    api <- httr::GET(url_arvore)

    api_content <- base::rawToChar(api$content)

    data <- jsonlite::fromJSON(api_content,
                                simplifyVector = FALSE) #pra deixar como lista, igual ao pacote rjson


    jsTreeR::jstree(data$children,
                    checkboxes = T,
                    search = T)

  }
