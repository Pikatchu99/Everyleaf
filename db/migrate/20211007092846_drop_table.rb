class DropTable < ActiveRecord::Migration[6.0]
  def change
    drop_table :labels
    drop_table :table_name
  end
end
