class CallFeatureService
  def initialize(params)
    @params = params
  end

  def call
    feature_name = @params.dig(:featureknown, :feature_name)
    service_class_name = FEATURES_CONFIG[feature_name]
    unless service_class_name
      return { success: false, errors: ["Feature #{feature_name} not implemented"] }
    end
    service_class = service_class_name.constantize
    service_class.new(@params).call
  end
end