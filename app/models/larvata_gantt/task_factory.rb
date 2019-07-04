module LarvataGantt
  class TaskFactory
    BASE = %W(text #{LarvataGantt.entity_fk} typing parent).freeze
    SPEC = {
      "project"   => %w(priority progress),
      "task"      => %w(priority progress start_date end_date),
      "milestone" => %w(start_date end_date),
      "meeting"   => %w(start_date end_date details),
    }.map { |type, attrs| [type, attrs.concat(BASE)] }.to_h.freeze

    ADD_TYPING_ERROR = lambda do |task, attr|
      task.valid?
      task.errors.add(:typing, "#{attr} is not a valid typing")
    end

    private_constant :ADD_TYPING_ERROR

    class << self
      def build(attrs, model_field = :type)
        build_attrs = build_attrs_for(attrs, model_field)

        if BasicTask.typings.keys.include?(attrs[model_field])
          LarvataGantt.const_get(attrs[model_field].classify).new(build_attrs)
        else
          Task.new(build_attrs).tap { |t| ADD_TYPING_ERROR.call(t, attrs[model_field]) }
        end
      end

      def update(attrs, model_field = :type)
        build_attrs = build_attrs_for(attrs, model_field)

        if BasicTask.typings.keys.include?(attrs[model_field])
          LarvataGantt.const_get(attrs[model_field].classify).update_attrs(attrs[:id], build_attrs)
        else
          Task.new(build_attrs).tap { |t| ADD_TYPING_ERROR.call(t, attrs[model_field]) }
        end
      end

      private

      def build_attrs_for(attrs, model_field = :type)
        attrs.to_h.tap do |h|
          h[:typing] = h[:type]
          h[:priority] = h[:priority]&.downcase if h[:priority].present?
        end.select { |k, _| SPEC[attrs[model_field]]&.include?(k) }
      end
    end
  end
end
