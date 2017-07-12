class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :destroy]
  skip_before_action :verify_authenticity_token

  # GET /contacts
  # GET /contacts.json
  def index
    @contacts = Contact.all
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
  end

  # GET /contacts/new
  def new
    @contact = Contact.new
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @contact = Contact.find_by_email(contact_params[:email])
 
    respond_to do |format|
      # TODO create db transaction https://stackoverflow.com/questions/2292815/save-an-active-records-array
      if !@contact.nil? and @contact.valid?
        save_contacttrace(@contact)
        format.html { redirect_to @contact, notice: 'Contact was successfully updated.' }
        format.json { render :show, status: :ok, location: @contact }      
      else
        @contact = Contact.new(contact_params)
        if @contact.save
          save_contacttrace(@contact)
          format.html { redirect_to @contact, notice: 'Contact was successfully created.' }
          format.json { render :show, status: :created, location: @contact }
        else
          format.html { render :new }
          format.json { render json: @contact.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /contacts/1
  # PATCH/PUT /contacts/1.json
  def update
    respond_to do |format|
      if @contact.update(contact_params)
        format.html { redirect_to @contact, notice: 'Contact was successfully updated.' }
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
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:email, :contacttrace)
    end
    def contacttrace_params
      params.require(:contacttrace).permit(contacttraces: [:url, :date_access])
    end

    def save_contacttrace(contact)
      params[:contacttrace].each do |item|
         cc = ContactTrace.new
         cc.url = item['url']
         cc.date_access = item['date_access']
         cc.contact = contact
        if !cc.save
          format.html { render :new }
          format.json { render json: cc.errors, status: :unprocessable_entity }
        end
      end
    end
end
