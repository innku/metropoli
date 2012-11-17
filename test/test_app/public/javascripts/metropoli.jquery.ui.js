$.noConflict();

jQuery(document).ready(function($) {
	
	$(".city_autocomplete").autocomplete({
		source: function(request, response) {
					$.ajax({
						url: "metropoli/cities.json",
						dataType: "json",
						data: {	q: request.term	},
						success: function(data) {
							response($.map(data, function(item) {
								return {
									label: item.city_model.to_s,
									value: item.city_model.to_s
								}
							}));
						}
					});
				},
		open: function() {
			$(this).removeClass("ui-corner-all").addClass("ui-corner-top");
		},
		close: function() {
			$(this).removeClass("ui-corner-top").addClass("ui-corner-all");
		}
	});
	
	$(".state_autocomplete").autocomplete({
		source: function(request, response) {
					$.ajax({
						url: "metropoli/states.json",
						dataType: "json",
						data: {	q: request.term	},
						success: function(data) {
							response($.map(data, function(item) {
								return {
									label: item.state_model.to_s,
									value: item.state_model.to_s
								}
							}));
						}
					});
				},
		open: function() {
			$(this).removeClass("ui-corner-all").addClass("ui-corner-top");
		},
		close: function() {
			$(this).removeClass("ui-corner-top").addClass("ui-corner-all");
		}
	});
	
	$(".country_autocomplete").autocomplete({
		source: function(request, response) {
					$.ajax({
						url: "metropoli/countries.json",
						dataType: "json",
						data: {	q: request.term	},
						success: function(data) {
							response($.map(data, function(item) {
								return {
									label: item.country_model.to_s,
									value: item.country_model.to_s
								}
							}));
						}
					});
				},
		open: function() {
			$(this).removeClass("ui-corner-all").addClass("ui-corner-top");
		},
		close: function() {
			$(this).removeClass("ui-corner-top").addClass("ui-corner-all");
		}
	});
	
	$(".country_autocomplete").autocomplete({
		source: function(request, response) {
					$.ajax({
						url: "metropoli/countries.json",
						dataType: "json",
						data: {	q: request.term	},
						success: function(data) {
							response($.map(data, function(item) {
								return {
									label: item.country_model.to_s,
									value: item.country_model.to_s
								}
							}));
						}
					});
				},
		open: function() {
			$(this).removeClass("ui-corner-all").addClass("ui-corner-top");
		},
		close: function() {
			$(this).removeClass("ui-corner-top").addClass("ui-corner-all");
		}
	}); 

  $(function(){
    $('.full_autocomplete').FullAutocomplete({
      source : function(request, response) {
                  $.ajax({
                    url: "metropoli/cities_and_countries.json",
                    dataType: "json",
                    data: {	q: request.term	},
                    success: function(data) {
                      cities = $.map( data['cities'], function( item ) {
                        return { label: item.city_model.to_s, value: item.city_model.to_s, category: 'Cities' }
                      });
                      countries = $.map( data['countries'], function( item ) {
                        return { label: item.country_model.to_s, value: item.country_model.to_s, category: 'Countries' }
                      });
                      
                      response(cities.concat(countries));
                    }
                  });
                }
    });
  });

  $.widget( "custom.FullAutocomplete", $.ui.autocomplete, {
    _renderMenu: function( ul, items ) {
      var self = this,
      currentCategory = "";

      $.each( items, function( index, item ) {
        if ( item.category != currentCategory ) {
          ul.append( "<li class='ui-autocomplete-category'>" + item.category + "</li>" );
          currentCategory = item.category;
        }
        self._renderItem(ul, item);
      });
    },
    _renderItem: function( ul, item ) {
		  return $( "<li></li>" )
			  .data( "item.autocomplete", item )
			  .append( "<a>" + item.value + "</a>" )
			  .appendTo( ul );
	  }
  });
});
