class PagesController < ApplicationController
	before_action :set_showcase_items, except: [:developments, :file, :soon]
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

	  def set_showcase_items
	  	@showcase_items = ShowcaseItem.select { |showcase_item| showcase_item.showcaseable.active? }.shuffle
	  end

	  def set_developments_limited
	  	@developments = Development.active.limit 8
	  end

	  def set_developments
	  	@developments = Development.active.order(updated_at: :desc).paginate(:page => params[:page], :per_page => 8)
	  end

end