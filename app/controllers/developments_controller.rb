class DevelopmentsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_development, only: [:show, :edit, :update, :destroy]
  before_action :related_objects, only: :update
  layout 'panel'

  # GET /developments
  # GET /developments.json
  def index
    @developments = Development.all
  end

  # GET /developments/1
  # GET /developments/1.json
  def show
  end

  # GET /developments/new
  def new
    @development = Development.new
  end

  # GET /developments/1/edit
  def edit
    if params[:property_id].present?
      @property = Property.friendly.find params[:property_id]
    end
  end

  # POST /developments
  # POST /developments.json
  def create
    @development = Development.new(development_params)

    respond_to do |format|
      if @development.save
        format.html { redirect_to after_save_path, notice: 'Development was successfully created.' }
        format.json { render :show, status: :created, location: @development }
      else
        format.html { render :new }
        format.json { render json: @development.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /developments/1
  # PATCH/PUT /developments/1.json
  def update
    respond_to do |format|
      if @development.update(development_params)
        format.html { redirect_to after_save_path, notice: 'Development was successfully updated.' }
        format.json { render :show, status: :ok, location: @development }
      else
        format.html { render :edit }
        format.json { render json: @development.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /developments/1
  # DELETE /developments/1.json
  def destroy
    @development.destroy
    respond_to do |format|
      format.html { redirect_to developments_url, notice: 'Development was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def after_save_path
      if params[:after_save_path].present?
        params[:after_save_path]
      elsif @development.draft?
        edit_development_path @development, @development.step
      else
        @development
      end
    end

    def related_objects
      # Characteristics
      available_characteristic_ids = params.require(:development)[:characteristics]
      if available_characteristic_ids.present? && available_characteristic_ids.count > 0
        options = params.require(:development)[:options]
        @development.characteristics.each do |char|
          unless available_characteristic_ids.include? char.available_characteristic_id.to_s
            char.destroy
          end
        end
        available_characteristic_ids.each do |ac_id|
          characteristic = @development.characteristics.find_by(available_characteristic_id: ac_id)
          if characteristic.blank?
            characteristic = @development.characteristics.new(available_characteristic_id: ac_id)
          end
          if options[ac_id].present?
            characteristic.option_value = options[ac_id]
            characteristic.save
          end
        end
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_development
      @development = Development.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def development_params
      params.require(:development).permit(:title, :info, :description, :status, :development_type_id, :stage, :delivery_month, :delivery_year, :zone_id, :address, :zip_code, :lat, :lng)
    end
end
