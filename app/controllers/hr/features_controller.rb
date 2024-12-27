class Hr::FeaturesController < ApplicationController
	before_action :check_feature_access, only: [:execute]
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!

  def index
    @feature = Feature.all
    render json: {data: @feature}, status: :ok
  end

	def execute
    result = call_features_services
      if result[:success]
        render json: {
          status: { 
            code: 201, 
            message: result[:message]
          },
          data: result[:data]
        }, status: :created
      else
        render json: { errors: result[:errors] }, status: :unprocessable_entity
      end
	end

  # return array of feature so that display only selected feature
  def checkinguserfeature
    @user = User.find(params[:userid]);
    if current_user && current_user.id == @user.id
      features = @user.features
      render json: { allowed_features: features.map(&:feature_name) }
    else
      render json: {error: "You are not authorized to access this request"}, status: :forbidden
    end
  end

	private

  def call_features_services
    feature_name = params.dig(:featureknown, :feature_name)
    service_class_name = FEATURES_CONFIG[feature_name]

    unless service_class_name
      return { success: false, errors: ["Feature #{feature_name} not implemented"] }
    end
    
    service_class = service_class_name.constantize
    service_instance = service_class.new(params)
    service_instance.call
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
