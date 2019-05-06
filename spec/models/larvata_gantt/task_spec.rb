require 'rails_helper'

module LarvataGantt
  RSpec.describe(Task, type: :model) do
    it 'has a priority' do
      task = build(:task, priority: 'low')

      expect(task.priority).to(eq('low'))
    end

    it 'has a valid progress' do
      task = build(:task, progress: 77)

      expect(task.progress).to(eq(77))
      expect { create(:task, progress: -2) }.to(raise_error(ActiveRecord::RecordInvalid))
      expect { create(:task, progress: 101) }.to(raise_error(ActiveRecord::RecordInvalid))
    end

    it 'has a start date' do
      start_date = Time.zone.now.to_s
      task = build(:task, start_date: start_date)

      expect(task.start_date).to(eq(start_date))
      expect { create(:task, start_date: nil) }.to(raise_error(ActiveRecord::RecordInvalid))
    end

    it 'has a valid end date' do
      start_date = Time.zone.now
      end_date = 1.days.ago

      expect { create(:task, start_date: start_date, end_date: end_date) }.to(raise_error(ActiveRecord::RecordInvalid))
    end
  end
end
