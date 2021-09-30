class AddConstraintTasks < ActiveRecord::Migration[6.0]
  def change
    change_column :tasks, :name, :string, null: false
    change_column :tasks, :details, :text, null: false
  end
end
