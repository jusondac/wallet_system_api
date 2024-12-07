class StocksController < ApplicationController
  def index
    stocks = Stock.all
    render json: stocks
  end

  def show
    stock = Stock.find(params[:id])
    render json: stock, include: :wallet
  end

  def create
    stock = Stock.new(stock_params)
    if stock.save
      stock.create_wallet(balance: 0)
      render json: stock, status: :created
    else
      render json: { errors: stock.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def stock_params
    params.require(:stock).permit(:name, :symbol)
  end
end
