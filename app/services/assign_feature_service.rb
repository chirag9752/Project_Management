class AssignFeatureService
  def initialize(params)
    @params = params
  end

  def call
    @user = fetch_user
    @feature = fetch_feature
    if @user && @feature
      # Check if the feature is already assigned
      if @user.features.exists?(@feature.id)
        { success: false, errors: 'Feature already assigned' }
      else
        # Assign the feature to the user
        @user.features << @feature
        { success: true, message: 'Feature assigned successfully' }
      end
    else
      { success: false, errors: 'Invalid user or feature' }
    end
  end

  private

  def fetch_user
    user = User.find(@params[:assign_feature][:user_id])
  end

  def fetch_feature
    feature = Feature.find_by(feature_name: @params[:assign_feature][:feature_name])
  end
end