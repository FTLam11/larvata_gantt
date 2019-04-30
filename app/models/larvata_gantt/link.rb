module LarvataGantt
  class Link < ApplicationRecord
    belongs_to :source, class_name: "LarvataGantt::BasicTask"
    belongs_to :target, class_name: "LarvataGantt::BasicTask"

    validates_presence_of :source_id, :target_id
    validates :lag, numericality: { greater_than_or_equal_to: 0 }
    CONSTRAINTS = %i(asap alap snet snlt fnet fnlt mso mfo).freeze
    TYPINGS = %i(finish_to_start start_to_start finish_to_finish start_to_finish).freeze
    enum typing: TYPINGS

  end
end
