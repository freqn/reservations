class ReservationsController < ApplicationController
  def index
  end

  def new
    @reservation = Reservation.new()
  end

  def create
    @table = Table.select_smallest_available(size: params[:table_size])
    @reservation = @table.reservations.create!(reservation_params)
    redirect_to table_path(@table)
    # should show a flash saying success
    # should send an e-mail
    # should redirect to main page
  end

  def reservation_params
    params.require(:reservation).permit(:start, :duration)
  end
end
