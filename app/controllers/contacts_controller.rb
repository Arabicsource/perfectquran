# frozen_string_literal: true

class ContactsController < ApplicationController
  def new
  end

  def create
    contact = Contact.new(contact_params)

    if contact.valid?
      flash[:success] = 'your message was sent'
      ApplicationMailer.with(contact: contact).contact.deliver_now
    else
      flash[:danger] = 'your message was not sent'
    end

    redirect_to new_contact_path
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :body)
  end
end
