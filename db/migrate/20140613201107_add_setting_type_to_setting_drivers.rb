class AddSettingTypeToSettingDrivers < ActiveRecord::Migration
  def change
    add_column :setting_drivers, :setting_type, :text
  end
end
