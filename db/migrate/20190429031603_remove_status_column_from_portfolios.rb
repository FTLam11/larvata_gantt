class RemoveStatusColumnFromPortfolios < ActiveRecord::Migration[5.1]
  def change
    remove_column :larvata_gantt_portfolios, :status
  end
end
