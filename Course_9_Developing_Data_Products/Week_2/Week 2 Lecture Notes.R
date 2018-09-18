library(leaflet)

my_map <- leaflet() %>% addTiles()
my_map

my_map <- addTiles(leaflet())
my_map




my_map <- my_map %>% addMarkers(lat = 39.2980803, lng = -76.5898801, popup = "Jeff Leek's Office")
my_map

my_map <- addMarkers(my_map, lat = 39.2980803, lng = -76.5898801, popup = "Jeff Leek's Office")
my_map



# Passing one observation
my_map <- leaflet() %>% 
          addTiles() %>% 
          addMarkers(lat = 39.2980803, lng = -76.5898801, popup = "Jeff Leek's Office")
my_map

my_map <- addMarkers(addTiles(leaflet()), lat = 39.2980803, lng = -76.5898801, popup = "Jeff Leek's Office")
my_map


# Passing data frame
df <- data.frame(lat = runif(20, min = 39.2, max = 39.3),
                 lng = runif(20, min = -76.6, max = -76.5))

my_map <- addMarkers(addTiles(leaflet(df)))
my_map

my_map <- df %>%
  leaflet() %>% 
  addTiles() %>% 
  addMarkers()
my_map


# Creating an icon
hopkinsIcon <- makeIcon(
  iconUrl = "http://brand.jhu.edu/content/uploads/2014/06/jhu-divisions-school_of_health.png",
  iconWidth = 31*215/230, iconHeight = 31,
  iconAnchorX = 31*215/230/2, iconAnchorY = 16)
hopkinsIcon

# Creating dataframe of latitude and longitude
hopkinsLatLong <- data.frame(
  lat = c(39.3, 39.33, 39.29, 39.3, 39.28),
  lng = c(-76.6, -76.62, -76.55, -76.62, -76.6))

# Creating list of sites to match lat,lng
hopkinsSites <- c(
  "<a href='http://www.jhsph.edu/'>East Baltimore Campus</a>",
  "<a href='https://apply.jhu.edu/visit/homewood/'>Homewood Campus</a>",
  "<a href='http://www.hopkinsmedicine.org/johns_hopkins_bayview/'>Bayview Medical Center</a>",
  "<a href='http://www.peabody.jhu.edu/'>Peabody Institute</a>",
  "<a href='http://carey.jhu.edu/'>Carey Business School</a>")

# Calling
hopkins <- hopkinsLatLong %>% 
  leaflet() %>%
  addTiles() %>%
  addMarkers(icon = hopkinsIcon, popup = hopkinsSites)
hopkins

hopkins <- addMarkers(addTiles(leaflet(hopkinsLatLong)), icon = hopkinsIcon,  popup = hopkinsSites)
hopkins



# Clustering
df <- data.frame(lat = runif(20, min = 39.29, max = 39.30),
                 lng = runif(20, min = -76.60, max = -76.59))

my_map <- addMarkers(addTiles(leaflet(df)),clusterOptions = markerClusterOptions())
my_map

my_map <- df %>%
  leaflet() %>% 
  addTiles() %>% 
  addMarkers(clusterOptions = markerClusterOptions())
my_map



# Circles
df <- data.frame(lat = runif(20, min = 39.29, max = 39.30),
                 lng = runif(20, min = -76.60, max = -76.59))

my_map <- addCircleMarkers(addTiles(leaflet(df)))
my_map

my_map <- df %>%
  leaflet() %>% 
  addTiles() %>% 
  addCircleMarkers()
my_map



# DRAWING CIRCLES
md_cities <- data.frame(name = c("Baltimore", "Frederick", "Rockville", "Gaithersburg", 
                                 "Bowie", "Hagerstown", "Annapolis", "College Park", "Salisbury", "Laurel"),
                        pop = c(619493, 66169, 62334, 61045, 55232,
                                39890, 38880, 30587, 30484, 25346),
                        lat = c(39.2920592, 39.4143921, 39.0840, 39.1434, 39.0068, 39.6418, 38.9784, 38.9897, 38.3607, 39.0993),
                        lng = c(-76.6077852, -77.4204875, -77.1528, -77.2014, -76.7791, -77.7200, -76.4922, -76.9378, -75.5994, -76.8483))
md_cities %>%
  leaflet() %>%
  addTiles() %>%
  addCircles(weight = 1, radius = sqrt(md_cities$pop) * 30)

# DRAWING RECTANGLES
leaflet() %>%
  addTiles() %>%
  addRectangles(lat1 = 37.3858, lng1 = -122.0595, 
                lat2 = 37.3890, lng2 = -122.0625)

# ADDING LEGENDS
df <- data.frame(lat = runif(20, min = 39.25, max = 39.35),
                 lng = runif(20, min = -76.65, max = -76.55),
                 col = sample(c("red", "blue", "green"), 20, replace = TRUE),
                 stringsAsFactors = FALSE)

df %>%
  leaflet() %>%
  addTiles() %>%
  addCircleMarkers(color = df$col) %>%
  addLegend(labels = LETTERS[1:3], colors = c("blue", "red", "green"))