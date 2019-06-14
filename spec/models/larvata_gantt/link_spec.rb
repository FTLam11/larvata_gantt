require 'rails_helper'

module LarvataGantt
  RSpec.describe(Link, type: :model) do
    it 'has source and target tasks' do
      project = create(:project)
      child_task = create(:task, parent: project)

      link = build(:link, source: project, target: child_task)

      expect(link.source).to(eq(project))
      expect(link.target).to(eq(child_task))
    end

    it 'may have lag time' do
      project = create(:project)
      child_task = create(:task, parent: project)

      link = build(:link, source: project, target: child_task, lag: 2)

      expect(link.lag).to(eq(2))
    end

    it 'has a valid lag time' do
      project = create(:project)
      child_task = create(:task, parent: project)

      link = build(:link, source: project, target: child_task, lag: -1)

      expect(link).to(be_invalid)
    end

    it 'can not have identical source and target tasks' do
      project = create(:project)

      link = build(:link, source: project, target: project)

      expect(link).to(be_invalid)
    end

    describe '#as_json' do
      it 'has the required keys' do
        required_keys = %w(id lag source target type)
        project = create(:project)
        child_task = create(:task, parent: project)

        link = build(:link, source: project, target: child_task)
        result = JSON.parse(link.to_json).keys

        expect(result).to include(*required_keys)
      end
    end
  end
end
