module LarvataGantt
  class Link < ApplicationRecord
    belongs_to :source, class_name: "LarvataGantt::BasicTask"
    belongs_to :target, class_name: "LarvataGantt::BasicTask"

    validates_presence_of :source_id, :target_id
    validates :lag, numericality: { greater_than_or_equal_to: 0 }
    validate :target_is_not_source

    CONSTRAINTS = %i(asap alap snet snlt fnet fnlt mso mfo).freeze
    TYPINGS = %i(finish_to_start start_to_start finish_to_finish start_to_finish).freeze
    enum typing: TYPINGS


    def as_json(*)
      super(only: [:id, :lag]).tap do |hash|
        hash[:source] = source_id
        hash[:target] = target_id
        hash[:type] = typing_before_type_cast.to_s
      end
    end

    private

    def target_is_not_source
      if target_id == source_id
        errors.add("Target", "can't be same as source")
      end
    end
  end
end
