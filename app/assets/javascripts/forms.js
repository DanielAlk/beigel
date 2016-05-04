var Forms = {}

Forms.newProperty = function() {
	Utils.autonumeric();
	Utils.selectpicker();
	$('#new_property').validate({
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

Forms.propertyCharacteristics = function() {
	Utils.checkboxes();
	Utils.autonumeric();
	Utils.selectpicker();
};