class UsersController < ApplicationController
  def index
    users = User.all
    render json: users
  end

  def show
    user = User.includes(:wallet).find(params[:id]).as_json(
      only: [:id, :name, :email],
      include: { wallet: { only: [], methods: :wallet_balance } }
    )
    render json: user, include: :wallet
  end

  def create
    user = User.new(user_params)
    if user.save
      user.create_wallet(balance: 0)
      render json: user, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
