class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def index
    @projects = Project.includes(:project_users)
    render json: {
      data: @projects.map do |project|
        {
          id: project.id,
          name: project.project_name,
          billing_rate: project.billing_rate,
          project_users: project.project_users.map do |project_user|
            {
              user_id: project_user.user_id,
              billing_access: project_user.billing_access,
              timesheet: project_user.timesheet
            }
          end
        }
      end
    }, status: :ok
  end

  def show
    @project = Project.includes(:project_users).find(params[:id])

    render json: {
      data:
        {
          id: @project.id,
          name: @project.project_name,
          billing_rate: @project.billing_rate,
          project_users: @project.project_users.map do |project_user|
            {
              user_id: project_user.user_id,
              billing_access: project_user.billing_access,
              timesheet: project_user.timesheet 
            }
          end,
          users: @project.users.map do |user|
            {
              id: user.id,
              name: user.name,
              email: user.email,
              created_at: user.created_at,
              updated_at: user.updated_at
            }
          end
        }
    }, status: :ok
  end
end
