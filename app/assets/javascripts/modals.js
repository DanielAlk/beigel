var Modals = {}

Modals.generic = function() {
	var $modal = $('#modalGeneric');
	$modal
	.on('shown.bs.modal', function() {
		$modal.find('.modal-footer>button').focus();
	})
	.on('hidden.bs.modal', function() {
		$modal.find('p').html(null);
	});
};

Modals.notice = function() {
	var $modal = $('#modalNotice');
	$modal.modal('show')
	.on('shown.bs.modal', function() {
		$modal.find('.modal-footer>button').focus();
	});
};