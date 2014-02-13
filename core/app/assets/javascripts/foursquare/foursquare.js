GuaraFoursquare = { 
  center: ',',
  setup: function() {
    $('.foursquare.search input#places_search').on('keydown', function(event) {
        if(event.keyCode == 13) {
          event.preventDefault();
          GuaraFoursquare.peformSearch();
        }
    });

    $('.foursquare.search button').on('click', function(event) {
      GuaraFoursquare.peformSearch();
    });
  },

  setCenter: function(latLong) {
    this.center = latLong;
    $('.foursquare.search input#places_search_center').val(latLong);
  },

  peformSearch: function() {
    var me = this;
    $.ajax({
      type: "POST",
      url: 'foursquare/places',
      data: $('.foursquare.search input'),
      dataType: "json",
    }).done(function(data) {
      console.log(data);
      me.renderResults(data);
    }).fail(function(jqXHR, textStatus, errorThrown) {
      ajax_form_commons_functions.error(null, jqXHR, textStatus, errorThrown);
    });
  },

  renderResults: function(items) {
    console.log(items);
    var contents = HoganTemplates['foursquare_results'].render(items);
    console.log(contents);
    $('.foursquare.search .results').empty(contents).append(contents);
    if (this.callback_renderResult!=null) {
      this.callback_renderResult(this, items);
    }
  }

}

jQuery(function(){
  GuaraFoursquare.setup();
}); 