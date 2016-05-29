class ContactsController < ApplicationController
  before_action :authenticate_admin!, except: :create
  before_action :set_contact, only: [:show, :edit, :update, :destroy]
  before_action :mark_as_read, only: :show
  layout 'panel'

  # GET /contacts
  # GET /contacts.json
  def index
    order_params = params.require(:order).permit(:contactable_id, :subject, :name, :email, :tel, :created_at) rescue {created_at: :desc}
    method_name = params.require(:filter).permit(Contact.subjects.keys.map {|k|k.to_sym}).keys[0] rescue :all
    @contacts = Contact.public_send(method_name).order(order_params).paginate(:page => params[:page], :per_page => 16)
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
  end

  # GET /contacts/new
  def new
    @contact = Contact.new
  end

  # GET /contacts/1/edit
  def edit
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @contact = Contact.new(contact_params)

    respond_to do |format|
      if @contact.save
        format.html { redirect_to after_save_path, notice: 'Gracias por comunicarte con Beigel Bienes Raices.<br>Un profesional responderá su consulta a la brevedad.' }
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contacts/1
  # PATCH/PUT /contacts/1.json
  def update
    respond_to do |format|
      if @contact.update(contact_params)
        format.html { redirect_to after_save_path, notice: 'Contact was successfully updated.' }
        format.json { render :show, status: :ok, location: @contact }
      else
        format.html { render :edit }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_url, notice: 'Contact was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def after_save_path
      if params[:after_save_path].present?
        params[:after_save_path]
      else
        @contact
      end
    end

    def mark_as_read
      unless @contact.read
        @contact.read = true
        @contact.save
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:subject, :name, :email, :tel, :message, :data, :read, :contactable_id, :contactable_type)
    end
end
