require 'rails_helper'

module LarvataGantt
  RSpec.describe(Meeting, type: :model) do
    it 'has a start date' do
      start_date = Time.zone.now.to_s
      meeting = build(:meeting, start_date: start_date)

      expect(meeting.start_date).to(eq(start_date))
      expect { create(:meeting, start_date: nil) }.to(raise_error(ActiveRecord::RecordInvalid))
    end

    it 'has a valid end date' do
      start_date = Time.zone.now
      end_date = 1.days.ago

      expect do
        create(:meeting, start_date: start_date, end_date: end_date)
      end.to(raise_error(ActiveRecord::RecordInvalid))
    end

    it 'has details' do
      meeting = build(:meeting, details: 'Irrelevant')

      expect(meeting.details).to(eq('Irrelevant'))
    end
  end
end
