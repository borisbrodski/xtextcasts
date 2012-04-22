class Mailer < ActionMailer::Base
  def feedback(message)
    @message = message
    mail :to => "feedback@xtextcasts.org", :from => @message.email, :subject => "XtextCasts Feedback from #{@message.name}"
  end

  def comment_response(comment, user)
    @comment = comment
    @user = user
    mail :to => @user.email, :from => "noreply@xtextcasts.org", :subject => "Comment Response on XtextCasts"
  end
end
