require 'rails_helper'

module LarvataGantt
  RSpec.describe(Project, type: :model) do
    it 'has no start or end dates' do
      project = build(:project, start_date: nil, end_date: nil)

      expect(project).to(be_valid)
    end

    it 'has a priority' do
      project = build(:project, priority: 'low')

      expect(project.priority).to(eq('low'))
    end

    it 'has progress' do
      project = build(:project, progress: 77)

      expect(project.progress).to(eq(77))
    end

    it 'has a valid progress' do
      invalid_projects = [build(:project, progress: -2), build(:project, progress: 101)]

      expect(invalid_projects).to(all(be_invalid))
    end
  end
end
