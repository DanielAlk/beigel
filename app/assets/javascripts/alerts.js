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

Alerts.danger = function(text) {
	Alerts.generate(text, 'alert-danger');
};

Alerts.generate = function(text, alertClass) {
	var alert = '<div class="alert '+ alertClass +' alert-dismissible" role="alert" id="alertNotice" style="display:none;">';
	alert+= '<button type="button" class="close" aria-label="Close"><span aria-hidden="true">&times;</span></button>';
	alert+=	text;
	alert+= '</div>';
	$('body').append(alert);
	Alerts.notice();
};