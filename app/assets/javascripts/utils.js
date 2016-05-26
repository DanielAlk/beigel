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
	Utils.submitTriggers();
	Utils.dataHref();
	Utils.nav();
};

Utils.paginationNext = function() {
	$('#pagination_next').click(function(e) {
		e.preventDefault();
		var next_page = $(this).data('page');
		$(this).data('page', Number(next_page)+1);
		$.getScript(this.href + next_page);
	});
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
	$('.checkbox-inline>input[type=checkbox][name=select_all]').each(function() {
		var element = this;
		var selector = $(element).data('target');
		var $targets = $('input[type=checkbox]'+selector);
		if ($targets.filter(':checked').length == $targets.length) $(element).prop('checked', true).parent().addClass('active');
		$targets.data('master', element);
	});
};

Utils.checkboxes.init = function() {
	$(document).on('change', '.checkbox-inline>input[type=checkbox]', function(e) {
		$(this).parent().toggleClass('active');
		var master = $(this).data('master');
		if (master) {
			if (master.checked && !this.checked) $(master).prop('checked', false).parent().removeClass('active');
			else if (!master.checked) {
				var selector = $(master).data('target');
				var $targets = $('input[type=checkbox]'+selector);
				if ($targets.filter(':checked').length == $targets.length) $(master).prop('checked', true).parent().addClass('active');
			};
		};
	});
	$(document).on('change', '.checkbox-inline>input[type=checkbox][name=select_all]', function(e) {
		var element = this;
		var selector = $(element).data('target');
		var $targets = $('input[type=checkbox]'+selector);
		$targets.filter(function() {
			return $(element).is(':checked') != $(this).is(':checked');
		}).click();
	});
};

Utils.submitTriggers = function() {
	$(document).on('click', '[data-submit]', function(e) {
		e.preventDefault();
		$($(this).data('submit')).submit();
	});
};

Utils.dataHref = function() {
	$(document).on('click', '[data-href]', function(e) {
		e.preventDefault();
		window.location.href = $(this).data('href');
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