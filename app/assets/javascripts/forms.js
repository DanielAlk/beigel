var Forms = {}

Forms.Property = {};

Forms.Property.nav = function() {
	var $nav = $('#edit_property_nav a');
	$nav.click(function(e) {
		e.preventDefault();
		$('#property_status').val($(this).data('property-status'));
		$('form.new_property, form.edit_property').submit();
	});
};

Forms.Property.new = function() {
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

Forms.Property.characteristics = function() {
	Utils.checkboxes();
	Utils.autonumeric();
	Utils.selectpicker();
};