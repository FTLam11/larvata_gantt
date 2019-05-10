class CreateLarvataGanttTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :larvata_gantt_tasks do |t|
      t.references LarvataGantt.entity_class.table_name.singularize.to_sym, foreign_key: true
      t.references LarvataGantt.owner_class.table_name.singularize.to_sym, foreign_key: true
      t.integer :sort_order, default: 0, null: false
      t.string :parent
      t.integer :typing, default: 0, null: false
      t.integer :priority, default: 1, null: false
      t.decimal :progress, precision: 3, scale: 2, default: 0, null: false
      t.datetime :end_date
      t.datetime :start_date
      t.string :text, null: false
      t.text :details, :text

      t.timestamps
    end
  end
end
