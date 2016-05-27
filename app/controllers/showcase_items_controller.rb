class ShowcaseItemsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_showcase_item, only: [:show, :edit, :update, :destroy]
  layout 'panel'

  # GET /showcase_items
  # GET /showcase_items.json
  def index
    @showcase_items = ShowcaseItem.all
  end

  # GET /showcase_items/1
  # GET /showcase_items/1.json
  def show
  end

  # GET /showcase_items/new
  def new
    @showcase_item = ShowcaseItem.new
  end

  # GET /showcase_items/1/edit
  def edit
  end

  # POST /showcase_items
  # POST /showcase_items.json
  def create
    @showcase_item = ShowcaseItem.new(showcase_item_params)

    respond_to do |format|
      if @showcase_item.save
        format.html { redirect_to @showcase_item, notice: 'Showcase item was successfully created.' }
        format.json { render :show, status: :created, location: @showcase_item }
      else
        format.html { render :new }
        format.json { render json: @showcase_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /showcase_items/1
  # PATCH/PUT /showcase_items/1.json
  def update
    respond_to do |format|
      if @showcase_item.update(showcase_item_params)
        format.html { redirect_to @showcase_item, notice: 'Showcase item was successfully updated.' }
        format.json { render :show, status: :ok, location: @showcase_item }
      else
        format.html { render :edit }
        format.json { render json: @showcase_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /showcase_items/1
  # DELETE /showcase_items/1.json
  def destroy
    @showcase_item.destroy
    respond_to do |format|
      format.html { redirect_to showcase_items_url, notice: 'Showcase item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_showcase_item
      @showcase_item = ShowcaseItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def showcase_item_params
      params.require(:showcase_item).permit(:showcaseable_id, :showcaseable_type)
    end
end
