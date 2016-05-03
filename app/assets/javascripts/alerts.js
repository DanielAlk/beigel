var Alerts = {};

Alerts.notice = function() {
	var $alert = $('#alertNotice');
	var fadeOutAndRemove = function($alert) {
		if (!$alert.length) return;
		$alert.fadeOut(function() {
			if (!$alert.length) return;
			$alert.remove();
		});
	};
	$alert.find('button.close').click(function(e) {
		e.preventDefault();
		fadeOutAndRemove($alert);
	});
	setTimeout(function() {
		if ($('#alertNotice').length) fadeOutAndRemove($('#alertNotice'));
	}, 6000);
	$alert.fadeIn();
};