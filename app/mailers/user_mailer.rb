class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def status_email
    @parcel = params[:parcel]
    @sender = @parcel.sender
    @receiver = @parcel.receiver
    @url  = 'http://localhost:3000/search'
    mail(to: @receiver.email, cc: @sender.email,  subject: 'New Parcel Information')
  end

  def password_email
    @user = params[:user]
    @password = params[:password]
    @url  = 'http://localhost:3000/users/sign_in'
    mail(to: @user.email,  subject: 'Your Password for Login')
  end
end
