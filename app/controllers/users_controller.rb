class UsersController < ApplicationController
 
  # def update_role
  #   #  HR CAN update other users role need this code to be here
  # end

  def index
    @user = User.all
    render json: {data: @user}, status: :ok
  end

  def show
    @user = User.find(params[:id])
    render json: {data: @user}, status: :ok
  end

  def detailsshow
    @user = User.includes(:projects).find(params[:id]) # Includes projects to optimize query
    render json: {
      data: @user,
      projects: @user.projects
    }, status: :ok
  end
end
