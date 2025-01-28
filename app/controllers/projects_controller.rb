class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def index
    @projects = Project.includes(:project_users)
    render json: { data: serialized_projects(@projects) }, status: :ok
  end

  def show
    @project = Project.includes(:project_users, :users).find(params[:id])
    render json: { data: serialized_single_project(@project) }, status: :ok
  end

  private

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
        user_id: project_user.user_id,
        billing_access: project_user.billing_access,
        timesheet: project_user.timesheet
      }
    end
  end

  # show methods

  def serialized_single_project(project)
    {
      id: project.id,
      name: project.project_name,
      billing_rate: project.billing_rate,
      project_users: serialized_single_project_users(project.project_users),
      users: serialized_single_users(project.users)
    }
  end

  def serialized_single_project_users(project_users)
    project_users.map do |project_user|
      {
        user_id: project_user.user_id,
        billing_access: project_user.billing_access,
        timesheet: project_user.timesheet,
        profile_id: project_user.profile_id,
        profile_name: project_user.profile.profile_name,
        total_hours: fetch_total_hours(project_user.profile_id, project_user.user_id, project_user.project_id)
      }
    end
  end

  def fetch_total_hours(profile_id, user_id, project_id)
    project_user = ProjectUser.find_by(project_id: project_id, profile_id: profile_id, user_id: user_id);
    timesheet = Timesheet.find_by(project_user_id: project_user.id)
    if timesheet
      timesheet.total_hours
    else
      0
    end
  end

  def serialized_single_users(users)
    users.map do |user|
      {
        id: user.id,
        name: user.name,
        email: user.email,
        created_at: user.created_at,
        updated_at: user.updated_at
      }
    end
  end
end








































 # def index
  #   @projects = Project.includes(:project_users)
  #   render json: {
  #     data: @projects.map do |project|
  #       {
  #         id: project.id,
  #         name: project.project_name,
  #         billing_rate: project.billing_rate,
  #         project_users: project.project_users.map do |project_user|
  #           {
  #             user_id: project_user.user_id,
  #             billing_access: project_user.billing_access,
  #             timesheet: project_user.timesheet
  #           }
  #         end
  #       }
  #     end
  #   }, status: :ok
  # end

    # def show
  #   @project = Project.includes(:project_users).find(params[:id])

  #   render json: {
  #     data:
  #       {
  #         id: @project.id,
  #         name: @project.project_name,
  #         billing_rate: @project.billing_rate,
  #         project_users: @project.project_users.map do |project_user|
  #           {
  #             user_id: project_user.user_id,
  #             billing_access: project_user.billing_access,
  #             timesheet: project_user.timesheet,
  #             profile_id: project_user.profile_id,
  #             profile_name: project_user.profile.profile_name,
  #           }
  #         end,
  #         users: @project.users.map do |user|
  #           {
  #             id: user.id,
  #             name: user.name,
  #             email: user.email,
  #             created_at: user.created_at,
  #             updated_at: user.updated_at
  #           }
  #         end
  #       }
  #   }, status: :ok
  # end