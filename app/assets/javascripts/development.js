var Development = {}

Development.nav = function() {
	var $nav = $('#edit_development_nav a');
	$nav.click(function(e) {
		e.preventDefault();
		$('#development_status').val($(this).data('development-status'));
		$('form.new_development, form.edit_development').submit();
	});
};

Development.new = function() {
	Utils.selectpicker();
	var $form = $('form.new_development, form.edit_development');
	$form.validate({
		messages: {
			'development[lat]': 'Ajustá el mapa',
			'development[lng]': 'Ajustá el mapa',
		}
	});
};

Development.characteristics = function() {
	Utils.checkboxes();
	Utils.autonumeric();
	Utils.selectpicker();
};

Development.multimedia = function(file_picker_obj) {
	$('#file_picker').filePicker(file_picker_obj);
	$('form.edit_development').validate();
	Property.videoAdder();
};