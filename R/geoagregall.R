#' Integrated Geographic Aggregation Composition
#'
#' @description Geographic aggregations for all municipalites in Rio Grande do Sul.
#'
#' @param select_year Numeric (optional).
#' @return tibble
#'
#' @import checkmate tidyverse tidyselect
#' @importFrom utils data
#'
#' @export
#'
#' @examples
#' geoagregall()
#' geoagregall(select_year = 2022)
#'
geoagregall <-
  function(
    select_year = NULL
    ){

    checkmate::assert_numeric(select_year, null.ok = TRUE)

    #Lists
    #Municipalities
    lista_municipios <-
    geoagreg(ag="municipio") |>
      dplyr::select(
        -latitude,
        -longitude)

    #Corede
    lista_coredes <-
    geoagreg(ag="corede")

    #Meso
    lista_meso <-
    geoagreg(ag="meso")

    #Micro
    lista_micro <-
    geoagreg(ag="micro")

    #Auxiliar variables for Corede's composition by year
    x <- lista_coredes |> dplyr::select(geo_id) |> dplyr::pull()
    y <- seq(1994,lubridate::year(Sys.Date())-1)
    z <- tidyr::expand_grid(x,y)

    #Compositions
    #Corede
    geoagreg_corede <-
      purrr::map2(
        .x = z$x,
        .y = z$y,
        .f = purrr::possibly(
          function(x,y){
            geoagregcomp(ag="corede",geo_id = x,period = y) |>
              dplyr::rename(geo_id_municipio = geo_id,
                            geo_name_municipio = geo_name) |>
              dplyr::mutate(geo_id_corede = x,
                            period = y) |>
              dplyr::left_join(
                lista_coredes,
                by = c("geo_id_corede" = "geo_id")
              ) |>
              dplyr::rename(geo_name_corede = geo_name) |>
              dplyr::select(period,tidyselect::everything())
          },
      otherwise = "Error: corede not available for selected period.",
      quiet = TRUE
    ))

    names(geoagreg_corede) <- paste0(z$x,"_",z$y)

    #Meso
    geoagreg_meso <-
      geoagreg(ag="meso") |>
      dplyr::select(geo_id) |>
      dplyr::pull() |>
      purrr::map_df(
        function(x){
          geoagregcomp(ag = "meso",geo_id = x)|>
            dplyr::rename(geo_id_micro = geo_id,
                          geo_name_micro = geo_name) |>
            dplyr::mutate(
              geo_id_meso = x
            )
        }
      )

    #Micro
    geoagreg_micro <-
    geoagreg(ag="micro") |>
      dplyr::select(geo_id) |>
      dplyr::pull() |>
      purrr::map_df(
        function(x){
          geoagregcomp(ag = "micro",geo_id = x) |>
            dplyr::rename(geo_id_municipio = geo_id,
                          geo_name_municipio = geo_name) |>
            dplyr::mutate(
              geo_id_micro = x
            )
        }
      )

    #Join all (without period selection)
    geo_all_recent <-
      geoagreg_corede |>
      purrr::keep(tibble::is_tibble) |>
      purrr::map_df(.f = dplyr::bind_rows) |>
      dplyr::filter(period == Sys.Date() |> lubridate::year() - 1) |>
      dplyr::select(-period) |>
      dplyr::left_join(
        geoagreg_micro,
        by = c("geo_id_municipio" = "geo_id_municipio",
               "geo_name_municipio" = "geo_name_municipio")
      ) |>
      dplyr::left_join(
        geoagreg_meso,
        by = c("geo_id_micro" = "geo_id_micro")
      ) |>
      dplyr::left_join(
        lista_meso,
        by = c("geo_id_meso" = "geo_id")
      ) |>
      dplyr::rename(
        geo_name_meso = geo_name
      )

      #Join all (with period selection)
    geo_all <-
      geoagreg_corede |>
        purrr::keep(tibble::is_tibble) |> #Filters only tibbles in geoagreg_corede
        purrr::map_df(
          dplyr::left_join,
          geo_all_recent,
          by = c("geo_id_municipio" = "geo_id_municipio",
                 "geo_name_municipio" = "geo_name_municipio")
        )

    #Output
    if(is.null(select_year)){
      return(geo_all_recent)
    }else{
      return(geo_all |> dplyr::filter(period %in% c(select_year)))
    }
  }



