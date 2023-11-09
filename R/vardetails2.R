# vardetails2 <-
#   Vectorize(vardetails)


vardetails2 <-
  c(4049,4031) |>
  purrr::map_df(.f = vardetails)



