class CreateProjectService
  def initialize(project_params)
    @project_params = project_params
  end

  def call
    @project = Project.new(@project_params)

    if @project.save
      { success: true, data: @project }
    else
      { success: false, errors: @project.errors.full_messages }
    end
  end
end
