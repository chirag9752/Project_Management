class CreateProjectService
  def initialize(params)
    @params = params
  end

  def call
    project_params = extract_project_params
    return error_response("Invalid project parameters") unless project_params
  
    project = build_project(project_params)  
    return error_response("No user emails provided") unless project_params[:user_List].any?
  
    user_emails = extract_user_emails(project_params[:user_List])
    list_of_users = find_users_by_emails(user_emails)
    return error_response("No valid user found for the given emails") unless list_of_users.any?
  
    assign_project_users(project, list_of_users, project_params[:user_List])
    save_project(project)
  end
  
  private
  
  def extract_project_params
    @params.require(:project).permit(:project_name, :billing_rate, user_List: [:email, :timesheet, :billing_access, :profile_name])
  rescue ActionController::ParameterMissing => e
    { success: false, errors: [e.message] }
  end
  
  def build_project(project_params)
    Project.new(project_params.except(:user_List))
  end
  
  def extract_user_emails(user_list)
    user_list.map { |user| user["email"] }
  end
  
  def find_users_by_emails(user_emails)
    User.where(email: user_emails)
  end
  
  def assign_project_users(project, users, user_list)
    user_map = user_list.group_by { |user| user["email"] }
  
    users.each do |user|
      user_data_list = user_map[user.email]
  
      user_data_list.each do |user_data|
        profile_id = find_or_create_profile(user_data["profile_name"])
        project.project_users.build(
          user: user,
          timesheet: user_data["timesheet"],
          billing_access: user_data["billing_access"],
          profile_id: profile_id
        )
      end
    end
  end
  
  def find_or_create_profile(profile_name)
    profile = Profile.find_by(profile_name: profile_name)
    profile ? profile.id : Profile.create!(profile_name: profile_name).id
  end
  
  def save_project(project)
    if project.save
      { success: true, data: project }
    else
      { success: false, errors: project.errors.full_messages }
    end
  end
  
  def error_response(message)
    { success: false, errors: message }
  end
end