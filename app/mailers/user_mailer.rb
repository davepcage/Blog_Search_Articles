class UserMailer < ApplicationMailer
  default from: 'notifications@blogs.com'

  def welcome_email
    @user = params[:user]
    @blog = params[:blog]
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Congratulations on your first article!')
  end

end
