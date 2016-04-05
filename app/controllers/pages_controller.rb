class PagesController < ApplicationController
	before_action :set_slider_items
	before_action :set_developments_limited, only: :home
	before_action :set_developments, only: :developments
	before_action :set_properties_for_buy, only: :file
	before_action :set_units, only: :file

  def home
  end

  def developments
  end

  def search
  	search_params = params.require(:search)
  	search = search_params.has_key?(:operation_type) && search_params[:operation_type][0] == 'buy' ? 'comprar' : 'alquilar'
  	search << '/' + build_params_string(search_params, {
  		property_type: 1,
  		neighborhood: 2,
  		price: {
  			currency: 3,
  			price_min: { id: 4, digit: true },
  			price_max: { id: 5, digit: true }
  		},
  		surface: 6,
  		rooms: 'amb'
  	})

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
		@search_params = parse_params_string(search_params, {
			property_type: 1,
			neighborhood: 2,
			price: {
				currency: 3,
				price_min: { id: 4, digit: true },
				price_max: { id: 5, digit: true }
			},
			surface: 6,
			rooms: 'amb'
		})
  end

  def friends
  end

  def about
  end

  def contact
  end

  def services
  end

  def assessments
  end

  def investments
  end

  def file
  end

  private

	  def set_slider_items
	  	@slider_items = [
	  		{ cover: 'main-image-1.jpg', type: 'Emprendimiento', address: '11 de Septiembre 5762' },
	  		{ cover: 'main-image-2.jpg', type: 'Emprendimiento', address: 'Alvarez thomas 3321' },
	  		{ cover: 'main-image-3.jpg', type: 'PH', address: 'Alcaraz 6734' },
	  		{ cover: 'main-image-4.jpg', type: 'Emprendimiento', address: 'Elcano 1278' },
	  		{ cover: 'main-image-5.jpg', type: 'PH 3 Ambientes', address: 'Colombres 3426' },
	  		{ cover: 'main-image-6.jpg', type: 'CASA 5 Ambientes', address: 'Chivilcoy 8762' },
	  		{ cover: 'main-image-7.jpg', type: 'Emprendimiento', address: 'Cramer 3461' }
	  	].shuffle
	  end

	  def set_developments_limited
	  	@developments = [
	  		{ cover: 'ventures-1.jpg', neighborhood: 'Palermo' },
	  		{ cover: 'ventures-2.jpg', neighborhood: 'Villa Urquiza' },
	  		{ cover: 'ventures-3.jpg', neighborhood: 'Recoleta' },
	  		{ cover: 'ventures-4.jpg', neighborhood: 'Villa Devoto' },
	  		{ cover: 'ventures-5.jpg', neighborhood: 'Cañitas' },
	  		{ cover: 'ventures-6.jpg', neighborhood: 'San Telmo' },
	  		{ cover: 'ventures-7.jpg', neighborhood: 'Belgrano' },
	  		{ cover: 'ventures-8.jpg', neighborhood: 'La Boca' }
	  	].shuffle
	  end

	  def set_developments
	  	@developments = [
	  		{ cover: 'ventures-1.jpg', neighborhood: 'Palermo' },
	  		{ cover: 'ventures-2.jpg', neighborhood: 'Villa Urquiza' },
	  		{ cover: 'ventures-3.jpg', neighborhood: 'Recoleta' },
	  		{ cover: 'ventures-4.jpg', neighborhood: 'Villa Devoto' },
	  		{ cover: 'ventures-5.jpg', neighborhood: 'Cañitas' },
	  		{ cover: 'ventures-6.jpg', neighborhood: 'San Telmo' },
	  		{ cover: 'ventures-7.jpg', neighborhood: 'Belgrano' },
	  		{ cover: 'ventures-8.jpg', neighborhood: 'La Boca' },
	  		{ cover: 'ventures-9.jpg', neighborhood: 'Palermo' },
	  		{ cover: 'ventures-10.jpg', neighborhood: 'Villa Urquiza' },
	  		{ cover: 'ventures-11.jpg', neighborhood: 'Recoleta' },
	  		{ cover: 'ventures-12.jpg', neighborhood: 'Villa Devoto' },
	  		{ cover: 'ventures-13.jpg', neighborhood: 'Cañitas' },
	  		{ cover: 'ventures-14.jpg', neighborhood: 'San Telmo' },
	  		{ cover: 'ventures-15.jpg', neighborhood: 'Belgrano' },
	  		{ cover: 'ventures-16.jpg', neighborhood: 'La Boca' }
	  	].shuffle
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

	  def set_units
	  	@units = [
	  		{ address: 'Caboto 420', rooms: 3, covered_area: 92.00, area: 95.70, garage: 'No', sale_price: 2522898, rent_price: nil },
	  		{ address: 'Caboto 420', rooms: 3, covered_area: 94.16, area: 98.02, garage: 'No', sale_price: 2332313, rent_price: nil },
	  		{ address: 'Caboto 420', rooms: 3, covered_area: 89.41, area: 94.00, garage: 'No', sale_price: 2324889, rent_price: nil },
	  		{ address: 'Caboto 420', rooms: 3, covered_area: 75.41, area: 78.00, garage: 'No', sale_price: 2029176, rent_price: nil },
	  		{ address: 'Caboto 420', rooms: 3, covered_area: 58.59, area: 93.68, garage: 'No', sale_price: 1955504, rent_price: nil },
	  		{ address: 'Caboto 420', rooms: 3, covered_area: 84.68, area: 87.21, garage: 'No', sale_price: 1945850, rent_price: nil },
	  		{ address: 'Caboto 420', rooms: 3, covered_area: 92.00, area: 95.70, garage: 'No', sale_price: 2522898, rent_price: nil },
	  		{ address: 'Caboto 420', rooms: 3, covered_area: 94.16, area: 98.02, garage: 'No', sale_price: 2332313, rent_price: nil },
	  		{ address: 'Caboto 420', rooms: 3, covered_area: 89.41, area: 94.00, garage: 'No', sale_price: 2324889, rent_price: nil },
	  		{ address: 'Caboto 420', rooms: 3, covered_area: 75.41, area: 78.00, garage: 'No', sale_price: 2029176, rent_price: nil },
	  		{ address: 'Caboto 420', rooms: 3, covered_area: 58.59, area: 93.68, garage: 'No', sale_price: 1955504, rent_price: nil },
	  		{ address: 'Caboto 420', rooms: 3, covered_area: 84.68, area: 87.21, garage: 'No', sale_price: 1945850, rent_price: nil }
	  	]
  	end

end