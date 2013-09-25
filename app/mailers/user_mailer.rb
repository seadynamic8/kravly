class UserMailer < ActionMailer::Base
  default from: "kravlysite@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def signup_confirmation(user)
    @user = user
    mail to: user.email, subject: "Signup Confirmation"
  end

  def goodbye_message(user)
    @user = user
    mail to: user.email, subject: "Goodbye :("
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Password Reset"
  end
end