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

    def self.update_attrs(id, build_attrs)
      find(id).tap { |obj| obj.assign_attributes(build_attrs) }
    end

    def self.reorder(task, target)
      return false if target.nil?

      if target.is_a?(String) # target is integer or "next:23"/"next:null"
        return false if target.end_with?("null")

        target_id = target[5..-1]
        task.update(sort_order: find(target_id).sort_order + 1)
      else
        task.update(sort_order: find(target).sort_order)
      end

      remaining = where.not(id: task.id).where('sort_order >= ?', task.sort_order).map do |t|
        t.sort_order += 1
        t
      end

      import(remaining, on_duplicate_key_update: [:sort_order])
    end

    def links
      Link.where("source_id = ? OR target_id = ?", id, id)
    end


    def post_initialize(*)
      nil
    end
  end
end
