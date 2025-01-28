class TimesheetService
  def initialize(params)
    @params = params
  end

  def call
    timesheet = fetch_timesheet_data
    if timesheet.save
      {success: true, data: timesheet}
    else 
      {success: false, error: "Failed to save timesheet", details: timesheet.error.full_messages}
    end
  end

  private

  def fetch_timesheet_data
    week_data = extract_week_data
    return error_response("Missing WeekData") if week_data.nil?

    project_user = find_project_user(week_data)
    return error_response("Something wrong with projects or profile") if project_user.nil?

    daily_hours = calculate_daily_hours(week_data["Hours"])
    total_hours = daily_hours.values.sum

    timesheet = find_or_initialize_timesheet(project_user, week_data["week_start_date"])
    assign_timesheet_attributes(timesheet, week_data, daily_hours, total_hours)
    timesheet
  end

  def extract_week_data
    @params.dig("WeekData")
  end

  def find_project_user(week_data)
    ProjectUser.find_by(
      project_id: week_data["project_Id"],
      profile_id: week_data["profile_Id"],
      user_id: @params.dig("featureknown", "userid")
    )
  end
  
  def calculate_daily_hours(hours)
    hours.transform_keys(&:downcase).transform_values(&:to_i)
  end

  def find_or_initialize_timesheet(project_user, week_start_date)
    project_user.timesheets.find_or_initialize_by(week_start_date: week_start_date)
  end
  
  def assign_timesheet_attributes(timesheet, week_data, daily_hours, total_hours)
    timesheet.assign_attributes(
      total_hours: total_hours,
      status: timesheet.new_record? ? "new" : "updated",
      daily_hours: daily_hours,
      description: week_data["Description"],
      year: week_data["week_start_date"].to_date.year
    )
  end
end