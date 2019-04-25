require "larvata_gantt/engine"

module LarvataGantt
  mattr_accessor :entity_class, :owner_class

  def self.entity_class
    @@entity_class.constantize
  end

  def self.owner_class
    @@owner_class.constantize
  end
end
