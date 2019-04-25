module LarvataGantt
  class Portfolio < ApplicationRecord
    belongs_to :entity, class_name: LarvataGantt.entity_class.to_s
  end
end
