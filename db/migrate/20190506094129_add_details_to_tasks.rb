class AddDetailsToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :larvata_gantt_tasks, :details, :text
  end
end
