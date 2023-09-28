class ContactMailer < ApplicationMailer
  default from: 'rebecca@rebeccaeddybacon.com'

  def send_email(first_name, last_name, email, phone, message)
    @first_name = first_name
    @last_name = last_name
    @email = email
    @phone = phone
    @message = message

    mail(
      to: 'erik_r@brothers-sonsamerica.com', 
      subject: 'BB&S America Website | New Contact Form Submission'
    )
    render 'send_email'
  end
end