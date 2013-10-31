class UserMailer < ActionMailer::Base
  default from: "kravlysite@gmail.com"

  def signup_confirmation(user)
    @user = user
    mail to: user.email, subject: "kravly - Welcome!"
  end

  def goodbye_message(user)
    @user = user
    mail to: user.email, subject: "kravly - Goodbye :("
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "kravly - Password Reset"
  end
end