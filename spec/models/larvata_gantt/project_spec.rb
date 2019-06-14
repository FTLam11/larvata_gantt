require 'rails_helper'

module LarvataGantt
  RSpec.describe(Project, type: :model) do
    it 'has no start or end dates' do
      expect { create(:project, start_date: nil, end_date: nil) }.to_not(raise_error)
    end

    it 'has a priority' do
      project = build(:project, priority: 'low')

      expect(project.priority).to(eq('low'))
    end

    it 'has a valid progress' do
      project = build(:project, progress: 77)

      expect(project.progress).to(eq(77))
      expect { create(:project, progress: -2) }.to(raise_error(ActiveRecord::RecordInvalid))
      expect { create(:project, progress: 101) }.to(raise_error(ActiveRecord::RecordInvalid))
    end
  end
end
