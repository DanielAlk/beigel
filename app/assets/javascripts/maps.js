var Maps = {}

Maps.newProperty = function() {
	var $new_property_map = $('#new_property_map');
	var $geocode_btn = $('#geocode_btn');
	var $property_address = $('#property_address');
	var $property_zone_id = $('#property_zone_id');
	var $lng = $('#property_lng');
	var $lat = $('#property_lat');
	var $form = $new_property_map.closest('form');
	var addressTail = 'Ciudad Autónoma de Buenos Aires, Argentina';
	var geocoder = new google.maps.Geocoder();
	var clickHandler = function(e) {
		!e || e.preventDefault();
		if (!$property_address.valid()) return;
		var address = $property_address.val() + $property_zone_id.children('option:selected').text() + addressTail;
		geocoder.geocode({ 'address' : address }, function(results, status) {
			if (status == google.maps.GeocoderStatus.OK) {
				Maps.centered(results[0].geometry.location);
				$lng.val(results[0].geometry.location.lng());
				$lat.val(results[0].geometry.location.lat());
			};
		});
		return !!e;
	};
	var checkCenter = function(e) {
		if (!$lng.val() || !$lat.val()) return clickHandler();
		if (!$property_address.valid()) return;
		var address = $property_address.val() + $property_zone_id.children('option:selected').text() + addressTail;
		geocoder.geocode({ 'address' : address }, function(results, status) {
			if (status == google.maps.GeocoderStatus.OK) {
				var currentCenter = Maps.centered.map.getCenter();
				var resultsLng = results[0].geometry.location.lng();
				var resultsLat = results[0].geometry.location.lat();
				var moduleLng = resultsLng < currentCenter.lng() ? resultsLng % currentCenter.lng() : currentCenter.lng() % resultsLng;
				var moduleLat = resultsLat < currentCenter.lat() ? resultsLat % currentCenter.lat() : currentCenter.lat() % resultsLat;
				if (moduleLng > -0.000001 && moduleLat > -0.000001 && $form.valid()) $form.get(0).submit();
				else {
					Maps.centered(results[0].geometry.location);
					$lng.val(resultsLng);
					$lat.val(resultsLat);
				};
			};
		});
		return false;
	};
	Maps.centered.init($new_property_map);
	$geocode_btn.click(clickHandler);
	$form.submit(checkCenter);
	if ($lng.val() && $lat.val()) Maps.centered(new google.maps.LatLng($lat.val(),$lng.val()));
};

Maps.centered = function(center) {
	if (!Maps.centered.map) {
		$(Maps.centered.element).addClass('active');
		Maps.centered.map = new google.maps.Map(Maps.centered.element, {
			disableDoubleClickZoom: true,
			scrollwheel: false,
			zoom: 15,
			disableDefaultUI: false,
			mapTypeId: google.maps.MapTypeId.ROADMAP,
			center: center
		});
		Maps.centered.marker = new google.maps.Marker({
			map: Maps.centered.map,
			position: center,
			animation: google.maps.Animation.DROP,
		});
	} else {
		Maps.centered.map.setCenter(center);
		Maps.centered.marker.setPosition(center);
	};
};

Maps.centered.init = function(element) {
	Maps.centered.map = undefined;
	Maps.centered.marker = undefined;
	Maps.centered.element = element.get ? element.get(0) : element;
};

Maps.contact = function() {
	Maps.start('contact-map', { latLng: new google.maps.LatLng(-34.57825, -58.458306), title: 'Beigel Bienes Raices' });
};

Maps.file = function(lat, lng) {
	Maps.start('file-map', { latLng: new google.maps.LatLng(lat, lng) }, 'file-street');
};

Maps.start = function(elementId, location, panoramaId) {
	var map_canvas = document.getElementById(elementId);
	var map = new google.maps.Map(map_canvas, {
		disableDoubleClickZoom: true,
		scrollwheel: false,
		zoom: 15,
		center: location.latLng,
		disableDefaultUI: false,
		mapTypeId: google.maps.MapTypeId.ROADMAP,
	});
	if (!panoramaId) {
		var marker = new google.maps.Marker({
			map: map,
			position: location.latLng,
			animation: google.maps.Animation.DROP,
			title: location.title || null,
			//icon: 'img/marker.png'
		});
	} else {
		var panorama = new google.maps.StreetViewPanorama(document.getElementById(panoramaId), {
			position: location.latLng,
			disableDoubleClickZoom: true,
			scrollwheel: false,
			pov: {
				heading: 90,
				pitch: 0
			}
		});
		map.setStreetView(panorama);
	};
	return map;
};