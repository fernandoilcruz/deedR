library(hexSticker)
library(geobr)
library(ggplot2)
library(tidyverse)
l

#Get Rio Grande do Sul shapefile
state <- geobr::read_municipality(
  code_muni = 43,
  year=2020,
  showProgress = FALSE
)

#Get schools data:
schools <-
  geobr::read_schools(year = 2020, showProgress = F) |>
  filter(abbrev_state == "RS")


#Create plot
rs_plot2 <-
  ggplot() +
  geom_sf(data = state,
          fill = NA,
          color= NA,
          # fill = "blue",
          # color= "white"
          #linewidth=0.1
          ) +
  geom_sf(data = schools, colour = "white", size = 0.0001) +
  theme_void() +
  theme(axis.title=element_blank(),
        axis.text=element_blank(),
        axis.ticks=element_blank())

#Create sticker
#x<-
  hexSticker::sticker(rs_plot2,
                      package="DeedadosR",
                      p_family = "Aller_Rg",
                      p_fontface = "bold",
                      p_size=10,
                      p_x = 1,
                      p_y = 1.5,
                      s_x=0.95,
                      s_y=0.75,
                      s_width=2.2,
                      s_height=1.25,
                      #h_fill="darkgreen,
                      #h_color="white",
                      h_color = "#6897bb",
                      filename="logo/figures/logo_deedadosr.png")



#fazer em 3d com o rayshader
# https://typethepipe.com/post/ggplot-to-3d-in-r-with-rayshader/
# https://milospopovic.net/3d-maps-with-r/
#https://www.mitchelloharawild.com/blog/hexwall/
#https://r-pkgs.org/website.html


#Melhor ideia pra desenho:
#https://github.com/lpinzari/mapping-networks-r-arcgis


