class Hr::FeaturesController < ApplicationController
	before_action :Find_user!, only: [:assign_feature, :remove_feature]
	before_action :check_feature_access, only: [:execute]
  skip_before_action :verify_authenticity_token

	def execute
    result = CreateProjectService.new(project_params).call
    
    if result[:success]
      render json: {
        status: { 
          code: 201, 
          message: 'Created Project successfully' 
        },
        data: result[:data]
      }, status: :created
    else
      render json: { errors: result[:errors] }, status: :unprocessable_entity
    end

	end

	def assign_feature
		user = User.find(params[:user_id])
		feature = Feature.find_by(name: params[:feature_name])

		if user && feature
      unless user.feature.include?(feature)
        user.feature << feature 
        render json: {message: 'Feature assigned successfully'}
      else
        render json: { message: 'Feature already assigned' }
      end
		else
			  render json: {error: 'Invalid user or feature'}, status: :unprocessable_entity
		end
	end

	def remove_feature
		user = User.find(params[:user_id])
		feature = Feature.find_by(name: params[:feature_name])

		if user && feature
			user.features.delete(feature)
			render json: {message: "Feature removed successfully"}, status: :ok
		else
			render json: {error: "Invalid user or feature"}, status: :unprocessable_entity
		end
	end

	private

	def Find_user!
		@user = User.find(params[:user_id])
		authenticate_hr!(@user);
	end

	def authenticate_hr!(user)
		render json: {error: 'Not authorized'}, status: :unauthorized unless user.role == "HR"
	end

  def project_params
    params.require(:project).permit(:project_name, :billing_rate, :user_id)
  end

  def check_feature_access
    @user = User.find(params[:id])
    @feature_name = Feature.find_by(feature_name: params[:featureknown][:feature_name])
    unless FeatureAccessService.has_access?(@user, @feature_name)
      render json: { error: 'Feature not enabled for this user' }, status: :forbidden
    end
  end
end
