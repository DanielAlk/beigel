var Slider = {};

Slider.load = function() {
	$.fn.slider = Slider.extension;
};

Slider.extension = function() {
	this.each(function() {
		var $slider = $(this);
		var $items = $($slider.data('slider'));
		var $indicators, timer, is_transitioning, pause, delay = 6000;
		var setTimer = function() {
			if (timer) clearTimeout(timer);
			if (!pause) timer = setTimeout(next, delay);
		};
		var createIndicators = function() {
			var $container = $('<div>', { class: 'slider-indicators' });
			$items.each(function() {
				$container.append($('<a>', { href: '#' }));
			});
			$slider.append($container);
			$indicators = $container.children();
			$indicators.first().addClass('active');
			$indicators.click(clickHandler);
		};
		var goto = function($target) {
			var $active = $items.filter('.active');
			if ($active.is($target)) return;
			is_transitioning = true;
			$indicators.removeClass('active');
			$indicators.eq($target.index()).addClass('active');
			$active.fadeOut(600);
			$target.fadeIn(600, function() {
				$items.removeClass('active');
				$target.addClass('active');
				is_transitioning = false;
				setTimer();
			});
		};
		var next = function() {
			var $active = $items.filter('.active');
			var $next = $active.is($items.last()) ? $items.first() : $active.next();
			goto($next);
		};
		var clickHandler = function(e) {
			e.preventDefault();
			var $this = $(this);
			if (is_transitioning || $this.is('.active')) return;
			var index = $(this).index();
			goto($items.eq(index));
		};
		var hoverIn = function(e) {
			pause = true;
			clearTimeout(timer);
			timer = null;
		};
		var hoverOut = function(e) {
			pause = false;
			setTimer();
		};
		var init = function() {
			createIndicators();
			$slider.hover(hoverIn, hoverOut);
			setTimer();
		};
		init();
	});
};

$(Slider.load);