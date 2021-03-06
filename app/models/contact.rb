class Contact < MailForm::Base
# class Contact < ActionMailer::Base
  attribute :name,      :validate => true
  attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :message
  attribute :nickname,  :captcha  => true

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
        :subject => "My Contact Form",
        :to => Rails.application.secrets.contact_email,
        :from => %("Contact Form" <#{Rails.application.secrets.smtp_user}>)
    }


  end

end