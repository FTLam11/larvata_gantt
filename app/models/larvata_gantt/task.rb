module LarvataGantt
  class Task < BasicTask
    validates_presence_of :progress, :start_date, :end_date
    validates :progress, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
    validate :end_date_is_later_than_start_date

    def post_initialize(*)
      nil
    end

    private

    def end_date_is_later_than_start_date
      if end_date && start_date && end_date < start_date
        errors.add("End date", "can't be later than start date")
      end
    end
  end
end
