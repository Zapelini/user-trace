class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :update, :destroy]
  skip_before_action :verify_authenticity_token

  # GET /contacts
  # GET /contacts.json
  def index
    @contacts = Contact.all
    @contacttraces = ContactTrace.all
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
