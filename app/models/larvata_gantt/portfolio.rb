module LarvataGantt
  class Portfolio < ApplicationRecord
    belongs_to :entity, class_name: LarvataGantt.entity_class.to_s, foreign_key: 'larvata_gantt_entity_id'
  end
end
