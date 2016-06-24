var Gallery = {}

Gallery.load = function() {
	$.fn.gallery = Gallery.extension;
};

Gallery.extension = function(options) {
	options = options || {};
	options = {
		fullscreen: options.fullscreen || false,
		toggle: options.toggle || false
	};
	this.each(function() {
		var gallery = this;
		var $gallery = $(gallery);
		var $items = $gallery.find('.gallery-items').children();
		var $images = $items.find('img');
		var $loader = $gallery.find('.gallery-loader');
		var $left = $gallery.find('.gallery-left');
		var $right = $gallery.find('.gallery-right');
		var $toggle = $gallery.find('.gallery-toggle');
		var $fullscreen_version = options.toggle ? $(options.toggle) : false;
		var is_transitioning, is_fullscreen_gallery_initiated, show;
		var toggle = function(e) {
			e.preventDefault();
			e.stopPropagation();
			e.stopImmediatePropagation();
			if (options.toggle) $fullscreen_version.trigger('gallery.show');
			if (options.fullscreen) $gallery.fadeOut(100);
		};
		var applyDimensions = function($img) {
			var containerHeight = $img.parent().height();
			if (!$img.hasClass('tall') && !$img.hasClass('wide')) {
				var height = $img.height();
				var width = $img.width();
				if (height >= width) $img.addClass('tall');
				if (height < width) {
					$img.addClass('wide');
					setTimeout(function() {
						if ($img.height() > containerHeight) $img.removeClass('wide').addClass('tall');
						else $img.css('margin-top', containerHeight/2 - $img.height()/2);
					},30);
				};
			} else {
				$img.css('margin-top', containerHeight/2 - $img.height()/2);
			};
		};
		var go = function(dir) {
			if (is_transitioning) return;
			is_transitioning = true;
			dir = dir == 'next';
			var target_item = ['prev', 'next'];
			var alternative_target_item = ['last', 'first'];
			var directions = ['left', 'right'];
			var $active = $items.filter('.active');
			var $target = $active.is($items[alternative_target_item[Number(!dir)]]()) ? $items[alternative_target_item[Number(dir)]]() : $active[target_item[Number(dir)]]();
			var $img = $target.find('img');
			var empty_attr = !$img.attr('src');
			if (empty_attr) $loader.fadeIn(100);
			$target.addClass('active '+directions[Number(dir)]);
			show = function() {
				var do_it = function() {
					$active.addClass(directions[Number(!dir)]);
					$target.removeClass(directions[Number(dir)]);
					if (empty_attr) $loader.fadeOut(100);
				};
				if (options.fullscreen) {
					applyDimensions($img);
					setTimeout(do_it, 30);
				} else do_it();				
			};
			if (empty_attr) $img.attr('src', $img.data('src'));
			else setTimeoutToShow();
		};
		var next = function(e) {
			e.preventDefault();
			e.stopPropagation();
			if ($items.length > 1) go('next');
		};
		var prev = function(e) {
			e.preventDefault();
			e.stopPropagation();
			if ($items.length > 1) go('prev');
		};
		var setTimeoutToShow = function() {
			if (is_transitioning) setTimeout(show, 30);
		};
		var onTransitionEnd = function() {
			$items.filter('.active.left').removeClass('active left');
			$items.filter('.active.right').removeClass('active right');
			is_transitioning = false;
		}
		var fullscreenGalleryOnShow = function() {
			$img = $images.filter('.active img');
			if (!is_fullscreen_gallery_initiated) {
				is_fullscreen_gallery_initiated = true;
				$img.css('visibility', 'hidden');
				$gallery.fadeIn(100, function(){
					applyDimensions($img);
					$img.attr('style', null);
				});
			} else $gallery.fadeIn(100, function(){
				applyDimensions($img);
			});
		};
		var fullscreenGalleryClick = function(e) {
			if ($(e.target).is($gallery)) $gallery.fadeToggle(100);
		};
		var fullscreenGalleryKeyup = function(e) {
			if ($gallery.is(':visible')) {
				switch(e.which) {
					case 39: next(e); break;
					case 37: prev(e); break;
					case 27: $toggle.click(); break;
				};
			};
		};
		var fullscreenGalleryInit = function() {
			$gallery.on('gallery.show', fullscreenGalleryOnShow);
			$gallery.click(fullscreenGalleryClick);
			$(document).keyup(fullscreenGalleryKeyup);
		};
		var init = function() {
			if ($items.length > 1) {
				$images.load(setTimeoutToShow);
				$right.click(next);
				$left.click(prev);
				$gallery.swipeleft(next);
				$gallery.swiperight(prev);
				$items.on('transitionend', onTransitionEnd);
			} else $right.add($left).remove();
			if (options.toggle || options.fullscreen) $toggle.add($gallery).css('cursor', 'pointer').click(toggle);
			if (options.fullscreen) fullscreenGalleryInit();
		};
		init();
	});
};

$(Gallery.load);