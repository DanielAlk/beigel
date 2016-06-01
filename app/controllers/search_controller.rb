class SearchController < ApplicationController
  include PrettyParams
	include FilteringForProperties

  def index
  	search_params = params.require(:search)
  	operation_type = 'rent'
  	if search_params.has_key?(:operation_type)
  		operation_type = search_params[:operation_type].respond_to?(:each)? search_params[:operation_type][0] : search_params[:operation_type]
  	end
  	search = operation_type == 'buy' ? 'comprar' : 'alquilar'
  	search << '/' + prettify_params(search_params)
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
		search_params = parse_pretty_params(search_params)
		search_params[:operation_type] = operation_type
		build_search(search_params)
		@properties = Property.active.filter(@search_filters)
		@properties = @properties.order(created_at: :desc).paginate(:page => params[:page], :per_page => 8)
  end

  protected

	  def pretty_params_format
	  	{
	  		property_type_slug: 1,
	  		zone_slug: 2,
	  		price: {
	  			currency: 3,
	  			price_min: 4,
	  			price_max: 5
  			},
  			area: 6,
  			rooms: 7,
        order_filter: 8
  		}
  	end

end
