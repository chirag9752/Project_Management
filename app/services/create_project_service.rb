class CreateProjectService
  def initialize(params)
    @params = params
  end

  def call
    project_params = extract_project_params
    if project_params
      project = Project.new(project_params.except(:user_List))
      user_List = project_params[:user_List]

      if user_List.any?
        user_emails = user_List.map { |user| user["email"] }
        list_of_users = User.where(email: user_emails)

        user_List_map = user_List.index_by { |user| user["email"] }
        
        if list_of_users.any?
          list_of_users.each do |user|
            timesheet = user_List_map[user.email]["timesheet"]
            billing_access = user_List_map[user.email]["billing_access"]
            profile_name = user_List_map[user.email]["profile_name"]
            profile = Profile.find_by(profile_name: profile_name)
              if profile
                profile_id = profile.id
              else
                new_profile = Profile.create!(profile_name: profile_name)
                profile_id = new_profile.id
              end
            project.project_users.build(user: user, timesheet: timesheet, billing_access: billing_access, profile_id: profile_id)
          end
          project.save!
          if project.persisted?
            { success: true, message: "Project created successfully", data: project }
          else
            { success: false, errors: project.errors.full_messages }
          end
        else
          { success: false, errors: ["No valid user found for the given emails"] }
        end
      else
        { success: false, errors: ["No user emails provided"] }
      end
    else
      { success: false, errors: ["Invalid project parameters"] }
    end
  end

  private

  def extract_project_params
    @params.require(:project).permit(:project_name, :billing_rate, user_List: [:email, :timesheet, :billing_access, :profile_name])
      rescue ActionController::ParameterMissing => e
        { success: false, errors: [e.message] }
  end
end