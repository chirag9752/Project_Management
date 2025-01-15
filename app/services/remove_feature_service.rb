class RemoveFeatureService
  def initialize(params)
    @params = params
  end

  def call
    @user = fetch_user
    @feature = fetch_feature
    if @user && @feature
      if @user.features.exists?(@feature.id)
        UserFeature.delete_by(user_id: @user.id)
        { success: true, message: 'Feature removed successfully'}
      else
        { success: false, errors: "Feature is not assigned to user #{@user.name}" }
      end
    else
      { success: false, errors: 'Invalid user or feature' }
    end
  end

  private
  
  def fetch_user
    user = User.find_by(id: @params.dig(:assign_feature, :user_id))
  end

  def fetch_feature
    feature = Feature.find_by(feature_name: @params.dig(:assign_feature, :feature_name))
  end
end