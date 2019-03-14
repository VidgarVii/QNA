class DailyDigestMailer < ApplicationMailer

  def digest(user)
    @questions = Question.digest

    mail to: user.email,
         subject: 'New question to day'
  end
end
