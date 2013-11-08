function initialize() {
  var myLatlng = new google.maps.LatLng(-3,-38);
  var mapOptions = {
    zoom: 4,
    center: myLatlng,
    mapTypeId: google.maps.MapTypeId.TERRAIN
  }
  window.google_maps = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);

  if(typeof add_markers=='function') {
    add_markers();
  }
}

google.maps.event.addDomListener(window, 'load', initialize);