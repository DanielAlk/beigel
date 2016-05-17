module FilteringForProperties
	extend ActiveSupport::Concern

	def build_search_params
		@search_filters = {}
		@search_params = params.slice(:operation_type, :price_min, :price_max, :currency, :property_type, :rooms, :zone, :area)
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
				if @operation_type.present? && value.present?
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
			when :property_type, :zone
				if value.present?
					@search_filters[key.to_sym] = value
				end
			end
		end
	end
end