class AddEntityIdToTasks < ActiveRecord::Migration[5.1]
  def change
    add_reference :larvata_gantt_tasks, LarvataGantt.entity_class.table_name.singularize.to_sym, foreign_key: true, first: true
  end
end
