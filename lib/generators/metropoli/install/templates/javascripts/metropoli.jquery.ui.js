$(document).ready(function(){
	
	$(".city_autocomplete").autocomplete({
		source: function(request, response) {
					$.ajax({
						url: "/cities.json",
						dataType: "json",
						data: {	q: request.term	},
						success: function(data) {
							response($.map(data, function(item) {
								return {
									label: item.city.name + ', ' + item.city.state.name + ', ' + item.city.state.country.abbr,
									value: item.city.name + ', ' + item.city.state.name + ', ' + item.city.state.country.abbr
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
						url: "/states.json",
						dataType: "json",
						data: {	q: request.term	},
						success: function(data) {
							response($.map(data, function(item) {
								return {
									label: item.state.name + ', ' + item.state.country.name,
									value: item.state.name + ', ' + item.state.country.name
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
						url: "/countries.json",
						dataType: "json",
						data: {	q: request.term	},
						success: function(data) {
							response($.map(data, function(item) {
								return {
									label: item.country.name,
									value: item.country.name
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
	
});