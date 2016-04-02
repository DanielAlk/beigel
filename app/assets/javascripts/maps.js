var Maps = {}

Maps.contact = function() {
	Maps.start('contact-map', { address: 'Av. Álvarez Thomas 1199 Ciudad Autónoma de Buenos Aires', title: 'Beigel Bienes Raices' });
};

Maps.file = function() {
	Maps.start('file-map', { address: 'Av. Álvarez Thomas 1199 Ciudad Autónoma de Buenos Aires', title: 'Beigel Bienes Raices' }, 'file-street');
}

Maps.start = function(elementId, locations, panoramaId) {
	locations = locations.forEach ? locations : locations.address ? [ locations ] : [ { address: locations } ];
	var map_canvas = document.getElementById(elementId);
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
				if (!panoramaId) {
					var marker = new google.maps.Marker({
						map: map,
						position: results[0].geometry.location,
						animation: google.maps.Animation.DROP,
						title: location.title || null,
						//icon: 'img/marker.png'
					});
				} else {
					var panorama = new google.maps.StreetViewPanorama(document.getElementById(panoramaId), {
						position: results[0].geometry.location,
						disableDoubleClickZoom: true,
						scrollwheel: false,
						pov: {
							heading: 90,
							pitch: 0
						}
					});
					map.setStreetView(panorama);
				};
			};
		});
	});
	return map;
};