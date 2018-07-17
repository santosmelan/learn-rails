class ContactsController < ApplicationController

	def new
	  @contact = Contact.new
	end

	def create
	  @contact = Contact.new(secure_params)

	  if @contact.valid?
	  	UserMailer.contact_email(@contact).deliver_now
	    flash[:notice] = "Message sent from #{@contact.name}."
	    redirect_to root_path
	  else
	  	flash[:alert] = []
	  	@contact.errors.full_messages.each do |msg|
	  		flash[:alert] << msg
	  	end
		redirect_to new_contact_path
	  end
	end

	private

	def secure_params
	  params.require(:contact).permit(:name, :email, :content)
	end

end