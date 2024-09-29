class UserMailer < ApplicationMailer
  default from: 'no-reply@example.com'

  def welcome_email(user)
    @user = user
    @url = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end

#
# class UserMailer < ApplicationMailer
#   default from: 'no-reply@example.com'
#
#   def welcome_email(user)
#     @user = user
#     @url = 'http://example.com/login'
#     logger.debug "Sending welcome email to: #{@user.email}"
#     mail(to: @user.email, subject: 'Welcome to My Awesome Site')
#   end
# end
