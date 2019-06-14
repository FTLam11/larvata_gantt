require 'rails_helper'

module LarvataGantt
  RSpec.describe(Meeting, type: :model) do
    it 'has a start date' do
      start_date = Time.zone.now.to_s
      meeting = build(:meeting, start_date: start_date)

      expect(meeting.start_date).to(eq(start_date))
    end

    it 'has a valid start date' do
      meeting = build(:meeting, start_date: nil)

      expect(meeting).to(be_invalid)
    end

    it 'has a valid end date' do
      meeting = build(:meeting, start_date: Time.zone.now, end_date: 1.days.ago)

      expect(meeting).to(be_invalid)
    end

    it 'has details' do
      meeting = build(:meeting, details: 'Irrelevant')

      expect(meeting.details).to(eq('Irrelevant'))
    end
  end
end
