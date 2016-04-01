class PagesController < ApplicationController
	before_action :set_slider_items, only: [:home, :developments]
	before_action :set_developments_limited, only: :home
	before_action :set_developments, only: :developments

  def home
  end

  def developments
  end

  private

	  def set_slider_items
	  	@slider_items = [ { cover: 'main-image-1.jpg', type: 'Emprendimiento', address: '11 de Septiembre 5762' }, { cover: 'main-image-2.jpg', type: 'Emprendimiento', address: 'Alvarez thomas 3321' }, { cover: 'main-image-3.jpg', type: 'PH', address: 'Alcaraz 6734' }, { cover: 'main-image-4.jpg', type: 'Emprendimiento', address: 'Elcano 1278' }, { cover: 'main-image-5.jpg', type: 'PH 3 Ambientes', address: 'Colombres 3426' }, { cover: 'main-image-6.jpg', type: 'CASA 5 Ambientes', address: 'Chivilcoy 8762' }, { cover: 'main-image-7.jpg', type: 'Emprendimiento', address: 'Cramer 3461' } ]
	  end

	  def set_developments_limited
	  	@developments = [ { cover: 'ventures-1.jpg', neighborhood: 'Palermo' }, { cover: 'ventures-2.jpg', neighborhood: 'Villa Urquiza' }, { cover: 'ventures-3.jpg', neighborhood: 'Recoleta' }, { cover: 'ventures-4.jpg', neighborhood: 'Villa Devoto' }, { cover: 'ventures-5.jpg', neighborhood: 'Cañitas' }, { cover: 'ventures-6.jpg', neighborhood: 'San Telmo' }, { cover: 'ventures-7.jpg', neighborhood: 'Belgrano' }, { cover: 'ventures-8.jpg', neighborhood: 'La Boca' } ]
	  end

	  def set_developments
	  	@developments = [ { cover: 'ventures-1.jpg', neighborhood: 'Palermo' }, { cover: 'ventures-2.jpg', neighborhood: 'Villa Urquiza' }, { cover: 'ventures-3.jpg', neighborhood: 'Recoleta' }, { cover: 'ventures-4.jpg', neighborhood: 'Villa Devoto' }, { cover: 'ventures-5.jpg', neighborhood: 'Cañitas' }, { cover: 'ventures-6.jpg', neighborhood: 'San Telmo' }, { cover: 'ventures-7.jpg', neighborhood: 'Belgrano' }, { cover: 'ventures-8.jpg', neighborhood: 'La Boca' }, { cover: 'ventures-9.jpg', neighborhood: 'Palermo' }, { cover: 'ventures-10.jpg', neighborhood: 'Villa Urquiza' }, { cover: 'ventures-11.jpg', neighborhood: 'Recoleta' }, { cover: 'ventures-12.jpg', neighborhood: 'Villa Devoto' }, { cover: 'ventures-13.jpg', neighborhood: 'Cañitas' }, { cover: 'ventures-14.jpg', neighborhood: 'San Telmo' }, { cover: 'ventures-15.jpg', neighborhood: 'Belgrano' }, { cover: 'ventures-16.jpg', neighborhood: 'La Boca' } ]
	  end

end