var Utils = {}

Utils.init = function() {
	Utils.radios();
	Utils.selectpicker();
	Utils.autonumeric();
	Utils.drawer();
};

Utils.load = function() {
	Utils.radios.init();
	Utils.checkboxes.init();
	Utils.nav();
};

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
		var target = this;
		$('input[type=radio]').filter(function() {
			return target.name == this.name;
		}).parent().removeClass('active');
		$(this).parent().addClass('active');
	});
};

Utils.checkboxes = function() {
	$('.checkbox-inline>input[type=checkbox]').each(function() {
		if (this.checked) $(this).parent().addClass('active');
	});
};

Utils.checkboxes.init = function() {
	$(document).on('change', '.checkbox-inline>input[type=checkbox]', function(e) {
		var target = this;
		$(this).parent().toggleClass('active');
	});
};

Utils.selectpicker = function() {
	$('select.form-control, .field select').selectpicker({size:10});
};

Utils.autonumeric = function() {
	$('input.autonumeric').autoNumeric('init', { aSep: '.', aDec: ',', aPad: false });
};

Utils.drawer = function() {
	$('[class*=drawer]').drawer();
};

Utils.nav = function() {
	$(document).on('click', '#nav-toggler', function(e) {
		e.preventDefault();
		var $body = $('body');
		$body.toggleClass('navigate');
	});
	$(document).on('click', function(e) {
		var $body = $('body');
		if (!$body.hasClass('navigate')) return;
		var $target = $(e.target).add($(e.target).parents());
		var $cancel = $('#nav-toggler, .navigation-menu');
		if ($target.is($cancel)) return;
		$body.removeClass('navigate');
	});
};

$(Utils.load);