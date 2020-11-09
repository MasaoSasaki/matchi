class Mailer::ContactMailer < ApplicationMailer

  # 問い合わせ主側
  def general_contact_mail(contact)
    @contact = contact
    mail to: contact.email, subject: "お問い合わせ完了"
  end

  # 管理者側
  def master_contact_mail(contact)
    @contact = contact
    mail to: "mail@matchi-gourmet.com", subject: "お問い合わせ"
  end

end
