var Utils = {}

Utils.message = function(text) {
	var $modal = $('#modalGeneric');
	$modal.modal('show').find('p').text(text);
};

Utils.radios = function() {
	$(document).on('change', '.radio-inline>input[type=radio]', function(e) {
		$('input[type=radio][name='+this.name+']').parent().removeClass('active');
		$(this).parent().addClass('active');
	});
	$('.radio-inline>input[type=radio]').each(function() {
		if (this.checked) $(this).parent().addClass('active');
	});
};

$(function() {
	Utils.radios();
});