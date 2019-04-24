module LarvataGantt
  class Entity < ApplicationRecord
    validates_presence_of :name
  end
end
