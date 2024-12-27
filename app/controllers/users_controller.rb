class UsersController < ApplicationController
  before_action :authorize_hr_for_role_update, only: [:update_role]

  def update_role
    #  HR CAN update other users role need this code to be here
  end

  def index
    @user = User.all
    render json: {data: @user}, status: :ok
  end

  def show
    @user = User.find(params[:id])
    render json: {data: @user}, status: :ok
  end

  private

  def authorize_hr_for_role_update
    unless current_user.role == "HR"
      render json: { error: "You are not authorized to update roles" }, status: :forbidden
    end
  end
end
