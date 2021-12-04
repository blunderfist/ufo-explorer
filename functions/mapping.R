# produces map based on inputs

create_map <- function(dat){

  m <- dat %>%
       leaflet() %>%
       addTiles() %>%
       addProviderTiles(providers$CartoDB.DarkMatter) %>%
       addCircles(lng = dat$lng, lat = dat$lat)

  return(m)
}

