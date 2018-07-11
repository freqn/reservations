class TablesController < ApplicationController
  def index
    @tables = Table.all()
  end

  def show
    @table = Table.find(params[:id])
  end

  def new
    @table = Table.new()
  end
end
