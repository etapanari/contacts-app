class ContactsController < ApplicationController
    def show
        @contact = Contact.find(params[:id])
    end

    def index
        @contacts = Contact.all
    end

    def new
        @contact = Contact.new
    end

    def edit
        @contact = Contact.find(params[:id])
    end


    def create
        @contact = Contact.new(params.require(:contact).permit(:first_name, :last_name, :email, :phone_number))
        if @contact.save 
            flash[:notice] = "Contact was created successfully."
            redirect_to @contact
        else
            render 'new'
        end
    end


    def update
        @contact = Contact.find(params[:id])
        if @contact.update(params.require(:contact).permit(:first_name, :last_name, :email, :phone_number))
          flash[:notice] = "Contact was updated successfully."
          redirect_to @contact
        else
          render 'edit'
        end
    end

    def destroy
        @contact = Contact.find(params[:id])
        @contact.destroy
        redirect_to contacts_path
    end
end