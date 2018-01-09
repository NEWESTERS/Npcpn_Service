class AutoAnswerMailer < ApplicationMailer
	default :from => "from@example.com"

	def check_email(feedback)
	    @feedback = feedback
	    mail(:to => feedback.email, :subject => "Обращение в ГБУЗ НПЦ им. Соловьева ДЗМ")
  	end

  	def repliable_email(feedback)
  		@feedback = feedback
  		mail(:to => "newwwesters@gmail.com", :subject => "[npcpn] " + feedback.theme)
  	end

  	def dept_email(feedback)
  		@feedback = feedback
  		mail(:to => "newwwesters@gmail.com", :subject => '#' + feedback.id + ' ' + feedback.theme)
  	end
end
