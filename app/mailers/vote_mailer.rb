class VoteMailer < ActionMailer::Base
  default from: "kravlycom@gmail.com"

  def vote_notification(user, idea)
  	@user = user
  	@idea = idea
  	mail to: user.email, subject: "Kravly - Someone voted on your idea!"
  end
end
