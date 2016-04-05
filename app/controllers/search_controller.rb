class SearchController < ApplicationController

  def index
  	search_params = params.require(:search)
  	search = search_params.has_key?(:operation_type) && search_params[:operation_type][0] == 'buy' ? 'comprar' : 'alquilar'
  	search << '/' + build_params_string(search_params, search_params_format)
  	redirect_to results_path(search: search)
  end

  def results
  	search_params = params.require(:search)
  	if operation_type = search_params[/comprar/]
  		@operation_type = :buy
  		set_properties_for_buy
  	elsif operation_type = search_params[/alquilar/]
  		@operation_type = :rent
  		set_properties_for_rent
  	end
		search_params = search_params.sub(operation_type, '')
		@search_params = parse_params_string(search_params, search_params_format)
  end

  private

	  def search_params_format
	  	{
	  		property_type: {
	  			id: 1,
	  			map: { house: :casa, apartment: :departamento },
  			},
	  		neighborhood: 2,
	  		price: {
	  			currency: 3,
	  			price_min: 4,
	  			price_max: 5
  			},
  			surface: 6,
  			rooms: 7
  		}
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
	  				param[:map].key(n.to_sym) || n.to_sym
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

	  def set_properties_for_buy
  		@properties = [
  			{ cover: 'card-image-1.jpg', neighborhood: 'La Boca', price: '2552898' },
  			{ cover: 'card-image-2.jpg', neighborhood: 'Villa Urquiza', price: '1808694' },
  			{ cover: 'card-image-3.jpg', neighborhood: 'San Telmo', price: '2029176' },
  			{ cover: 'card-image-4.jpg', neighborhood: 'Cañitas', price: '1718910' }
  		].shuffle
  	end

  	def set_properties_for_rent
  		@properties = [
  			{ cover: 'card-image-1.jpg', neighborhood: 'La Boca', price: '6500' },
  			{ cover: 'card-image-2.jpg', neighborhood: 'Villa Urquiza', price: '7000' },
  			{ cover: 'card-image-3.jpg', neighborhood: 'San Telmo', price: '8000' },
  			{ cover: 'card-image-4.jpg', neighborhood: 'Cañitas', price: '9000' }
  		].shuffle
  	end

end
