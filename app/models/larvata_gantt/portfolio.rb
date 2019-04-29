module LarvataGantt
  class Portfolio < ApplicationRecord
    belongs_to :entity, class_name: LarvataGantt.entity_class.to_s
    has_many :tasks, -> { order(:sort_order) }, class_name: 'LarvataGantt::Task',
      foreign_key: 'larvata_gantt_portfolio_id', dependent: :delete_all

    validates_presence_of :name
    validates :name, length: { maximum: 255 }

    scope :fully_scoped, -> { includes(:entity, tasks: [:sources, :targets]) }

    def start_date
      tasks.pluck(:start_date).compact.min&.strftime('%F') || 'N/A'
    end
  end
end
