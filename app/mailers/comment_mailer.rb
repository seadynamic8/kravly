class CommentMailer < ActionMailer::Base
  default from: "kravlycom@gmail.com"

  def comment_notification(idea)
  	@idea = idea
  	mail to: idea.user.email, subject: "Kravly - Someone commented on your idea!"
  end
end
