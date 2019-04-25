module LarvataGantt
  class Task < ApplicationRecord
    belongs_to :portfolio
    belongs_to :owner, class_name: LarvataGantt.owner_class.to_s
  end
end
