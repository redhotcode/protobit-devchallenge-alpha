class AddDefaultsToTasks < ActiveRecord::Migration
  def change
    change_column_default :tasks, :complete, false
    change_column_default :tasks, :archived, false
    change_column_null :tasks, :complete, false
    change_column_null :tasks, :archived, false
  end
end
