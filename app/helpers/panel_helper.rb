module PanelHelper
	def tinymce_init
		content_for :extra_js do
			"setTimeout(function() {
				if (!$('.tinymce').prev().is('.mce-panel')) window.location.reload();
			}, 500);".html_safe
		end
		'<script>
			//<![CDATA[
			tinyMCE.init({
				selector: "textarea.tinymce",
				toolbar: "bold italic | undo redo | link",
				menubar: false,
				statusbar: false,
				forced_root_block: false,
				plugins: "link"
			});
			//]]>
		</script>'.html_safe
	end

	def table_order param, default_class = ''
		order_param = params.require(:order).permit(param)[param] rescue nil
		data = "data-order=#{param}"
		if order_param.present?
			oposite_order = order_param.to_sym == :asc ? :desc : :asc
			data << " data-way=#{oposite_order} class=#{order_param}"
		else
			data << " data-way=asc"
		end
		if params[:order].blank?
			data << " class=#{default_class}"
		end
		data
	end
end
