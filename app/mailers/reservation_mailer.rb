class ReservationMailer < ActionMailer::Base
  default from: ENV["gmail_username"]
  layout 'mailer'

  def confirmation_email(reservation)
    @reservation = reservation
    mail(to: @reservation.email, subject: 'Your reservation for Fancy New Restaurant is confirmed!')
  end
end
