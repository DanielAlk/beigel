class PromotionsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_promotion, only: [:show, :edit, :update, :destroy]
  layout 'panel'

  # GET /promotions
  # GET /promotions.json
  def index
    @promotions = Promotion.all
  end

  # GET /promotions/1
  # GET /promotions/1.json
  def show
  end

  # GET /promotions/new
  def new
    @promotion = Promotion.new
  end

  # GET /promotions/1/edit
  def edit
  end

  # POST /promotions
  # POST /promotions.json
  def create
    @promotion = Promotion.new(promotion_params)

    respond_to do |format|
      if @promotion.save
        format.html { redirect_to @promotion, notice: 'Promotion was successfully created.' }
        format.json { render :show, status: :created, location: @promotion }
      else
        format.html { render :new }
        format.json { render json: @promotion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /promotions/1
  # PATCH/PUT /promotions/1.json
  def update
    respond_to do |format|
      if @promotion.update(promotion_params)
        format.html { redirect_to @promotion, notice: 'Promotion was successfully updated.' }
        format.json { render :show, status: :ok, location: @promotion }
      else
        format.html { render :edit }
        format.json { render json: @promotion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /promotions/1
  # DELETE /promotions/1.json
  def destroy
    @promotion.destroy
    respond_to do |format|
      format.html { redirect_to promotions_url, notice: 'Promotion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # POST /promotions/many
  # POST /promotions/many.json
  def create_many
    ids = []
    promotions_errors = []
    promotionable_ids = params.require(:promotionable_ids)
    promotionable_type = promotion_params[:promotionable_type]
    promotionable_ids.each do |id|
      promotion = Promotion.where(promotionable_id: id, promotionable_type: promotionable_type).first
      if promotion.blank?
        promotion = Promotion.new(promotionable_id: id, promotionable_type: promotionable_type)
        unless promotion.save
          promotions_errors << promotion.errors
        end
      end
      ids << promotion.id
    end
    @promotions = Promotion.find(ids)
    respond_to do |format|
      unless promotions_errors.count > 0
        format.json { render :index, status: :created, location: promotions_url }
      else
        format.json { render json: promotions_errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /promotions
  # DELETE /promotions.json
  def destroy_many
    promotionable_ids = params.require(:promotionable_ids)
    promotionable_type = promotion_params[:promotionable_type]
    @promotions = Promotion.where(promotionable_id: promotionable_ids, promotionable_type: promotionable_type)
    @promotions.destroy_all
    respond_to do |format|
      format.html { redirect_to after_destroy_path, notice: 'Promotions where successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def after_destroy_path
      if params[:after_destroy_path].present?
        params[:after_destroy_path]
      else
        promotions_url
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_promotion
      @promotion = Promotion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def promotion_params
      params.require(:promotion).permit(:promotionable_id, :promotionable_type)
    end
end
