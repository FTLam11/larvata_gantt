class AddDetailsToLarvataGanttTasks < ActiveRecord::Migration[5.1]
  def change
    add_column :larvata_gantt_tasks, :details, :text
  end
end
