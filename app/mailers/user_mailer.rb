class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to Timesheet")
  end
end

#  note : do redis-server 
#  note : do bundle exec sidekiq
