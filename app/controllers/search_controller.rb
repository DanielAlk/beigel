class SearchController < ApplicationController
	include FilteringForProperties

  def index
  	search_params = params.require(:search)
  	operation_type = 'rent'
  	if search_params.has_key?(:operation_type)
  		operation_type = search_params[:operation_type].respond_to?(:each)? search_params[:operation_type][0] : search_params[:operation_type]
  	end
  	search = operation_type == 'buy' ? 'comprar' : 'alquilar'
  	search << '/' + build_params_string(search_params, search_params_format)
  	redirect_to results_path(search: search)
  end

  def results
  	search_params = params.require(:search)
  	if operation_type_regex = search_params[/comprar/]
  		operation_type = :buy
  	elsif operation_type_regex = search_params[/alquilar/]
  		operation_type = :rent
  	end
		search_params = search_params.sub(operation_type_regex, '')
		search_params = parse_params_string(search_params, search_params_format)
		search_params[:operation_type] = operation_type
		build_search(search_params)
		@properties = Property.filter(@search_filters)
		@properties = @properties.order(updated_at: :desc).paginate(:page => params[:page], :per_page => 2)
  end

  private

	  def search_params_format
	  	property_type_map = {}
	  	PropertyType.all.each do |pt|
	  		property_type_map[pt.title] = pt.name
	  	end
	  	{
	  		property_type_title: {
	  			id: 1,
	  			map: property_type_map,
  			},
	  		zone_name: 2,
	  		price: {
	  			currency: 3,
	  			price_min: 4,
	  			price_max: 5
  			},
  			area: 6,
  			rooms: 7
  		}
  	end

end
