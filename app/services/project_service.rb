class ProjectService

  def initialize(params)
    @params = params
  end

  def call
    user = fetch_current_user
    @projects = user.projects.includes(:project_users).group('projects.id')
    { success: true, data: serialized_projects(@projects) }
  end

  private

  def fetch_current_user
    User.find(@params.dig(:featureknown, :userid))
  end

  def serialized_projects(projects)
    projects.map do |project|
      {
        id: project.id,
        name: project.project_name,
        billing_rate: project.billing_rate,
        project_users: serialized_project_users(project.project_users)
      }
    end
  end

  def serialized_project_users(project_users)
    project_users.map do |project_user|
      {
        project_user_id: project_user.id,
        user_id: project_user.user_id,
        billing_access: project_user.billing_access,
        timesheet: project_user.timesheet
      }
    end
  end
end