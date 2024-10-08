#' Download data from DEEDados
#'
#' @description This function allows the user to download data from DEEDados API using R.
#'
#' @param var_id Numeric. The variable's ID.
#' @param ag Character. The regional aggregation. There are  five valid options:
#' * "municipio" (the default): for municipalities.
#' * "corede": for coredes, a state-specific planning regionalization.
#' * "meso": for IBGE's mesoregions.
#' * "micro": for IBGE's microregions.
#' * "estado": for the state of Rio Grande do Sul.
#' @param period The year to consult. It allows single string (ex:2010), vector(ex:c(2010,2022) or "all")
#' @param sort Charater. If the user wants to sort from "ASC" for ascendent order or "DESC" for descendent order. Default is "ASC".
#' @param add_names Logical. Allows the user to add the respective names to the id codes results
#'
#' @return a data.frame
#'
#' @import jsonlite tidyverse
#' @importFrom utils data
#'
#'
#'
#' @export
#'
#' @examples
#' #Example 1
#' my_data <- getdata(var_id = 4603,ag = "corede",period = c(2016,2017), add_names = TRUE)
#' print(my_data)
#' print(my_data$data)
#'
#' #Example 2
#' my_data <- getdata(var_id = 4603,ag = "corede",period = "all")
#' my_data <- getdata(var_id = 1686,ag = "corede",period = c(2010:2015))
#'
getdata <-
  function(var_id,
           ag,
           period = "all",
           sort = "ASC",
           add_names = FALSE){

    #Treats period
    period <- ifelse(period == "all",as.character(period),as.numeric(period))

    #check arguments
    checkmate::assert_character(ag)
    checkmate::assert_character(sort)
    checkmate::assert_numeric(var_id)
    checkmate::assert_logical(add_names)


    #check available arguments
    if(missing(var_id)){stop("Error: Select a valid argument for var_id. You can use the var() and vardetails() functions to see the available options")}

    ags <- c("municipio", "micro", "meso", "corede", "estado")
    if((missing(ag)) || (!ag %in% ags)){stop(paste0("Error: Select a valid argument for ag. The ag argument is only available for "),
                          paste(ags, collapse = ", "))}

    #if(missing(period)){stop("Error: Select a valid argument for period")}

    #treat var_id
    if(any(var_id == "all")){
      var_id <- vars() |> dplyr::select(var_id) |> dplyr::pull()
    }


    #output
    x<-
    var_id |>
      purrr::map_df(function(z){
        paste0("https://dados.dee.rs.gov.br/api/data.php?",
               "id=",
               z,
               "&ag=",
               ag,
               "&periodo=",
               period |> paste0(collapse = ","),
               "&sort=",
               sort
        ) |>
          jsonlite::fromJSON() |>
          tidyr::unnest(cols = data) |>
          dplyr::mutate(var_id = z)
      })

    x <-
      x |>
      dplyr::rename("geo_id" = "id",
                    "year" = "ano",
                    "value" = "valor",
                    "unit" = "un_medida",
                    "note" = "nota") |>
      dplyr::select(var_id,geo_id,year,value, unit, note) |>
      dplyr::mutate(
        year = as.integer(year),
        value = value |>
          stringr::str_remove_all("\\.") |>
          stringr::str_replace_all("\\,",replacement = "\\.") |>
          as.numeric()
      )


    #add names
    vars1 <- vars()
    geos1 <- geoagreg(ag = ag)

    if(add_names == TRUE){
      x <-
        x |>
        dplyr::left_join(vars1,
                         by = c("var_id" = "var_id")) |>
        dplyr::left_join(geos1,
                         by = c("geo_id" = "geo_id")) |>
        dplyr::left_join(um(),
                         by = c("unit" = "um_id")) |>
        dplyr::select(var_id, var_name, geo_id, geo_name, year, value, um_name, um_acronym, note)
    }

    return(x)

  }

