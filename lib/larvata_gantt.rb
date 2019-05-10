require "larvata_gantt/engine"

module LarvataGantt
  mattr_accessor :entity_class, :owner_class
  mattr_reader :entity_fk, :owner_fk

  def self.entity_class
    @@entity_class.constantize
  end

  def self.entity_fk
    "#{@@entity_class.downcase}_id"
  end

  def self.owner_class
    @@owner_class.constantize
  end

  def self.owner_fk
    "#{@@owner_class.downcase}_id"
  end
end
