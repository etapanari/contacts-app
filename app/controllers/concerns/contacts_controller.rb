class ContactsController < ApplicationController
    def show
        @contact = Contact.find(params[:id])
    end

    def index
        @contacts = Contact.all
    end

    def create
        @contact = Contact.new(params.require(:contact).permit(:first_name, :last_name, :email, :phone_number))
        if @contact.save 
            flash[:notice] = "Contact was created successfully."
            redirect_to contact_path(@contact)
        else
            render 'new'
        end
    end

    def new
        @contact = Contact.new
    end
end