class ContactsController < ApplicationController

  def index
    # contacts = Contact.all
    # render json: contacts
    user = User.find(params[:user_id])
    render json: [user.contacts, user.shared_contacts]
  end

  def create
    contact = Contact.new(contct_params)
    if contact.save
      render json: contact
    else
      render(
        json: contact.errors.full_messages, status: 422
      )
    end
  end

  def show
    contact = Contact.find(params[:id])
    render json: contact
  end

  def update
    contact = Contact.find(params[:id])
    if contact.update(contct_params)
      render json: contact
    else
      render(
        json: contact.errors.full_messages, status: 422
      )
    end
  end

  def destroy
    contact = Contact.find(params[:id])
    contact.destroy
    render json: contact
  end

  private
  def contct_params
    params.require(:contact).permit(:name, :email, :owner_id)
  end
end
