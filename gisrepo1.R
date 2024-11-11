
getwd() #get working directory
install.packages('pacman')
pacman::p_load(sf,tidyverse,RSQLite,tmap,tmaptools,here)

world <- st_read(here::here("World_Countries_(Generalized)_9029012925078512962.geojson"))
inequality_data <- read_csv(here::here("gii_GLOBAL.csv"))
colnames(inequality_data) #check the column name
inequality_data <- inequality_data %>%mutate(Inequality_Difference = year_2019 - year_2010)  


world_inequality <- world %>%
  left_join(inequality_data, by = c("ISO" = "country")) 

tmap_mode("plot")
qtm(world_inequality ,fill = "Inequality_Difference")

##to make the map more detailed and comprehensive
tm_shape(world_inequality) + 
  tm_polygons("Inequality_Difference", 
              title = "Difference 10-19", #add the legend
              palette = "-RdYlBu",  # using the "Red-Yellow-Blue" gradient color scheme) +  
  tm_layout(legend.outside = TRUE ,  # legend position
            main.title = "World Inequality Map", #map title) 