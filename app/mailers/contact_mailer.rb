class ContactMailer < ApplicationMailer
  default from: 'info@brothers-sonsamerica.com'

  def send_email(first_name, last_name, email, phone, message)
    @first_name = first_name
    @last_name = last_name
    @email = email
    @phone = phone
    @message = message

    mail(
      to: 'carterbacon.code@gmail.com', 
      subject: 'BB&S America Website | New Contact Form Submission'
    )
    render 'send_email'
  end
end