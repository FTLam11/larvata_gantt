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

    def as_json(*)
      super(except: [:created_at, :updated_at]).tap do |hash|
        aggregate = tasks.pluck(Arel.sql('avg(progress)'), Arel.sql('min(start_date)')).flatten
        hash[:task_count] = tasks.size
        hash[:completion_rate] = aggregate[0] || 0
        hash[:start_date] = aggregate[1]&.strftime('%F') || 'N/A'
        hash[:data] = tasks
        hash[:links] = Link.for_tasks(task_ids)
      end
    end
  end
end
