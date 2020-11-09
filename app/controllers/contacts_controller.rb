class ContactsController < ApplicationController

  before_action :create, only: %i[completion]

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    render :new and return if params[:back] || !@contact.save
    render :completion
    Mailer::ContactMailer.general_contact_mail(@contact).deliver
    Mailer::ContactMailer.master_contact_mail(@contact).deliver
  end

  def confirm
    @contact = Contact.new(contact_params)
    if @contact.invalid?
      flash.now[:danger] = '入力内容にエラーがあります。'
      render :new
    end
  end

  def completion
  end

  private
  def contact_params
    params.require(:contact).permit(:email, :message)
  end

end
