var Panel = {};


Panel.contacts = function() {
	Utils.checkboxes();
	Panel.tableOrder();
	Panel.contactToggleRead();
	Panel.contactActions();
	$(window).load(function() {
		setTimeout(Panel.reloadReadState, 10);
	});
};

Panel.controlButtons = function(record, relations) {
	var $buttons = $('.control-buttons a');
	var $formButtons = $('.control-buttons button');
	var cardSelector = function(object) {
		for (var i = 0; i<relations.length; i++) {
			if (!!object[relations[i] + '_id']) return '#' + record + '_' + object[relations[i] + '_id'];
		};
	};
	$('.checkbox-target').change(function(e) {
		if ($('.checkbox-target:checked').length) $buttons.add($formButtons).removeClass('disabled');
		else $buttons.add($formButtons).addClass('disabled');
	});
	$formButtons.click(function(e) {
		e.preventDefault();
		var $btn = $(this);
		var $form = $($btn.data('form'));
		var ids = [];
		$('.checkbox-target:checked').each(function() {
			$form.append($('<input>', { name: 'ids[]', value: $(this).val() }));
		});
		$form.submit();
	});
	$buttons.click(function(e) {
		e.preventDefault();
		var $btn = $(this);
		var url = $btn.attr('href');
		var domd = $btn.data();
		var method = domd.httpMethod.toUpperCase();
		var className = domd.className;
		var htmlClass = '.' + className.replace('_', '-') + '-toggle';
		var ids = [];
		var cardToggles = [];
		var data = {};
		data[className] = {};
		$('.checkbox-target:checked').each(function() { ids.push($(this).val()); });
		for (var key in domd) {
			var paramName = key.replace(/([A-Z])/g, '_$1').toLowerCase();
			switch(domd[key]) {
				case '{{ids}}': data[paramName] = ids; break;
				default: if (key != 'httpMethod' && key != 'className' && !key.match(/tooltip/)) data[className][paramName] = domd[key];
			};
		};
		ids.forEach(function(id) {
			cardToggles.push($('#' + record + '_' + id).find(htmlClass).get(0));
		});
		$(cardToggles).removeClass('active').addClass('loading');
		$.ajax({ url: url, method: method, data: data, dataType: 'json' }).done(function(response) {
			if (response) {
				response.forEach(function(r) {
					$(cardSelector(r)).find(htmlClass).data('id', r.id).removeClass('loading').addClass('active');
				});
			} else $(cardToggles).removeClass('loading');
		});
	});
};

Panel.ajaxPut = function(record) {
	var $buttons = $('.ajax-put');
	$buttons.click(function(e) {
		e.preventDefault();
		var record_data = {};
		var $btn = $(this);
		var $holder = $btn.closest('.ajax-put-holder');
		var $targets = $holder.find('.ajax-put-target');
		var path = $btn.attr('href');
		var data = $btn.data();
		var ajaxToggle = data.ajaxToggle;
		var value, param;
		var newValue = function(key, val) {
			return ajaxToggle[key][0] == val ? ajaxToggle[key][1] : ajaxToggle[key][0];
		};
		record_data[record] = {};
		for (var key in data) {
			if (key.match('ajax')) continue;
			value = data[key];
			param = key.replace(/([A-Z])/g, '_$1');
			record_data[record][param] = value;
		};
		$btn.addClass('loading');
		$.ajax({ url: path, data: record_data, dataType: 'json', method: 'PUT', global: false })
		.done(function(response) {
			var key;
			for (var param in response) {
				value = response[param];
				key = param.replace('_', '-');
				if ($btn.data(key)) $btn.data(key, newValue(key, value));
				var $target = $targets.filter('[data-'+ key +']');
				var targetData = $target.data();
				for (var key in targetData) {
					param = key.replace(/([A-Z])/g, '_$1');
					var format = targetData[key];
					if (format[value]) $target.text(format[value]);
				};
			};
			$btn.removeClass('loading').toggleClass('active');
		})
		.fail(function(response) {
			var alert = '<b>No se puede completar porque:</b><br>';
			var errors = response.responseJSON;
			for (var attr in errors) {
				alert+= '<b>' + attr + '</b> ';
				errors[attr].forEach(function(error) { alert+= error + ', ' });
				alert = alert.substr(0, alert.length - 2) + '.<br>';
			};
			Alerts.danger(alert);
			$btn.removeClass('loading');
		});
	});
};

Panel.reloadReadState = function() {
	var ids = [];
	$('tbody tr').each(function() { ids.push($(this).data('id')); });
	if (!ids.length) return;
	$.get('/notifications/select', {select: { param: 'read', ids: ids }}, function(response) {
		response.forEach(function(contact) {
			var $tr = $('tr#contact_' + contact.id);
			var $read = $tr.find('.active-toggle');
			if (contact.read) {
				$tr.removeClass('bold');
				$read.addClass('active').data('read', contact.read);
			} else {
				$tr.addClass('bold');
				$read.removeClass('active').data('read', contact.read);
			};
		});
	}, 'json');
};

Panel.showUnreadNotifications = function(count) {
	var $span = $('#unread-notifications');
	var text;
	if (!count) $span.hide();
	else $span.show().find('a').html($span.find('i').get(0).outerHTML + ' ' + count);
};

Panel.unreadNotifications = function() {
	var getCount = function() {
		$.get('/notifications/select', {select: { param: {read: 0}, count: true }}, function(response) {
			Panel.showUnreadNotifications(response);
		}, 'json');
	};
	setInterval(getCount, 20000);
	getCount();
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
				$contact.removeClass('bold');
			} else {
				$toggle.removeClass('active');
				$contact.addClass('bold');
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
				var $tr = $('tr#contact_' + contact.id);
				var $read = $tr.find('.active-toggle');
				if (contact.read) {
					$tr.removeClass('bold');
					$read.addClass('active').data('read', contact.read);
				} else {
					$tr.addClass('bold');
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
		if ($(this).hasClass('checkbox-target')) {
			var $tr = $(this).closest('tr');
			if (this.checked) $tr.addClass('success');
			else $tr.removeClass('success');
		};
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
	return $.ajax({ url: url, data: data, dataType: 'json', method: 'PUT' }).done(callback);
};

Panel.delete = function(url, data, callback) {
	if (typeof data == 'function') { callback = data; data = {}; };
	return $.ajax({ url:url, dataType: 'json', data: data, method: 'DELETE' }).done(callback);
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