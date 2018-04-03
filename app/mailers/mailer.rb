class Mailer < ApplicationMailer
  default from: '...@....com'

  def sendmail_confirm(user)
  	@user = user
    @craft = "..."

    mail to: user.email, subject: "Sign Up Confirmation"
  end
end
