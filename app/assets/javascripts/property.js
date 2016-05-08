var Property = {}

Property.nav = function() {
	var $nav = $('#edit_property_nav a');
	$nav.click(function(e) {
		e.preventDefault();
		$('#property_status').val($(this).data('property-status'));
		$('form.new_property, form.edit_property').submit();
	});
};

Property.new = function() {
	Utils.autonumeric();
	Utils.selectpicker();
	var $form = $('#new_property');
	$form.validate({
		rules: {
			'property[sale_price]': {
				required: {
					depends: function(element) {
						return $('#property_rent_price').val() == ''
					}
				}
			},
			'property[rent_price]': {
				required: {
					depends: function(element) {
						return $('#property_sale_price').val() == ''
					}
				}
			}
		},
		messages:{
			'property[sale_price]': 'Definí un precio para esta propiedad',
			'property[rent_price]': 'Definí un precio para esta propiedad',
			'property[lat]': 'Ajustá el mapa',
			'property[lng]': 'Ajustá el mapa',
		}
	});
};

Property.characteristics = function() {
	Utils.checkboxes();
	Utils.autonumeric();
	Utils.selectpicker();
};

Property.multimedia = function(file_picker_obj) {
	$('#file_picker').filePicker(file_picker_obj);
	$('form.edit_property').validate();
	Property.videoAdder();
};

Property.videoAdder = function() {
	var $videos = $('#video-adder');
	var $items = $videos.children('.video-input');
	var markAsInvalid = function($item) {
		$item.addClass('invalid');
	};
	var wipeItem = function($item) {
		$item.removeClass('valid').find('.video-holder').html(null);
	};
	var insertEmbed = function(e) {
		var $input = $(this);
		var $item = $input.closest('.video-input');
		var video_url = $input.val();
		if (!video_url.match(/(https?\:\/\/)?(www\.)?(youtube\.com|youtu\.?be)\/.+/)) return markAsInvalid($item);
		if ($item.hasClass('valid')) wipeItem($item);
		var $holder = $item.find('.video-holder');
		var $iframe = $('<iframe>', { src: video_url.replace('watch?v=', 'embed/'), frameborder: 0, 'allowfullscreen': true });
		$holder.append($iframe);
		$item.addClass('valid');
	};
	$videos.on('focusout', '.video-input input', insertEmbed);
};