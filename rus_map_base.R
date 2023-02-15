library(readr)
library(dplyr)
library(ggplot2)
library(sf)
library(lwgeom)

# Don't forget to set working directory

# Cross-sectional data on Russian regions' population
rus_pop <- read_delim("rus_pop.csv", delim = "\t")

# Shp-file
rus_regions_shp <- st_read("rus_shp/gadm36_RUS_1.shp", quiet = TRUE)

# Transforming coordinate system
rus_regions_shp <- st_transform_proj(rus_regions_shp, crs = "+proj=longlat +lon_wrap=180")

# Merging population data with spatial data
regions_sp <- full_join(rus_regions_shp, rus_pop, by = c("NAME_1" = "region"))

# Drawing the map
ggplot(regions_sp) + 
  geom_sf(aes(fill = population), col = "transparent") + 
  coord_sf(datum = NA) + 
  theme_void()

ggsave("rus_regions_pop_map.png")
