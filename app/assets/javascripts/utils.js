var Utils = {}

Utils.message = function(text) {
	var $modal = $('#modalGeneric');
	$modal.modal('show').find('p').text(text);
};

Utils.radios = function() {
	$('.radio-inline>input[type=radio]').each(function() {
		if (this.checked) $(this).parent().addClass('active');
	});
};

Utils.radios.init = function() {
	$(document).on('change', '.radio-inline>input[type=radio]', function(e) {
		$('input[type=radio][name='+this.name+']').parent().removeClass('active');
		$(this).parent().addClass('active');
	});
};

Utils.selectpicker = function() {
	$('select.form-control').selectpicker();
};

Utils.autonumeric = function() {
	$('input.autonumeric').autoNumeric('init', { aSep: '.', aDec: ',', aPad: false });
};

Utils.startMap = function(elementId) {
	var map_canvas = document.getElementById(elementId);
	var locations = [ { address: 'Av. Álvarez Thomas 1199 Ciudad Autónoma de Buenos Aires', title: 'Beigel Bienes Raices' } ];
	var geocoder = new google.maps.Geocoder();
	var map = new google.maps.Map(map_canvas, {
		disableDoubleClickZoom: true,
		scrollwheel: false,
		zoom: 15,
		disableDefaultUI: false,
		mapTypeId: google.maps.MapTypeId.ROADMAP,
	});
	locations.forEach(function(location, index) {
		geocoder.geocode({ 'address' : location.address }, function(results, status) {
			if (status == google.maps.GeocoderStatus.OK) {
				if (!index) map.setCenter(results[0].geometry.location);
				var marker = new google.maps.Marker({
					map: map,
					position: results[0].geometry.location,
					animation: google.maps.Animation.DROP,
					title: location.title || null,
					//icon: 'img/marker.png'
				});
			};
		});
	});
	return map;
};

Utils.init = function() {
	Utils.radios();
	Utils.selectpicker();
	Utils.autonumeric();
};

$(function() {
	Utils.radios.init();
});