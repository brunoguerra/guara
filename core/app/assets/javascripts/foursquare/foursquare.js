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
      me.renderResults(data.groups[0]);
    }).fail(function(jqXHR, textStatus, errorThrown) {
      ajax_form_commons_functions.error(null, jqXHR, textStatus, errorThrown);
    });
  },

  renderResults: function(items) {
    $('.foursquare.search .results').empty().append(HoganTemplates['foursquare_results'].render(items));
    if (this.callback_renderResult!=null) {
      this.callback_renderResult(this, items);
    }
  }

}

jQuery(function(){
  GuaraFoursquare.setup();
}); 