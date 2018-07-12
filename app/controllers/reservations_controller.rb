class ReservationsController < ApplicationController
  http_basic_authenticate_with name: "admin", password: "secret", only: [:destroy]

  def index
    @tables = Table.all.includes(:reservations)
  end

  def new
    @reservation = Reservation.new()
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @table       = Table.select_smallest_available(@reservation)

    unless @table
      flash[:message] = "No available tables at the selected time. :("
      return render 'new'
    end

    @reservation.table = @table
    return render 'new' unless @reservation.valid?

    @reservation = @table.reservations.create!(reservation_params)
    ReservationMailer.confirmation_email(@reservation).deliver
    flash[:message] = "You're all set! You will receive an e-mail with confirmation details shortly."
    redirect_to "/"
  end

  private
  def reservation_params
    # Ugh. Not loving what happened here.
    {
      party_size: params[:reservation][:party_size],
      end_time: calculated_end_time(),
      start: deuglified_start_datetime(),
      email: params[:reservation][:email]
    }
  end

  def calculated_end_time
    duration = params[:reservation][:duration]
    deuglified_start_datetime + duration.to_i.hours
  end

  def deuglified_start_datetime
    reservation = params[:reservation]

    DateTime.new(
      reservation["start(1i)"].to_i,
      reservation["start(2i)"].to_i,
      reservation["start(3i)"].to_i,
      reservation["start(4i)"].to_i,
      reservation["start(5i)"].to_i
    )
  end
end
