class ContactsController < ApplicationController
  before_action :authenticate_admin!, except: :create
  before_action :set_contact, only: [:show, :edit, :update, :destroy]
  before_action :mark_as_read, only: :show
  layout 'panel'

  # GET /contacts
  # GET /contacts.json
  def index
    order_params = params.require(:order).permit(:contactable, :subject, :name, :email, :tel, :read, :created_at) rescue {created_at: :desc}
    method_name = params.require(:filter).permit(Contact.subjects.keys.map {|k|k.to_sym}).keys[0] rescue :all
    contacts = Contact.where(nil)
    if params[:id].present?
      if request.path.start_with? '/properties'
        @object = Property.select(:id, :slug, :title).friendly.find(params[:id])
      elsif request.path.start_with? '/developments'
        @object = Development.select(:id, :slug, :title).friendly.find(params[:id])
      end
      contacts = contacts.where(contactable_id: @object.id, contactable_type: @object.class.name)
    end
    if order_params.present? && order_params[:contactable].present?
      contacts = contacts.public_send(method_name).includes(:property, :development).references(:all)
      contacts = contacts.order('properties.title ' + order_params[:contactable].upcase)
      contacts = contacts.order('developments.title ' + order_params[:contactable].upcase)
    else
      contacts = contacts.public_send(method_name).order(order_params)
    end
    @contacts = contacts.paginate(:page => params[:page], :per_page => 16)
  end

  # GET /contacts/select.json
  def select
    select_params = params.require(:select)
    if select_params[:count].blank?
      @contacts = Contact.select(:id, select_params[:param]).find(select_params[:ids])
    else
      @contacts = Contact.where(select_params[:param].map {|p| {p[0] => p[1]}}[0]).count
    end
    respond_to do |format|
      format.json { render :json => @contacts, status: :ok, location: contacts_path }
    end
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
    if params[:property_contact_id].present? && params[:id].present?
      if request.path.start_with? '/properties'
        @object = Property.select(:id, :slug, :title).friendly.find(params[:id])
      elsif request.path.start_with? '/developments'
        @object = Development.select(:id, :slug, :title).friendly.find(params[:id])
      end
    end
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
        AdminMailer.notification(@contact).deliver_now
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
      format.html { redirect_to after_destroy_path, notice: 'Contact was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # PATCH/PUT /contacts.json
  def update_many
    contact_ids = params.require(:contact)[:ids]
    @contacts = Contact.where(id: contact_ids)
    respond_to do |format|
      if @contacts.update_all(contact_params)
        format.json { render :index, status: :ok, location: contacts_path }
      else
        format.json { render json: @contacts.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts
  # DELETE /contacts.json
  def destroy_many
    contact_ids = params.require(:contact)[:ids]
    @contacts = Contact.where(id: contact_ids)
    @contacts.destroy_all
    respond_to do |format|
      format.html { redirect_to after_destroy_path, notice: 'Contacts where successfully destroyed.' }
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

    def after_destroy_path
      if params[:after_destroy_path].present?
        params[:after_destroy_path]
      else
        contacts_url
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
      @contact = Contact.find(params[:property_contact_id] || params[:development_contact_id] || params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:subject, :name, :email, :tel, :message, :data, :read, :contactable_id, :contactable_type)
    end
end
