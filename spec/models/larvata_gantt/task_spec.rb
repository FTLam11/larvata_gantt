require 'rails_helper'

module LarvataGantt
  RSpec.describe(Task, type: :model) do
    it 'has a priority' do
      task = build(:task, priority: 'low')

      expect(task.priority).to(eq('low'))
    end

    it 'has progress' do
      task = build(:task, progress: 77)

      expect(task.progress).to(eq(77))
    end

    it 'has a valid progress' do
      invalid_tasks = [build(:task, progress: -2), build(:task, progress: 101)]

      expect(invalid_tasks).to(all(be_invalid))
    end

    it 'has a start date' do
      start_date = Time.zone.now.to_s
      task = build(:task, start_date: start_date)

      expect(task.start_date).to(eq(start_date))
    end

    it 'has a valid start date' do
      task = build(:task, start_date: nil)

      expect(task).to(be_invalid)
    end

    it 'has a valid end date' do
      task = build(:task, start_date: Time.zone.now, end_date: 1.days.ago)

      expect(task).to(be_invalid)
    end
  end
end
