LarvataGantt.entity_class.class_eval do
  has_many :tasks, -> { order(:sort_order) }, class_name: 'LarvataGantt::Task',
    foreign_key: 'larvata_gantt_entity_id', dependent: :delete_all

  scope :fully_scoped, -> { includes(:entity, tasks: [:sources, :targets]).order('larvata_gantt_tasks.start_date') }

  def as_json(*)
    super(except: [:created_at, :updated_at]).tap do |hash|
      hash[:data] = tasks
      hash[:links] = Link.for_tasks(task_ids)
    end
  end
end
