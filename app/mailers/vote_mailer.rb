class VoteMailer < ActionMailer::Base
  default from: "kravlysite@gmail.com"

  def vote_notification(user, idea)
  	@user = user
  	@idea = idea
  	mail to: user.email, subject: "kravly - Someone voted on your idea!"
  end
end
