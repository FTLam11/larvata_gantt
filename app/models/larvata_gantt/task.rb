module LarvataGantt
  class Task < ApplicationRecord
    belongs_to :portfolio, foreign_key: 'larvata_gantt_portfolio_id'
    belongs_to :owner, class_name: LarvataGantt.owner_class.to_s, foreign_key: 'user_id', optional: true
  end
end
