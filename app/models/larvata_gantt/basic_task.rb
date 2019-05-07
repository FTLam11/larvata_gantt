module LarvataGantt
  class BasicTask < ApplicationRecord
    self.table_name = 'larvata_gantt_tasks'

    belongs_to :portfolio, foreign_key: 'larvata_gantt_portfolio_id'
    belongs_to :owner, class_name: LarvataGantt.owner_class.to_s, foreign_key: 'user_id', optional: true
    has_many :source_links, class_name: 'Link', foreign_key: :source_id, dependent: :delete_all
    has_many :sources, through: :source_links
    has_many :target_links, class_name: 'Link', foreign_key: :target_id, dependent: :delete_all
    has_many :targets, through: :target_links

    validates_presence_of :sort_order, :text, :larvata_gantt_portfolio_id
    validates :text, length: { maximum: 255 }
    validates :sort_order, numericality: { greater_than_or_equal_to: 0 }

    TYPINGS = %i(task project milestone meeting).freeze
    PRIORITIES = %i(low normal high).freeze
    enum typing: TYPINGS
    enum priority: PRIORITIES

    def initialize(attrs = {})
      super(attrs)
      self.sort_order = (self.class.where(portfolio: portfolio).maximum(:sort_order) || 0) + 1
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

    def as_json(*)
      super(only: [:id, :text, :details, :parent]).tap do |hash|
        hash[:progress] = progress.to_f
        hash[:start_date] = start_date&.to_s(:f)
        hash[:end_date] = end_date&.to_s(:f)
        hash[:type] = typing
        hash[:owner_id] = 1
        hash[:owner_name_en] = 'Ruby'
        hash[:priority] = priority.capitalize
      end
    end

    def post_initialize(*)
      nil
    end
  end
end
