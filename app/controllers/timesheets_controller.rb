class TimesheetsController < ApplicationController
  skip_before_action :verify_authenticity_token 
	before_action :authenticate_user!

	def fetch_single
		timesheet = fetch_timesheet_params
		if timesheet
			render json: {
				message: "Timesheet fetched successfully",
				timesheet: timesheet
			}, status: :ok
		else
			render json: {
				message: "Timesheet is empty of this particular week please update it now!"
			}, status: :ok
		end
	end

	private

	def fetch_timesheet_params
		profile_id = params.dig(:WeekData, :profile_Id)
		project_id = params.dig(:WeekData, :project_Id)
		week_start_date = params.dig(:WeekData, :week_start_date)
		user_id = params.dig(:featureknown, :userid)

		project_user = ProjectUser.find_by(project_id: project_id, profile_id: profile_id, user_id: user_id)

		return nil unless project_user

		timesheet = Timesheet.find_by(project_user_id: project_user.id, week_start_date: week_start_date)
    
		return timesheet
	end
end
