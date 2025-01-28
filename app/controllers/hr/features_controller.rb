class Hr::FeaturesController < ApplicationController
	before_action :check_feature_access, only: [:execute]
  skip_before_action :verify_authenticity_token                           # for desableing csrf 
  before_action :authenticate_user!

  def index
    @feature = Feature.all
    render json: {data: @feature}, status: :ok
  end

	def execute
    result = CallFeatureService.new(params).call
    if result[:success]
      render json: {data: result[:data] }, status: :ok
    else
      render json: { errors: result[:errors] }, status: :unprocessable_entity
    end
	end

  def checking_user_feature
    result = check_user_features(params[:userid])
    if result[:success]
      render json: result[:data], status: :ok
    else
      render json: {error: result[:error]}, status: result[:status]
    end
  end

	private

  def check_user_features(user_id)
    user = User.find_by(id: user_id)
    return {status: :not_found, error: "User not found" } if User.nil?
    return {status: :forbidden, error: "You are not authorized to access this request"} unless current_user&.id == user.id
    features = user.features
    { success: :true, data: {allowed_features: features.any? ? features.map(&:feature_name) : []} }
  end

  def check_feature_access
    @user = User.find(params[:featureknown][:userid].to_i)
    if current_user && current_user.id == @user.id
      @feature_name = Feature.find_by(feature_name: params[:featureknown][:feature_name])
      unless FeatureAccessService.has_access?(@user, @feature_name)
        render json: { error: 'Feature not enabled for this user' }, status: :forbidden
      end
    else
      render json: {error: "You are not authorized to access this request"}, status: :forbidden
    end
  end
end
