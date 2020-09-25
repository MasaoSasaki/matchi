class ContactsController < ApplicationController

  before_action :create, only: %i[completion]

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    render :new and return if params[:back] || !@contact.save
    ContactMailer.contact_mail(@contact).deliver
    flash[:success] = 'お問い合わせを受け付けました。'
    render :completion
  end

  def confirm
    @contact = Contact.new(contact_params)
    render :new if @contact.invalid?
  end

  def completion
    @contact = Contact.new(contact_params)
    render :new if @contact.invalid?
  end

  private
  def contact_params
    params.require(:contact).permit(:email, :message)
  end

end
