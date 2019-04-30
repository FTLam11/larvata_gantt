require 'rails_helper'

module LarvataGantt
  RSpec.describe(Link, type: :model) do
    it 'has source and target tasks' do
      project = create(:project)
      child_task = create(:task, parent: project)

      link = create(:link, source: project, target: child_task)

      expect(link.source).to(eq(project))
      expect(link.target).to(eq(child_task))
    end

    it 'may have lag time' do
      project = create(:project)
      child_task = create(:task, parent: project)

      link = create(:link, source: project, target: child_task, lag: 2)

      expect(link.lag).to(eq(2))
      expect { create(:link, source: project, target: child_task, lag: -1) }.to(raise_error(ActiveRecord::RecordInvalid))
    end

    it 'can not have identical source and target tasks' do
      project = create(:project)

      expect { create(:link, source: project, target: project) }.to(raise_error(ActiveRecord::RecordInvalid))
    end
  end
end
