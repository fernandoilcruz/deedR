#' Download data from DEEDados
#'
#' @description This function allows the user to download data from DEEDados API.
#'
#' @param id The variable's ID.
#' @param ag The regional aggregation. One of "municipio", "corede", "microrregiao", "mesorregiao".
#' @param period The year to consult.
#' @param sort If the user wants to sort from "ASC" for ascendent order or "DESC" for descendent order. Default is "ASC".
#'
#' @return a data.frame
#' @export
#'
#' @examples
#' my_data <- getdata(id = 4845,ag = "corede",period = c(2016,2017))
#' print(my_data)
#' print(my_data$data)
#'
getdata <-
  function(id = id,
           ag = ag,
           period = periodo,
           sort = "ASC"){

    x <- paste0("https://dados.dee.rs.gov.br/api/data.php?",
                "id=",
                id,
                "&ag=",
                ag,
                "&periodo=",
                period |> paste0(collapse = ","),
                "&sort=",
                sort
    )

    jsonlite::fromJSON(x)

  }
