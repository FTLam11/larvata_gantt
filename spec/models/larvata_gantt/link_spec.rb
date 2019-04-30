require 'rails_helper'

module LarvataGantt
  RSpec.describe Link, type: :model do
    it 'has source and target tasks' do
      project = create(:project)
      child_task = create(:task, parent: project)

      link = create(:link, source: project, target: child_task)

      expect(link.source).to eq(project)
      expect(link.target).to eq(child_task)
    end
  end
end
