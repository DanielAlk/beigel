var Panel = {};

Panel.contacts = function() {
	Utils.checkboxes();
	Panel.tableOrder();
	Panel.contactToggleRead();
	Panel.contactActions();
};

Panel.tableOrder = function() {
	var $form = $('form#table-order');
	$('[data-order]').click(function(e) {
		e.preventDefault();
		var $this = $(this);
		$form.append($('<input>', { type: 'hidden', name: 'order['+ $this.data('order') +']', val: $this.data('way') }));
		$form.submit();
	});
};

Panel.contactToggleRead = function() {
	$('.active-toggle').click(function(e) {
		e.preventDefault();
		var $toggle = $(this);
		var url = $toggle.attr('href');
		var data = $toggle.data();
		var $contact = $toggle.closest('tr');
		$toggle.addClass('loading');
		Panel.put(url, { contact: { id: data.id, read: !data.read } }, function(response) {
			$toggle.removeClass('loading').data('read', response.read);
			if (response.read) {
				$toggle.addClass('active');
				$contact.removeClass('info');
			} else {
				$toggle.removeClass('active');
				$contact.addClass('info');
			};
		});
	});
};

Panel.contactActions = function() {
	var $buttons = $('[data-collect-ids]');
	var $checkboxes = $('[name=select_all], .checkbox-target');
	var update_all = function(ids) {
		var read = $(this).data('read');
		var path = $(this).attr('href');
		Panel.put(path, { contact: { ids: ids, read: read } }, function(response) {
			response.forEach(function(contact) {
				$tr = $('tr#contact_' + contact.id);
				$read = $tr.find('.active-toggle');
				if (contact.read) {
					$tr.removeClass('info');
					$read.addClass('active').data('read', contact.read);
				} else {
					$tr.addClass('info');
					$read.removeClass('active').data('read', contact.read);
				};
			});
		});
	};
	var delete_all = function(ids) {
		var form_id = $(this).attr('href');
		var $form = $('form' + form_id);
		ids.forEach(function(id) {
			$form.append($('<input>', { type: 'hidden', name: 'contact[ids][]', value: id }));
		});
		$form.submit();
	};
	$checkboxes.change(function() {
		if ($checkboxes.filter(':checked').length) $buttons.removeClass('disabled');
		else $buttons.addClass('disabled');
	});
	$buttons.click(function(e) {
		e.preventDefault();
		var ids = [];
		var read = $(this).data('read');
		$checkboxes.each(function(e) {
			var val = $(this).val();
			if (this.checked && !!val && val.match(/\d+/)) ids.push(val);
		});
		if (!!read || read === 0) update_all.call(this, ids);
		else delete_all.call(this, ids);
	});
};

Panel.put = function(url, data, callback) {
	$.ajax({ url: url, data: data, dataType: 'json', method: 'PUT' }).done(callback);
};

Panel.delete = function(url, data, callback) {
	if (typeof data == 'function') { callback = data; data = {}; };
	$.ajax({ url:url, dataType: 'json', data: data, method: 'DELETE' }).done(callback);
};

Panel.showcaseToggle = function(showcase_items_path) {
	Panel.relationToggler(showcase_items_path, '.showcase-item-toggle', 'showcase_item', 'showcaseable');
};

Panel.promotionToggle = function(promotions_path) {
	Panel.relationToggler(promotions_path, '.promotion-toggle', 'promotion', 'promotionable');
};

Panel.relationToggler = function(path, selector, className, polyName) {
	var activate = function($toggle) {
		$toggle.removeClass('active').addClass('loading');
		var data = {}
		data[className] = {};
		data[className][polyName + '_id'] = $toggle.data(polyName + '-id');
		data[className][polyName + '_type'] = $toggle.data(polyName + '-type');
		$.post(path, data, function(response) {
			$toggle.data('id', response.id).removeClass('loading').addClass('active');
		}, 'json');
	};
	var deactivate = function($toggle) {
		$toggle.removeClass('active').addClass('loading');
		var id = $toggle.data('id');
		Panel.delete(path + '/' + id, function(response) {
			$toggle.removeClass('loading');
		});
	};
	$(selector).click(function(e) {
		e.preventDefault();
		var $toggle = $(this);
		if ($toggle.hasClass('loading')) return;
		if ($toggle.hasClass('active')) deactivate($toggle);
		else activate($toggle);
	});
};