class FeatureAccessService
  def self.has_access?(user, feature_name) 
    return false if feature_name.blank?
    feature = Feature.find_by(feature_name: feature_name.feature_name)
    return false unless feature
    UserFeature.exists?(user_id: user.id, feature_id: feature.id)
  end
end
