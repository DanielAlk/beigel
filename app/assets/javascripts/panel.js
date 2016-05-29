var Panel = {};

Panel.tableOrder = function() {
	var $form = $('form#table-order');
	$('[data-order]').click(function(e) {
		e.preventDefault();
		var $this = $(this);
		$form.append($('<input>', { type: 'hidden', name: 'order['+ $this.data('order') +']', val: $this.data('way') }));
		$form.submit();
	});
};

Panel.showcaseToggle = function(showcase_items_path) {
	var activate = function($toggle) {
		$toggle.removeClass('active').addClass('loading');
		var data = {
			showcase_item: {
				showcaseable_id: $toggle.data('showcaseable-id'),
				showcaseable_type: $toggle.data('showcaseable-type')
			}
		};
		$.post(showcase_items_path, data, function(response) {
			$toggle.data('showcase-item-id', response.id).removeClass('loading').addClass('active');
		}, 'json');
	};
	var deactivate = function($toggle) {
		$toggle.removeClass('active').addClass('loading');
		var id = $toggle.data('showcase-item-id');
		$.ajax({
			url: showcase_items_path + '/' + id,
			dataType: 'json',
			method: 'DELETE'
		})
		.done(function(response) {
			$toggle.removeClass('loading');
		});
	};
	$(document).on('click', '.showcase-item-toggle', function(e) {
		e.preventDefault();
		var $toggle = $(this);
		if ($toggle.hasClass('loading')) return;
		if ($toggle.hasClass('active')) deactivate($toggle);
		else activate($toggle);
	});
};

Panel.promotionToggle = function(promotions_path) {
	var activate = function($toggle) {
		$toggle.removeClass('active').addClass('loading');
		var data = {
			promotion: {
				promotionable_id: $toggle.data('promotionable-id'),
				promotionable_type: $toggle.data('promotionable-type')
			}
		};
		$.post(promotions_path, data, function(response) {
			$toggle.data('promotion-id', response.id).removeClass('loading').addClass('active');
		}, 'json');
	};
	var deactivate = function($toggle) {
		$toggle.removeClass('active').addClass('loading');
		var id = $toggle.data('promotion-id');
		$.ajax({
			url: promotions_path + '/' + id,
			dataType: 'json',
			method: 'DELETE'
		})
		.done(function(response) {
			$toggle.removeClass('loading');
		});
	};
	$(document).on('click', '.promotion-toggle', function(e) {
		e.preventDefault();
		var $toggle = $(this);
		if ($toggle.hasClass('loading')) return;
		if ($toggle.hasClass('active')) deactivate($toggle);
		else activate($toggle);
	});
};