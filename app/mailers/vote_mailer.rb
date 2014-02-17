class VoteMailer < ActionMailer::Base
  default from: "kravlycom@gmail.com"

  def vote_notification(idea)
  	@idea = idea
  	mail to: idea.user.email, subject: "Kravly - Someone voted on your idea!"
  end
end
