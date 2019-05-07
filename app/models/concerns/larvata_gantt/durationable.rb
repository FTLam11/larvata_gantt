module LarvataGantt
  module Durationable
    extend ActiveSupport::Concern
    include ActiveModel::Validations

    included do
      validates_presence_of :start_date, :end_date
      validate :end_date_is_later_than_start_date

      private

      def end_date_is_later_than_start_date
        if end_date && start_date && end_date < start_date
          errors.add("End date", "can't be later than start date")
        end
      end
    end

    class_methods do
    end
  end
end
