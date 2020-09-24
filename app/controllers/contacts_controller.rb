class ContactsController < ApplicationController

  def new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.contact_mail(@contact).deliver
      flash[:success] = 'お問い合わせを受け付けました。'
      redirect_to completion_contact_path
    else
      render :new
    end
  end

  def confirm
    @contact = Contact.new
  end

  def completion
  end

  private
  def contact_params
    params.require(:contact).permit(:email, :message)
  end

end
