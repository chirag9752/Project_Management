class ProjectsController < ApplicationController
  # skip_before_action :verify_authenticity_token, only: [:create]

  def index
    @projects = Project.all
    render json: {data: @projects}, status: :ok
  end

  def show
    @project = Project.find(params[:id])
    render json: {
      data: @project
    }, status: :ok
  end

  private
  def authenticate_BD
    @user = User.find(params[:user_id])
    render json: {error: 'Not authorized'}, status: :unauthorized unless user.role == "BD"
  end
end
