class CreateTimeSheets < ActiveRecord::Migration[7.1]
  def change
    create_table :time_sheets do |t|
      t.timestamps
    end
  end
end
