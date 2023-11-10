#' Download data from DEEDados
#'
#' @description This function allows the user to download data from DEEDados API using R.
#'
#' @param id The variable's ID.
#' @param ag The regional aggregation. There are  four valid options:
#' * "municipio" (the default): for municipalities.
#' * "corede": for coredes, a state-specific planning regionalization.
#' * "meso": for IBGE's mesoregions.
#' * "micro": for IBGE's microregions.
#' @param period The year to consult. It allows single string (ex:2010), vector(ex:c(2010,2022) or "all")
#' @param sort If the user wants to sort from "ASC" for ascendent order or "DESC" for descendent order. Default is "ASC".
#'
#' @return a data.frame
#' @export
#'
#' @examples
#' #Example 1
#' my_data <- getdata(id = 4845,ag = "corede",period = c(2016,2017))
#' print(my_data)
#' print(my_data$data)
#'
#' #Example 2
#' my_data <- getdata(id = 4845,ag = "corede",period = "all")
#'
getdata <-
  function(id,
           ag,
           period,
           sort = "ASC"){

    periodo <- period

    x <- paste0("https://dados.dee.rs.gov.br/api/data.php?",
                "id=",
                id,
                "&ag=",
                ag,
                "&periodo=",
                period |> paste0(collapse = ","),
                "&sort=",
                sort
    ) |>
      jsonlite::fromJSON() |>
      tidyr::unnest(cols = data)

    return(x)

  }
