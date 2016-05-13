class PropertiesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_property, only: [:show, :edit, :update, :clone, :destroy]
  before_action :related_objects, only: :update
  layout 'panel'

  # GET /properties
  # GET /properties.json
  def index
    @properties = Property.all
  end

  # GET /properties/1
  # GET /properties/1.json
  def show
  end

  # GET /properties/new
  def new
    @property = Property.new
  end

  # GET /properties/1/edit
  def edit
  end

  # POST /properties
  # POST /properties.json
  def create
    @property = Property.new(property_params)

    respond_to do |format|
      if @property.save
        format.html { redirect_to property_status_path, notice: 'Property was successfully created.' }
        format.json { render :show, status: :created, location: @property }
      else
        format.html { render :new }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /properties/1
  # PATCH/PUT /properties/1.json
  def update
    respond_to do |format|
      if @property.update(property_params)
        format.html { redirect_to property_status_path, notice: 'Property was successfully updated.' }
        format.json { render :show, status: :ok, location: @property }
      else
        format.html { render :edit }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  
  def clone
    property = @property.dup
    @property.characteristics.each do |ch|
      char = ch.dup
      char.classifiable = property
      char.save
    end
    @property.images.each do |img|
      image = property.images.new
      image.item = img.item
      image.save
    end
    property.status = :copy

    respond_to do |format|
      if property.save
        format.html { redirect_to edit_property_path(property), notice: 'Property was successfully created.' }
        format.json { render :show, status: :created, location: property }
      else
        format.html { render :new }
        format.json { render json: property.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /properties/1
  # DELETE /properties/1.json
  def destroy
    @property.destroy
    respond_to do |format|
      format.html { redirect_to properties_url, notice: 'Property was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def property_status_path
      if @property.draft?
        edit_property_path @property, @property.step
      else
        @property
      end
    end

    def related_objects
      # Characteristics
      available_characteristic_ids = params.require(:property)[:characteristics]
      if available_characteristic_ids.present? && available_characteristic_ids.count > 0
        options = params.require(:property)[:options]
        @property.characteristics.each do |char|
          unless available_characteristic_ids.include? char.available_characteristic_id.to_s
            char.destroy
          end
        end
        available_characteristic_ids.each do |ac_id|
          characteristic = @property.characteristics.find_by(available_characteristic_id: ac_id)
          if characteristic.blank?
            characteristic = @property.characteristics.new(available_characteristic_id: ac_id)
          end
          if options[ac_id].present?
            characteristic.option_value = options[ac_id]
            characteristic.save
          end
        end
      end
      # Image Titles
      image_titles = params.require(:property)[:image_titles]
      if image_titles.present? && image_titles.count > 0
        image_titles.each do |image_title|
          image_id = image_title[0]
          title = image_titles[image_id]
          image = Image.find(image_id)
          if image.present?
            image.update(title: title)
          end
        end
      end
      # Videos
      video_urls = params.require(:property)[:video_urls]
      if video_urls.present? && video_urls.count > 0
        @property.videos.each do |video|
          if video.url.blank? || !video_urls.include?(video.url)
            video.destroy
          end
        end
        video_urls.each do |video_url|
          if video_url.present? && @property.videos.find_by(url: video_url).blank?
            @property.videos.new url: video_url
          end
        end
      elsif params.require(:property)[:step] == 'multimedia'
        @property.videos.destroy_all
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_property
      @property = Property.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def property_params
      pp = params.require(:property).permit(:title, :info, :description, :status, :property_type_id, :age, :environments, :garages, :bathrooms, :toilettes, :expenses, :sale_price, :sale_currency, :rent_price, :rent_currency, :area_unit, :constructed_area, :unconstructed_area, :zone_id, :address, :zip_code, :lat, :lng)
      pp[:expenses].tr!('.', '') if pp[:expenses].present?
      pp[:sale_price].tr!('.', '') if pp[:sale_price].present?
      pp[:rent_price].tr!('.', '') if pp[:rent_price].present?
      pp[:constructed_area].tr!('.', '') if pp[:constructed_area].present?
      pp[:unconstructed_area].tr!('.', '') if pp[:unconstructed_area].present?
      return pp
    end
end
