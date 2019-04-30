module LarvataGantt
  class BasicTask < ApplicationRecord
    self.table_name = 'larvata_gantt_tasks'

    belongs_to :portfolio, foreign_key: 'larvata_gantt_portfolio_id'
    belongs_to :owner, class_name: LarvataGantt.owner_class.to_s, foreign_key: 'user_id', optional: true

    validates_presence_of :sort_order, :text, :larvata_gantt_portfolio_id
    validates :text, length: { maximum: 255 }
    validates :sort_order, numericality: { greater_than_or_equal_to: 0 }

    TYPINGS = %i(task project milestone meeting).freeze
    PRIORITIES = %i(low normal high).freeze
    enum typing: TYPINGS
    enum priority: PRIORITIES

    def initialize(attrs = {})
      super(attrs)
      post_initialize(attrs)
    end


    def post_initialize(*)
      nil
    end
  end
end
