class FeatureExecutionService
  def initialize(feature_name)
    @feature_name = feature_name
  end

  def call
    if respond_to?(@feature_name, true)   # here true means private methods also access
      send(@feature_name)            # call the createproject 
    else
      raise StandardError, "Feature #{@feature_name} not implemented"
    end
  end

  private

  def createproject
    CreateProjectService.new().call
  end

end