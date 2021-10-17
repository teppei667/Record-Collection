class ContactMailer < ApplicationMailer
  def send_mail(contact)
    @contact = contact
    mail to: ENV["SECRET_EMAIL"], subject: '【お問い合わせ】'
  end
end
