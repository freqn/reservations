class TablesController < ApplicationController
  http_basic_authenticate_with name: ADMIN_USERNAME, password: ADMIN_PASSWORD

  def index
    @tables = Table.all()
  end

  def show
    @table = Table.find(params[:id])
  end

  def new
    @table = Table.new()
  end

  def create
    @table = Table.new(table_params)

    if @table.save
      redirect_to table_path(@table)
    else
      render 'new'
    end
  end

  def edit
    @table = Table.find(params[:id])
  end

  def update
    @table = Table.find(params[:id])

    if @table.update(table_params)
      redirect_to table_path(@table)
    else
      render 'edit'
    end
  end

  def destroy
    @table = Table.find(params[:id])
    @table.destroy

    redirect_to tables_path
  end

  private
  def table_params
    params.require(:table).permit(:name, :seats)
  end
end
