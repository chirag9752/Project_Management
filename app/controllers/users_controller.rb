class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :find_user, only: [:update, :detailsshow, :show]

  def update
    if @user.update(user_params)
      render json: {user: @user, profile_photo_url: url_for(@user.profile_photo)}
    else
      render json: { errors: @user.errors.full_messages },status: :unprocessable_entity
    end
  end

  def index
    render json: { data: fetch_profile }, status: :ok
  end

  def show
    render json: {data: @user}, status: :ok
  end

  def detailsshow
    render json: { 
      data: @user,
      profile_photo_url: fetch_single_user_profile(@user),
      projects: @user.projects.group('projects.id') }, status: :ok
  end

  private

  def fetch_profile
    users = User.all.map do |user|
      {
        id: user.id,
        name: user.name,
        email: user.email,
        profile_photo_url: fetch_single_user_profile(user)
      }
    end
  end

  def fetch_single_user_profile(user)
    url_for(user.profile_photo) if user.profile_photo.attached?
  end

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :profile_photo)
  end
end
