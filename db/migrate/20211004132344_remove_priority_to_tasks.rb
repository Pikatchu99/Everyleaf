class RemovePriorityToTasks < ActiveRecord::Migration[6.0]
  def change
    remove_column :tasks, :priority
  end
end
