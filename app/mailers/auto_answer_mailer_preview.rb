class AutoAnswerMailerPreview < ActionMailer::Preview
  def check_email
    AutoAnswerMailer.check_email(Feedback.first)
  end
end