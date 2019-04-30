require 'rails_helper'

module LarvataGantt
  RSpec.describe(Project, type: :model) do
    it 'has no start or end dates' do
      expect { create(:project, start_date: nil, end_date: nil) }.to_not(raise_error)
    end

    it 'has progress' do
      project = create(:project, progress: 0.5)

      expect(project.progress).to(eq(0.5))
      expect { create(:project, progress: 72) }.to(raise_error(ActiveRecord::RecordInvalid))
    end
  end
end
