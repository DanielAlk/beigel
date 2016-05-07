var FilePicker = {};
FilePicker.File = {};

FilePicker.load = function() {
	$.fn.filePicker = FilePicker.extension;
};

FilePicker.extension = function(imageable_id, imageable_type) {
	FilePicker.imageable_id = imageable_id;
	FilePicker.imageable_type = imageable_type;
	this.each(FilePicker.plugin);
};

FilePicker.readFileAndShow = function(file, $image) {
	var reader = new FileReader;
	reader.onload = function(e) {
		var imageAsURL = e.target.result;
		$image.css({ 'background-image': 'url(' + imageAsURL + ')' });
		reader = null;
	};
	reader.readAsDataURL(file);
};

FilePicker.upload = function(data, callback) {
	callback = typeof callback != 'function' ? function(){} : callback;
	$.ajax({ url: '/images/', data: data, type: 'POST', contentType: false, processData: false, dataType: 'json' })
	.done(callback);
};

FilePicker.delete = function(id, callback) {
	callback = typeof callback != 'function' ? function(){} : callback;
	$.ajax({ url: '/images/'+id, type: 'DELETE', dataType: 'json' })
	.done(callback);
};

FilePicker.File.new = function(id, position, item) {
	var obj = this;
	obj.id = id;
	obj.position = position;
	obj.item = item;
	obj.save = function(callback) {
		callback = typeof callback != 'function' ? function(){} : callback;
		var data = new FormData;
		data.append('image[imageable_id]', FilePicker.imageable_id);
		data.append('image[imageable_type]', FilePicker.imageable_type);
		data.append('image[item]', obj.item);
		FilePicker.upload(data, function(response, status, location) {
			obj.id = response.id;
			obj.position = response.position;
			callback(response, status, location);
		});
		return obj;
	};
	obj.delete = function(callback) {
		FilePicker.delete(obj.id, callback)
		return null;
	};
	return obj;
};

FilePicker.plugin = function() {
	var picker = this;
	var images_container_selctor = $(this).data('images');
	var $images_container = $(images_container_selctor);
	var $template = $($(this).data('template'));
	var items = [];
	var deleteFile = function(e) {
		e.preventDefault();
		var id = $(this).data('id');
		items[id] = items[id].delete();
		$(this).closest('.file-picker-image').remove();
	};
	var user_selection = function(e) {
		for (var key in this.files) {
			var item = this.files[key];
			if (typeof item != 'object') return false;
			var $item = $template.clone();
			var $input = $item.find('input');
			var $image = $item.find('.image');
			var $delete = $item.find('.delete');
			var item_id = items.length;
			var input_new_id = $input.attr('id') + item_id;
			var input_new_name = $input.attr('name').replace('[]', '[' + item_id + ']');
			var file = new FilePicker.File.new(undefined, undefined, item)
			$item.attr('id', 'file_picker_' + item_id);
			$input.attr({ id: input_new_id, name: input_new_name });
			$delete.data('id', item_id);
			$images_container.append($item);
			FilePicker.readFileAndShow(item, $image);
			items.push(file);
			file.save();
		};
	};
	var loadPicker = function(e) {
		$images_container.children().each(function(e) {
			var image = $(this).data();
			items.push(new FilePicker.File.new(image.id, image.position, image.item));
		});
	};
	$(picker).change(user_selection).ready(loadPicker);
	$(document).on('click', images_container_selctor + ' a.delete', deleteFile)
};

$(FilePicker.load);