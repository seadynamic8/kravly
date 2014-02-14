class UserMailer < ActionMailer::Base
  default from: "kravlycom@gmail.com"

  def signup_confirmation(user)
    @user = user
    mail to: user.email, subject: "Kravly - Welcome!"
  end

  def goodbye_message(user)
    @user = user
    mail to: user.email, subject: "Kravly - Goodbye :("
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Kravly - Password Reset"
  end
end