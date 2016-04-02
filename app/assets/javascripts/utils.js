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

Utils.drawer = function() {
	$('[class*=drawer]').each(function() {
		var $drawer = $(this);
		var $toggler = $($drawer.data('toggler'));
		var $handle = $($drawer.data('handle'));
		var close = function() {
			$drawer.css('overflow', 'hidden').addClass('closed');
			$(document).off('click', documentClick);
		};
		var open = function() {
			$drawer.removeClass('closed');
			$(document).on('click', documentClick);
		};
		var documentClick = function(e) {
			if ($(e.target).parents().is($drawer)) return;
			close();
		};
		if ($toggler.length) $toggler.click(function(e) {
			e.preventDefault();
			e.stopPropagation();
			if ($drawer.hasClass('closed')) open();
			else close();
		});
		if ($handle.length) $handle.click(function(e) {
			e.stopPropagation();
			if ($drawer.hasClass('closed')) {
				e.preventDefault();
				open();
			};
		});
		$drawer.on('transitionend', function(e) {
			if (!$drawer.hasClass('closed')) $drawer.css('overflow', 'visible');
		});
	});
};

Utils.nav = function() {
	$(document).on('click', '#nav-toggler', function(e) {
		e.preventDefault();
		var $body = $('body');
		$body.toggleClass('navigate');
	});
};

Utils.init = function() {
	Utils.radios();
	Utils.selectpicker();
	Utils.autonumeric();
	Utils.drawer();
};

$(function() {
	Utils.radios.init();
	Utils.nav();
});