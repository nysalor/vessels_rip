class AddSunkMonthAndSunkDayAndSunkHourAndSunkMinToVessel < ActiveRecord::Migration
  def change
    add_column :vessels, :sunk_month, :integer
    add_column :vessels, :sunk_day, :integer
    add_column :vessels, :sunk_hour, :integer
    add_column :vessels, :sunk_min, :integer
  end
end
