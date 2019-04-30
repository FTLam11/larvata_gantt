class CreateLarvataGanttLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :larvata_gantt_links do |t|
      t.bigint :source_id, foreign_key: true, null: false
      t.bigint :target_id, foreign_key: true, null: false
      t.integer :typing, null: false, default: 0
      t.integer :lag, null: false, default: 0
    end

    add_index :larvata_gantt_links, :typing
    add_index :larvata_gantt_links, :source_id
    add_index :larvata_gantt_links, :target_id

    add_foreign_key :larvata_gantt_links, :larvata_gantt_tasks, column: :source_id
    add_foreign_key :larvata_gantt_links, :larvata_gantt_tasks, column: :target_id
  end
end
