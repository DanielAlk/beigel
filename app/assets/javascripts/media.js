var Media = {}

Media.device = null;

Media.queries = {
	mobile: window.matchMedia('(max-width: 767px)'),
	tablet: window.matchMedia('(max-width: 991px)'),
	laptop: window.matchMedia('(max-width: 1199px)')
};

Media.addListener = function(callback) {
	if (!callback) return false;
	for (var q in Media.queries) Media.queries[q].addListener(callback);
};

Media.setDevice = function() {
	for (var q in Media.queries) if (Media.queries[q].matches || q == 'laptop' && (q = 'desktop')) return (Media.device = q);
};

Media.init = function() {
	Media.addListener(Media.setDevice);
	Media.setDevice();
};

(function() {
	Media.init();
})();