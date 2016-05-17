module FilteringForProperties
	extend ActiveSupport::Concern

	def build_search_params
		build_search(params)
	end

	def build_search(search)
		@search_filters = {}
		@search_params = search.slice(:operation_type, :price_min, :price_max, :currency, :property_type, :property_type_title, :rooms, :zone, :zone_name, :area)
		if @search_params[:price_min].present? && @search_params[:price_max].present?
		  @search_params[:price_min] = @search_params[:price_min].remove '.'
		  @search_params[:price_max] = @search_params[:price_max].remove '.'
		end
		@search_params.each do |key, value|
			case key.to_sym
			when :operation_type
				if value.present?
					@operation_type = value.respond_to?(:each) ? value[0].to_sym : value.to_sym
					@search_filters[:operation_type] = @operation_type
				end
			when :price_min
				if @operation_type.present? && value.present? && @search_params[:price_max].present?
					@search_filters[:price] = { multiple: [ @operation_type, value, @search_params[:price_max] ] }
				end
			when :currency
				if @operation_type.present? && value.present? && @search_params[:price_min].present? && @search_params[:price_max].present?
					@search_filters[:currency] = { multiple: [ @operation_type, value == 'usd' ? 0 : 1 ] }
				end
			when :rooms
				if value.present?
					@search_filters[:environments] = value.map { |r| r.to_i < 4 ? r.to_i : 4..10 }
				end
			when :area
				if value.present?
					@search_filters[:area] = value.map { |a| a.to_i < 4 ? (a.to_i * 100 + 1)..(a.to_i+1)*100 : 301..Float::INFINITY }
				end
			when :property_type, :property_type_title, :zone, :zone_name
				if value.present?
					@search_filters[key.to_sym] = value
				end
			end
		end
	end

	def build_params_string(params_list, params_format)
		string = ''
		params_format.each do |key, param|
			if param.respond_to? :each and param[:id].present? and params_list[key].present?
				string << '/' + params_list[key].map { |p| param[:map][p.to_sym] || p.to_sym }.join('-' + param[:id].to_s + '/')
				string << '-' + param[:id].to_s
			elsif param.respond_to? :each
				group_string = ''
  			param_is_present = true
  			param.each do |k, p|
  				if param_is_present && param_is_present = params_list[k].present?
  					group_string << '/' + params_list[k] + '-' + p.to_s
  				end
  			end
  			string << group_string if param_is_present
  		elsif params_list[key].present?
  			string << '/' + params_list[key].join('-' + param.to_s + '/')
  			string << '-' + param.to_s
  		end
  	end
  	return string.sub('/','').gsub(/[^\d\w\/-]/, '')
  end

  def parse_params_string(params_list, params_format)
  	obj = {}
  	params_format.each do |key, param|
  		if param.respond_to? :each and param[:id].present? && value = params_list[Regexp.new '(\/[\w\d-]+-' + param[:id].to_s + ')+']
  			params_list = params_list.sub(value, '')
  			length = param[:id].to_s.length+2
  			obj[key] = value.sub('/','').split('/').map do |n|
  				n = n[0..-length]
  				param[:map].key(n.to_sym) || n
  			end
  		elsif param.respond_to? :each
  			group_obj = {}
  			param_is_present = true
  			param.each do |k, p|
  				if param_is_present
  					if value = params_list[Regexp.new '(\/[\w\d-]+-' + p.to_s + ')']
	  					params_list = params_list.sub(value, '')
	  					length = p.to_s.length+2
	  					obj[k] = value.sub('/','').split('/').map { |n| n[0..-length] }[0]
	  				else
	  					param_is_present = false
	  				end
	  			end
	  		end
	  		if param_is_present
	  			group_obj.each do |o|
	  				obj << o
	  			end
	  		end
	  	elsif value = params_list[Regexp.new '(\/[\w\d-]+-' + param.to_s + ')+']
	  		params_list = params_list.sub(value, '')
  			length = param.to_s.length+2
  			obj[key] = value.sub('/','').split('/').map { |n| n[0..-length] }
  		end
  	end
  	return obj
  end
end