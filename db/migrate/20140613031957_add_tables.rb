class AddTables < ActiveRecord::Migration
  def up
    create_table :workflows do |t|
      t.timestamps
      t.text :code
      t.text :description
    end

    create_table :questions do |t|
      t.timestamps
      t.text :title
      t.text :code
    end

    create_table :workflow_drivers do |t|
      t.timestamps
      t.integer :question_id
      t.text :answer
      t.integer :workflow_id
    end

    create_table :setting_drivers do |t|
      t.timestamps
      t.integer :question_id
      t.text :answer
      t.text :setting
      t.text :setting_value
    end
  end

  def down
    drop_table :setting_drivers
    drop_table :workflow_drivers
    drop_table :questions
    drop_table :workflows
  end
end
