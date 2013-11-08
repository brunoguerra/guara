GuaraFoursquare = { 
  setup: function() {
    $('.foursquare.search input#place_search').on('keydown', function(event) {
        if(event.keyCode == 13) {
          event.preventDefault();
          GuaraFoursquare.peformSearch();
        }
    });

    $('.foursquare.search button').on('click', function(event) {
      GuaraFoursquare.peformSearch();
    });
  },

  peformSearch: function() {
    $.ajax({
      type: "POST",
      url: 'foursquare/places',
      data: $('.foursquare.search').serialize(),
      dataType: "json",
    }).done(function(data) {
      console.log(data);
    }).fail(function(jqXHR, textStatus, errorThrown) {
      ajax_form_commons_functions.error(null, jqXHR, textStatus, errorThrown);
    });
  },

}

jQuery(function(){
  GuaraFoursquare.setup();
}); 