class ReservationsController < ApplicationController
  def index
    @table = Table.find(params[:table_id])
  end

  def new
    @table = Table.find(params[:table_id])
  end

  def create
    @table = Table.find(params[:table_id])
    @reservation = @table.reservations.create!(reservation_params)
    redirect_to table_path(@table)
  end

  def reservation_params
    params.require(:reservation).permit(:start, :duration)
  end
end
