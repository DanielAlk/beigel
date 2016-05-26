class PagesController < ApplicationController
	before_action :set_slider_items
	before_action :set_developments_limited, only: :home
	before_action :set_developments, only: :developments
	layout 'soon', only: :soon

  def home
  end

  def developments
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
  	if params[:property_id].present?
  		@property = Property.friendly.find(params[:property_id])
  	end
  	if params[:development_id].present?
  		@development = Development.friendly.find(params[:development_id])
  	end
  end

  def soon
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
	  	@developments = Development.limit 8
	  end

	  def set_developments
	  	@developments = Development.order(updated_at: :desc).paginate(:page => params[:page], :per_page => 8)
	  end

end