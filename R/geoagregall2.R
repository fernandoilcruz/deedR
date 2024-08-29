#' Integrated Geographic Aggregation Composition
#'
#' @description Geographic aggregations for all municipalites in Rio Grande do Sul.
#'
#' @param period Numeric (optional).
#' @return tibble
#'
#' @import checkmate tidyverse tidyselect
#' @importFrom utils data
#'
#' @export
#'
#' @examples
#' geoagregall2()
#' geoagregall2(period = 2022)
#'
geoagregall2 <-
  function(period = NULL){

    url <-
      paste0("https://dados.dee.rs.gov.br/api/composicao_ag_all.php?",
             "periodo=",paste0(period,collapse = ",")
      )

    #output
    x <-
      url |>
      jsonlite::fromJSON() |>
      tibble::as_tibble() |>
      dplyr::rename("geo_id_municipio" = "id_municipio",
                    "geo_id_corede" = "id_corede",
                    "geo_id_micro" = "id_microrregiao",
                    "geo_id_meso" = "id_mesorregiao",
                    "geo_id_estado" = "id_estado",

                    "geo_name_municipio" = "municipio",
                    "geo_name_corede" = "corede",
                    "geo_name_micro" = "microrregiao",
                    "geo_name_meso" = "mesorregiao",
                    "geo_name_estado" = "estado",

                    "period" = "ano")

    return(x)

  }


# start<-Sys.time()
# geoagregall2(period = 1994:2024)
# end<-Sys.time()
# end-start





# geoagregall3 <-
#   function(period = NULL){
#
#     url <-
#       paste0("http://10.112.42.22/api/composicao_ag_all.php?",
#              "periodo=",paste0(period,collapse = ",")
#       )
#
#     #output
#     x <-
#       url |>
#       jsonlite::fromJSON() |>
#       tibble::as_tibble() |>
#       dplyr::rename("geo_id_municipio" = "id_municipio",
#                     "geo_id_corede" = "id_corede",
#                     "geo_id_micro" = "id_microrregiao",
#                     "geo_id_meso" = "id_mesorregiao",
#
#                     "geo_name_municipio" = "municipio",
#                     "geo_name_corede" = "corede",
#                     "geo_name_micro" = "microrregiao",
#                     "geo_name_meso" = "mesorregiao",
#                     "period" = "ano")
#
#     return(x)
#
#   }
#
#
# start<-Sys.time()
# geoagregall3()
# end<-Sys.time()
# end-start
