class TimesheetService
  def initialize(params)
    @params = params
  end

  def call
    timesheet = fetch_timesheet_params

    if timesheet.save
      message = timesheet.persisted? ? "Timesheet updated successfully" : "Timesheet created successfully"
      {success: true, message: message, data: timesheet}
    else 
      {success: false, error: "Failed to save timesheet", details: timesheet.error.full_messages}
    end
  end

  private

  def fetch_timesheet_params
    week_data = @params.dig("WeekData")
    profile_id = week_data["profile_Id"]
    project_id = week_data["project_Id"]
    week_start_date = week_data["week_start_date"]
    description = week_data["Description"]
    user_id = @params.dig("featureknown", "userid")

    # transform lowercase hours hash to lowecase keys and integer values

    daily_hours = week_data["Hours"].transform_keys(&:downcase).transform_values(&:to_i)

    total_hours = daily_hours.values.sum

    project_user = ProjectUser.find_by(project_id: project_id, profile_id: profile_id, user_id: user_id)

    if project_user.nil?
      { success: false, errors: "something wrong with projects or profile" }
    end

    # timesheet = Timesheet.find_by(project_user_id: project_user.id , week_start_date: week_start_date)
    
    timesheet = project_user.timesheets.find_or_initialize_by(week_start_date: week_start_date)
    
    timesheet.assign_attributes(
      total_hours: total_hours,
      status: timesheet.new_record? ? "new" : "updated",
      daily_hours: daily_hours,
      description: description,
      year: week_start_date.to_date.year
    )

    return timesheet
  end
end
