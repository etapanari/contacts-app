class ContactsController < ApplicationController
    def show
        @contact = Contact.find(params[:id])
    end

    def index
        @contacts = Contact.all
    end
end