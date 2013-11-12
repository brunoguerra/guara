var gmaps_initialLocation;

function gmaps_initialize() {
  var myDefault = new google.maps.LatLng(-3,-38);
  var newyork = new google.maps.LatLng(40.69847032728747, -73.9514422416687);
  var mapOptions = {
    zoom: 6,
    mapTypeId: google.maps.MapTypeId.TERRAIN
  }
  gmaps_initialLocation = myDefault;

  window.google_maps = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);

  if(navigator.geolocation) {
    browserSupportFlag = true;
    navigator.geolocation.getCurrentPosition(function(position) {
      gmaps_initialLocation = new google.maps.LatLng(position.coords.latitude,position.coords.longitude);
      setInitialLocation();
    }, function() {
      handleNoGeolocation(browserSupportFlag);
    });
  }
  // Browser doesn't support Geolocation
  else {
    browserSupportFlag = false;
    handleNoGeolocation(browserSupportFlag);
  }

  function handleNoGeolocation(errorFlag) {
    if (errorFlag == true) {
      alert("Geolocation service failed.");
      gmaps_initialLocation = newyork;
    } else {
      alert("Your browser doesn't support geolocation. We've placed you in Siberia.");
      gmaps_initialLocation = myDefault;
    }
    setInitialLocation();
  }

  function setInitialLocation() {
    window.google_maps.setCenter(gmaps_initialLocation);
    if(typeof add_markers=='function') {
      add_markers(window, window.google_maps);
    } else if (typeof window.parent.add_markers == 'function') {
      window.parent.add_markers(window, window.google_maps);
    } else if (typeof map_set_marker == 'function') {
      map_set_marker(window, window.google_maps, gmaps_initialLocation, true);
    }

    if(typeof GMaps_afterIntialLocation=='function') {
      GMaps_afterIntialLocation(window, window.google_maps);
    } else if (typeof window.parent.GMaps_afterIntialLocation == 'function') {
      window.parent.GMaps_afterIntialLocation(window, window.google_maps);
    }
  }
}

function GMaps_loadScript() {
  var script = document.createElement("script");
  script.type = "text/javascript";
  script.src = "http://maps.googleapis.com/maps/api/js?key=AIzaSyDDmtCzTQa38qSzlNq1l7m-kTEbB4fv-3E&sensor=true&callback=gmaps_initialize";
  document.body.appendChild(script);
}