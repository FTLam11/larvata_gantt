module LarvataGantt
  module EntityDecorator
    extend ActiveSupport::Concern

    included do
      has_many :tasks, -> { order(:sort_order) }, class_name: 'LarvataGantt::Task',
        foreign_key: 'entity_id', dependent: :delete_all

      def as_json(*)
        super(except: [:created_at, :updated_at]).tap do |hash|
          hash[:data] = tasks
          hash[:links] = LarvataGantt::Link.for_tasks(task_ids)
        end
      end
    end

    class_methods do
    end
  end
end
