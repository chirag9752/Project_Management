class TimesheetsController < ApplicationController
  skip_before_action :verify_authenticity_token 
	before_action :authenticate_user!

	def fetch_single_timesheet
		timesheet = fetch_timesheet_data
		return render json: {}, status: :ok unless timesheet
		render json: { timesheet: timesheet }, status: :ok
	end

  def fetch_custom_date_pdf
    pdf_data = CustomDatePdfService.new(params).generate_pdf
    if pdf_data.nil?
      render json: { error: "No timesheets found for the given criteria" }, status: :not_found
    else
      send_data pdf_data, filename: "timesheet_report.pdf", type: "application/pdf", disposition: "attachment"  # send_data ensures the response is a downloadable PDF file.
    end
  end

  def fetch_custom_date_csv
    csv_data = CustomDatePdfService.new(params).generate_csv
    return head :no_content if csv_data.nil?

    send_data csv_data, filename: "timesheets.csv", type: "text/csv"
  end

	private

	def fetch_timesheet_data
		profile_id = fetch_profile_id
		project_id = fetch_project_id
		week_start_date = fetch_week_start_date
		user_id = fetch_user_id

		project_user = find_project_user(project_id, profile_id, user_id)
		return nil unless project_user

		find_timesheet(project_user.id, week_start_date)
	end

	def fetch_profile_id
		params.dig(:WeekData, :profile_Id)
	end
	
	def fetch_project_id
		params.dig(:WeekData, :project_Id)
	end
	
	def fetch_week_start_date
		params.dig(:WeekData, :week_start_date)
	end
	
	def fetch_user_id
		params.dig(:featureknown, :userid)
	end
	
	def find_project_user(project_id, profile_id, user_id)
		ProjectUser.find_by(project_id: project_id, profile_id: profile_id, user_id: user_id)
	end
	
	def find_timesheet(project_user_id, week_start_date)
		Timesheet.find_by(project_user_id: project_user_id, week_start_date: week_start_date)
	end
end
