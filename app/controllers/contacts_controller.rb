class ContactsController < ApplicationController

    before_action :set_contact, only: [:show, :edit, :update, :destroy]

    def show
        
        audit = @contact.audits.last
        audit.action 
        @changes = audit.audited_changes
        puts "Audited action"

    end

    def index
        @contacts = Contact.all
    end

    def new
        @contact = Contact.new
    end

    def edit

    end

    def create
        @contact = Contact.new(contact_params)
        if @contact.save 
            flash[:notice] = "Contact was created successfully."
            redirect_to @contact
        else
            render 'new'
        end
    end


    def update
        if @contact.update(contact_params)
          flash[:notice] = "Contact was updated successfully."
          redirect_to @contact
        else
          render 'edit'
        end
    end

    def destroy
        @contact.destroy
        redirect_to contacts_path
    end

    private
    def set_contact
        @contact = Contact.find(params[:id])
    end

    def contact_params
        params.require(:contact).permit(:first_name, :last_name, :email, :phone_number)        
    end
    
end