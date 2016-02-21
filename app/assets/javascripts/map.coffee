geocoder = undefined
map = undefined

console.log 'map.coffee'

codeAddress = (address, mapdivid) ->
  geocoder = new (google.maps.Geocoder)
  geocoder.geocode { 'address': address }, (results, status) ->
    if status == google.maps.GeocoderStatus.OK
      myOptions =
        zoom: 8
        center: results[0].geometry.location
        mapTypeId: google.maps.MapTypeId.ROADMAP
      map = new (google.maps.Map)(document.getElementById(mapdivid), myOptions)
      window.map = map
      marker = new (google.maps.Marker)(
        map: map
        position: results[0].geometry.location)
    return
  return

getLocation = ->
  if navigator.geolocation
    navigator.geolocation.getCurrentPosition showPosition
  else
    x.innerHTML = 'Geolocation is not supported by this browser.'
  return

showPosition = (position) ->
  console.log position
  return

#The callback function executed when the location is fetched successfully.
onGeoSuccess = (location) ->
  window.loc = location
  window.map = location.map.map # the google map
  console.log location
  return

#The callback function executed when the location could not be fetched.
onGeoError = (error) ->
  console.log error
  return

window.onload = ->
  #geolocator.locateByIP(onGeoSuccess, onGeoError, 2, 'map-canvas');
  html5Options = 
    enableHighAccuracy: true
    timeout: 6000
    maximumAge: 0
  geolocator.locate onGeoSuccess, onGeoError, true, html5Options, 'map-canvas'
    # new (google.maps.Map)(document.getElementById('#map-canvas'))
  return

addMarker = (lat,long) ->
  marker = new (google.maps.Marker)(
    position: {lat: lat, lng: long}
    map: window.map
    title: 'Hello World!')

addAddress = (address) ->
  geocoder = new (google.maps.Geocoder)
  geocoder.geocode { 'address': address }, (results, status) ->
    window.res = results
    window.sta = status
    lat = results[0].geometry.location.lat()
    lng = results[0].geometry.location.lng()
    if status == google.maps.GeocoderStatus.OK
      return
    else
      return


window['addAddress'] = addAddress
window['addMarker'] = addMarker
window['codeAddress'] = codeAddress
window['getLocation'] = getLocation
window['showPosition'] = showPosition
window['onGeoSuccess'] = onGeoSuccess
window['onGeoError'] = onGeoError

console.log('what')
