module LarvataGantt
  class Project < BasicTask
    validates_presence_of :priority, :progress
    validates :progress, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1 }

    def post_initialize(*)
      nil
    end
  end
end
