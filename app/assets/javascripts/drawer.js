var Drawer = {};

Drawer.load = function() {
	$.fn.drawer = Drawer.extension;
};

Drawer.extension = function() {
	this.each(function() {
		var drawer = this;
		var $drawer = $(drawer);
		var $toggler = $($drawer.data('toggler'));
		var $handle = $($drawer.data('handle'));
		var enable_for = {
			mobile: drawer.className.match('drawer-xs'),
			tablet: drawer.className.match('drawer-sm'),
			laptop: drawer.className.match('drawer-md'),
			desktop: drawer.className.match('drawer-lg')
		};
		var is_media = function() {
			for (var device in enable_for) if (enable_for[device] && Media.device == device) return true;
			return false;
		}
		var close = function() {
			$drawer.css('overflow', 'hidden').addClass('closed');
			$(document).off('click', documentClick);
		};
		var open = function() {
			$drawer.removeClass('closed');
			$(document).on('click', documentClick);
		};
		var documentClick = function(e) {
			var $target = $(e.target).add($(e.target).parents());
			if ($target.is($drawer)) return;
			close();
		};
		var toggleClick = function(e) {
			if (!is_media()) return;
			e.preventDefault();
			e.stopPropagation();
			if ($drawer.hasClass('closed')) open();
			else close();
		};
		var handleClick = function(e) {
			if (!is_media()) return;
			e.stopPropagation();
			if ($drawer.hasClass('closed')) {
				e.preventDefault();
				open();
			};
		};
		var onTransitionEnd = function(e) {
			if (!$drawer.hasClass('closed')) $drawer.css('overflow', 'visible');
		};
		if ($toggler.length) $toggler.click(toggleClick);
		if ($handle.length) $handle.click(handleClick);
		$drawer.on('transitionend', onTransitionEnd);
	});
};

$(Drawer.load);