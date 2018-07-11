class ReservationsController < ApplicationController
  def index
    @reservation = Reservation.new()
  end

  def new
    @reservation = Reservation.new()
  end

  def create
    @table = Table.select_smallest_available(reservation_params)
    @reservation = @table.reservations.create_with_duration!(reservation_params)
    redirect_to table_path(@table)
    # should show a flash saying success
    # should send an e-mail
    # should redirect to main page
  end

  def reservation_params
    params.require(:reservation).permit(:start, :duration, :party_size)
  end
end
