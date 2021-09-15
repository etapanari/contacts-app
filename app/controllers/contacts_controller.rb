class ContactsController < ApplicationController

    before_action :set_contact, only: [:show, :edit, :update, :destroy, :changes]

    def changes
        @audits = @contact.audits.take(8) # works
        @audited_changes = @contact.audits.select(:audited_changes)
        number_of_audits = @contact.audits.length-1
    
        @all_changes = []
        (0..number_of_audits).each do | index|
            
            @changes = @audits[index].audited_changes 
            #@changes[:created_at]=@audits[index].created_at
            @changes.merge!(created_at:@audits[index].created_at)
            @all_changes.append(@changes)

        end

        @audits.each do |item|
            
            puts @audited_changes
        end

        # @changes = @contact.audits.last.audited_changes
    end

    def show
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