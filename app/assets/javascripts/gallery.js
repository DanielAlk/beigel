var Gallery = {}

Gallery.load = function() {
	$.fn.gallery = Gallery.extension;
};

Gallery.extension = function() {
	this.each(function() {
		var gallery = this;
		var $gallery = $(gallery);
		var $items = $gallery.find('.gallery-items').children();
		var $left = $gallery.find('.gallery-left');
		var $right = $gallery.find('.gallery-right');
		var is_transitioning;
		var go = function(dir) {
			dir = dir == 'next';
			var target_item = ['prev', 'next'];
			var alternative_target_item = ['last', 'first'];
			var directions = ['left', 'right'];
			var $active = $items.filter('.active');
			var $target = $active.is($items[alternative_target_item[Number(!dir)]]()) ? $items[alternative_target_item[Number(dir)]]() : $active[target_item[Number(dir)]]();
			$target.addClass('active '+directions[Number(dir)]);
			is_transitioning = true;
			setTimeout(function() {
				$active.addClass(directions[Number(!dir)]);
				$target.removeClass(directions[Number(dir)]);
			},50);
		};
		var next = function(e) {
			e.preventDefault();
			if (is_transitioning) return;
			go('next');
		};
		var prev = function(e) {
			e.preventDefault();
			if (is_transitioning) return;
			go('prev');
		};
		var onTransitionEnd = function() {
			is_transitioning = false;
			$items.filter('.active.left').removeClass('active left');
			$items.filter('.active.right').removeClass('active right');
		};
		$right.click(next);
		$left.click(prev);
		$items.on('transitionend', onTransitionEnd);
	});
};

$(Gallery.load);