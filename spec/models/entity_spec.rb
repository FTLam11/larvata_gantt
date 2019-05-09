require 'rails_helper'

RSpec.describe(Entity, type: :model) do
  it 'has many tasks' do
    entity = create(:entity_with_tasks, tasks_count: 5)

    expect(entity.tasks.count).to(eq(5))
  end

  describe '#as_json' do
    it 'has the required keys' do
      required_keys = %w(id name data links)
      entity = create(:entity) do |p|
        p.tasks.create(attributes_for(:project))
        p.tasks.create(attributes_for(:task))
      end

      result = JSON.parse(entity.to_json).keys

      expect(result).to(include(*required_keys))
    end
  end
end
