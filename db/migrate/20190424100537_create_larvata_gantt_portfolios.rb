class CreateLarvataGanttPortfolios < ActiveRecord::Migration[5.2]
  def change
    create_table :larvata_gantt_portfolios do |t|
      t.references LarvataGantt.entity_class.table_name.singularize.to_sym, foreign_key: true
      t.integer :status, default: 0, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
