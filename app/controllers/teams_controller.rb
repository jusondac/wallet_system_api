class TeamsController < ApplicationController
  before_action :authenticate_user!

  def index
    teams = Team.all
    render json: teams
  end

  def show
    team = Team.find(params[:id])
    render json: team, include: :wallet
  end

  def create
    team = Team.new(team_params)
    if team.save
      team.create_wallet(balance: 0)
      render json: team, status: :created
    else
      render json: { errors: team.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def team_params
    params.require(:team).permit(:name)
  end
end
