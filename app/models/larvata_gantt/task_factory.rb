module LarvataGantt
  class TaskFactory
    SPEC = {
      "project" => %w(text typing priority progress portfolio_id ancestry),
      "task" => %w(text typing priority progress portfolio_id start_date end_date ancestry),
      "milestone" => %w(text typing portfolio_id start_date end_date),
      "meeting" => %w(text typing portfolio_id start_date end_date details),
    }.freeze

    class << self
      def build(attrs, model_field = :type)
        build_attrs = build_attrs_for(attrs, model_field)

        case attrs[model_field]
        when "project"
          Project.new(build_attrs)
        when "task"
          Task.new(build_attrs)
        when "milestone"
          Milestone.new(build_attrs)
        when "meeting"
          Meeting.new(build_attrs)
        else
          Task.new(build_attrs).tap do |t|
            t.valid?
            t.errors.add(:typing, "#{attrs[model_field]} is not a valid typing")
          end
        end
      end

      def build_attrs_for(attrs, model_field = "type")
        attrs.to_h.tap do |h|
          h["typing"] = h["type"]
          h["priority"] = h["priority"]&.downcase
        end.select { |k, _| SPEC[attrs[model_field]]&.include?(k) }
      end

    end
  end
end
