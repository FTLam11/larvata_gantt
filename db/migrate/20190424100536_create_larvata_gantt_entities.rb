class CreateLarvataGanttEntities < ActiveRecord::Migration[5.2]
  def change
    create_table :larvata_gantt_entities do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
