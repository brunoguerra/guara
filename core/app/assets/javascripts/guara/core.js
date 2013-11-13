//= require jquery
//= require jquery-ui
//= require jquery.popover
//= require jquery_ujs
//= require bootstrap
//= require guara/utils
//= require guara/form_ajax
//= require jquery-ui-timepicker-addon
//= require jquery.mask
//= require jquery.price_format.min.js
//= require jquery-numeric.js
//= require select2/select2
//= #require i18n
//= #require i18n/translations
//= require guara/core/pt-BR
//= require hogan.js
//= require jquery.dataTables.min.js
//= require jquery.dataTables.dataTools/TableTools.min.js
//= require jquery.dataTables.dataTools/TableTools_Bootstrap.js
//= require_tree ../templates/
//= require guara/ui

$(document).on("focus", "[data-behaviour~='datepicker']", function(e){
    $(this).datepicker({"format": "dd/mm/yyyy hh:mm", "weekStart": 1, "autoclose": true});
});

$(document).on("focus", "[data-behaviour~='datetimepicker']", function(e){
    $(this).datetimepicker({ dateFormat: "dd/mm/yy", timeFormat: "hh:mm", "weekStart": 1, "autoclose": true, 
	hourGrid: 4, minuteGrid: 10});
});

$(function() {
	$( "#accordion" ).accordion();
});


jQuery.fn.center = function () {
    this.css("position","absolute");
    this.css("top", Math.max(0, ((jQuery(window).height() - jQuery(this).outerHeight()) / 2) + 
                                                jQuery(window).scrollTop()) + "px");
    this.css("left", Math.max(0, ((jQuery(window).width() - jQuery(this).outerWidth()) / 2) + 
                                                jQuery(window).scrollLeft()) + "px");
    return this;
}