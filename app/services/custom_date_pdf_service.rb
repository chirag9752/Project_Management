require 'prawn'

class CustomDatePdfService
  def initialize(params)
    @params = params
    @user_id = @params.dig(:data, :userId)
    @project_id = @params.dig(:data, :projectId)
    @profile_id = @params.dig(:data, :profileId)
    @start_date = Date.parse(@params.dig(:data, :startDate)) rescue nil
    @end_date = Date.parse(@params.dig(:data, :endDate)) rescue nil
  end

  def fetch_timesheets
    project_user = ProjectUser.find_by(user_id: @user_id, project_id: @project_id, profile_id: @profile_id)
    return [] unless project_user

    Timesheet.where(project_user_id: project_user.id).where("week_start_date BETWEEN ? AND ?", @start_date.beginning_of_week, @end_date.end_of_week)
  end

  def generate_csv
    timesheets = fetch_timesheets
    return nil if timesheets.empty?

    CSV.generate(headers: true) do |csv|
      csv << ["Week Start Date", "Total Hours", "Status", "Description", "Daily Hours"]
      timesheets.each do |timesheet|
        csv << [timesheet.week_start_date, timesheet.total_hours, timesheet.status, timesheet.description, timesheet.daily_hours.to_json]
      end
    end
  end

  def format_daily_hours(daily_hours)
    daily_hours.map { |day, hours| "#{day.capitalize}: #{hours}" }.join("\n")
  end

  def generate_pdf
    timesheets = fetch_timesheets
    return nil if timesheets.empty?

    Prawn::Document.new do |pdf|
      pdf.fill_color "FFFFFF"
      pdf.text "Timesheet Report", size: 18, style: :bold, color: "000000"
      pdf.move_down 10

      # Table Data (Header + Rows)
      table_data = [[
        {content: "Week Start Date", background_color: "333333", text_color: "FFFFFF"},
        {content: "Total Hours", background_color: "333333", text_color: "FFFFFF"},
        {content: "Status", background_color: "333333", text_color: "FFFFFF"},
        {content: "Description", background_color: "333333", text_color: "FFFFFF"},
        {content: "Daily Hours", background_color: "333333", text_color: "FFFFFF"}
      ]]

      timesheets.each do |timesheet|
        table_data << [
          {content: timesheet.week_start_date.to_s, text_color: "FF0000"},
          {content: timesheet.total_hours.to_s, text_color: "00AA00"},
          {content: timesheet.status, text_color: "0000FF"},
          {content: timesheet.description, text_color: "990099"},
          {content: format_daily_hours(timesheet.daily_hours), text_color: "482B10"}
        ]
      end

      # Create Table in PDF with customized column widths
      pdf.table(table_data, header: true, width: pdf.bounds.width, cell_style: { borders: [:top, :bottom, :left, :right], padding: [5, 5, 5, 5] }) do
        row(0).font_style = :bold
        row(0).align = :center
        columns(3..4).width = 140 # Increase width of first three columns
      end
    end.render
  end
end