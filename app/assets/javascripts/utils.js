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

Utils.init = function() {
	Utils.radios();
	Utils.selectpicker();
	Utils.autonumeric();
};

$(function() {
	Utils.radios.init();
});