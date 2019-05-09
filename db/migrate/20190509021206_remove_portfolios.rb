class RemovePortfolios < ActiveRecord::Migration[5.1]
  def up
    remove_foreign_key :larvata_gantt_portfolios, :entities
    remove_foreign_key :larvata_gantt_tasks, :larvata_gantt_portfolios
    remove_index :larvata_gantt_tasks, :larvata_gantt_portfolio_id
    remove_column :larvata_gantt_tasks, :larvata_gantt_portfolio_id
    drop_table :larvata_gantt_portfolios
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
