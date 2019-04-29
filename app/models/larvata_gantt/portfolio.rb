module LarvataGantt
  class Portfolio < ApplicationRecord
    belongs_to :entity, class_name: LarvataGantt.entity_class.to_s
    has_many :tasks, -> { order(:sort_order) }, class_name: 'LarvataGantt::Task',
      foreign_key: 'larvata_gantt_portfolio_id', dependent: :delete_all

  end
end
