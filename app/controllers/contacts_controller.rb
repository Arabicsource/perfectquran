# frozen_string_literal: true

# :nodoc:
class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(
      name: params[:name], email: params[:email], username: params[:username],
      message: params[:message]
    )

    if @contact.deliver
      flash[:success] = 'Alhamdulillah, your message was delivered'
      redirect_to root_url
    else
      render :new
    end
  end
end
