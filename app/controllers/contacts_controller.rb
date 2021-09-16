class ContactsController < ApplicationController

    before_action :set_contact, only: [:show, :edit, :update, :destroy, :changes]

    
    def changes
        
        # These instance variables are set from the view dynamicaly as the view 
        # iterates over the @changes hash and are used to display all fields of 
        # 'History of edits' in the contacts/id/changes route
        # This is done because the audits table only holds the editted fields 
        # while I want to display all fields (changed and unchanged)
        @current_first_name=""
        @current_last_name=""
        @current_email=""
        @current_phone_number=""
        @current_timestamp=""

        number_of_audits = @contact.audits.length
        @audits = @contact.audits.take(number_of_audits) 

        # @all_changes array will store all the hashes of each audit/edit.
        # The edits are stored in the audited_changes column of the audits table
        # as a hash with key being the column name(ie first_name) and value
        # being a list with 2 elements. list[0] holds the value before edit
        # and list[1] holds the value after edit. Special case is the
        # initial creation of the record. It is also stored in the audited_changes
        # column of the table but the value of the hash is a string.
        # I also add to the @changes hash the created_at key-value pair
        @all_changes = [] 
        (0..number_of_audits-1).each do | index |            
            @changes = @audits[index].audited_changes
            @changes["created_at"] = @audits[index].created_at
            @all_changes.append(@changes)
        end
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