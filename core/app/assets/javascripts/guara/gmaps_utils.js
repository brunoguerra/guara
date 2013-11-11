function set_lat_lng(win_js, map, address){
  if(typeof geocoder == 'undefined'){
    geocoder = new win_js.google.maps.Geocoder();
  }
  geocoder.geocode( { 'address': address}, function(results, status) {
    if (status == win_js.google.maps.GeocoderStatus.OK) {
      map.setCenter(results[0].geometry.location);
      
      lat_lng = results[0].geometry.location;

      map_set_marker(win_js, map, lat_lng, true);
      alter_lat_lng(lat_lng);
    } else {
      return false;
    }
  });
}

var marker = false;
var marker_location = { lat: 0,long: 0 };

function map_set_marker(win_js, map, lat_lng, draggable){
  if(typeof draggable == 'null'){
    draggable = false;
  }

  if(map.getZoom()!= 15){
    map.setZoom(15);
  }
  map.setCenter(lat_lng);
  if(marker == false){
    marker = new win_js.google.maps.Marker({
            map: map, 
            animation: win_js.google.maps.Animation.DROP,
            draggable: draggable,
            position: lat_lng
        });

        win_js.google.maps.event.addDomListener(marker, 'dragend', function(event){
          alter_lat_lng(event.latLng);
        }); 
  }
  else{
    marker.setPosition(lat_lng);
    marker.setDraggable(draggable);
    //marker.setAnimation(win_js.google.maps.Animation.DROP);

  }

  marker_location = lat_lng;

  return marker;
}

function alter_lat_lng(latLng){
  marker_location = latLng;
  if(typeof GMaps_afterSetLocation=='function') {
    GMaps_afterSetLocation(window, window.google_maps);
  } else if (typeof window.parent.GMaps_afterSetLocation == 'function') {
    window.parent.GMaps_afterSetLocation(window, window.google_maps);
  } else {
    $('#place_geo_lat').val(lat);
    $('#place_geo_long').val(lng);
    $('.guara_place input[type=submit]').removeClass('hidden');
  }
}
