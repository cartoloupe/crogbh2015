geocoder = undefined
map = undefined

codeAddress = (address, mapdivid) ->
  geocoder = new (google.maps.Geocoder)
  geocoder.geocode { 'address': address }, (results, status) ->
    if status == google.maps.GeocoderStatus.OK
      myOptions = 
        zoom: 8
        center: results[0].geometry.location
        mapTypeId: google.maps.MapTypeId.ROADMAP
      map = new (google.maps.Map)(document.getElementById(mapdivid), myOptions)
      marker = new (google.maps.Marker)(
        map: map
        position: results[0].geometry.location)
    return
  return
