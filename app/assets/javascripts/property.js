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
	var $form = $videos.closest('form');
	var markAsInvalid = function($item) {
		$item.removeClass('repeated valid').addClass('invalid').find('.video-holder').html(null);
	};
	var markAsRepeated = function($item) {
		$item.removeClass('valid invalid').addClass('repeated').find('input').val(null).siblings('.video-holder').html(null);
	};
	var isRepeated = function($item) {
		var video_url = $item.find('input').val();
		var rtn = false;
		$item.siblings().each(function() {
			if (rtn) return;
			var url = $(this).find('input').val();
			if (url == video_url) rtn = true;
		});
		return rtn;
	};
	var insertEmbed = function(e) {
		var $input = $(this);
		var $item = $input.closest('.video-input');
		var video_url = $input.val();
		if (!video_url.match(/(https?\:\/\/)?(www\.)?(youtube\.com|youtu\.?be)\/.+/)) return markAsInvalid($item);
		if (isRepeated($item)) return markAsRepeated($item);
		var $holder = $item.find('.video-holder');
		var $iframe = $('<iframe>', { src: video_url.replace('watch?v=', 'embed/'), frameborder: 0, 'allowfullscreen': true });
		$holder.html(null).append($iframe);
		$item.removeClass('repeated invalid').addClass('valid');
	};
	var addVideoInput = function(e) {
		e.preventDefault();
		var $item = $videos.find('.video-input').last().clone();
		$item.removeClass('repeated valid invalid').find('.video-holder').html(null);
		var $input = $item.find('input');
		var input_id_parts = $input.attr('id').split('_');
		var id = '';
		input_id_parts.forEach(function(part, i){
			if (i < input_id_parts.length - 1) id += part + '_';
			else id += String(Number(part) +1);
		});
		$input.attr('id', id).val(null);
		$item.find('.video-holder').html(null);
		$item.appendTo($videos).find('input').focus();
	};
	var beforeSubmit = function() {
		$videos.find('.video-input').filter(function(){ return !$(this).hasClass('valid') }).remove();
	};
	$videos.on('change', '.video-input input', insertEmbed);
	$('#video-adder-btn').click(addVideoInput);
	$form.submit(beforeSubmit);
};