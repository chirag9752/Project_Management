class CreateProjectService
  def initialize(params)
    @params = params
  end

  def call
    project_params = extract_project_params
    if project_params
      project = Project.create!(project_params)
      if project.persisted?
        { success: true, message: "Project created successfully", data: project }
      else
        { success: false, errors: project.errors.full_messages }
      end
    else
      { success: false, errors: project_params.errors.full_messages }
    end
  end

  private

  def extract_project_params
    @params.require(:project).permit(:project_name, :billing_rate, :user_id)
      rescue ActionController::ParameterMissing => e
       e.errors.full_messages
  end
end