# You can use Javascript in maps_javascript.js if you'd rather.

my_map = null;

initialize_map = ->
  mapOptions = {
    center: new google.maps.LatLng(-34.397, 150.644)
    zoom: 8
  }
  map = new google.maps.Map document.getElementById('map'), mapOptions

add_marker = (addr, map, color)->
  address = { 'address': addr }
  geocoder = new google.maps.Geocoder()
  geocoder.geocode address, (r,s) ->
    if s is google.maps.GeocoderStatus.OK
      map.setCenter(r[0].geometry.location)
      create_marker(r[0].geometry.location, color, map)
    else
      console.error "Geocode was unsuccessful because: " + s

create_marker = (location, color, map) ->
  marker = new google.maps.Marker {
    position: location
    map: map
    icon: "http://www.google.com/intl/en_us/mapfiles/ms/micons/#{color}-dot.png"
  }

create_markers = (locations, color, map) ->
  for location in locations
    do (location) ->
      add_marker location, map, color

$(document).on 'page:load', (event)->
  plot_me =
    visited: [
      '5175 W San Fernando Rd, Los Angeles, CA 90039'
      '10 Congress Street #202, Pasadena, CA 91105'
      '471 W Broadway Ave. #340, Glendale, CA 91204'
      '800 S Fairmount Ave. #425,  Pasadena, CA 91105'
      '1560 Chevy Chase Dr. #325,  Glendale, CA 91206'
    ]
    revisit: [
      '729 Ivy Street, Glendale, CA 91105'
      '2329 W. Rosecrans Ave., Gardena, CA 90249'
      '10 Congress Street #300, Pasadena, CA 91105'
    ]
    unvisited: [
      '463 Riverdale Dr, Glendale, CA 91204'
      '1560 Chevy Chase Dr. #345, Glendale, CA 91206'
      '1138 N Brand Blvd #B, Glendale, CA 91202'
      '280 E Colorado Blvd #103, Pasadena, CA 91101'
      '800 S Fairmont Avenue #310, Pasadena, CA 91105'
      '1141 N Brand Blvd #306, Glendale, CA 91202'
    ]
  my_map = initialize_map()
  create_markers plot_me.visited, 'red', my_map
  create_markers plot_me.revisit, 'orange', my_map
  create_markers plot_me.unvisited, 'green', my_map

