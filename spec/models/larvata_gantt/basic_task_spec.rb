require 'rails_helper'

module LarvataGantt
  RSpec.describe(BasicTask, type: :model) do
    let(:invalid_length_min) { 256 }

    it 'belongs to a entity' do
      task = build(:task)

      expect(task.entity).to_not(be(nil))
    end

    it 'may be owner-less' do
      task = build(:task)

      expect(task.owner).to(be(nil))
    end

    it 'may be belong to an owner' do
      owner = build(:owner)

      task = build(:task, owner: owner)

      expect(task.owner).to(be(owner))
    end

    it 'has a text description' do
      task = build(:task, text: 'Take out the trash')

      expect(task.text).to(eq('Take out the trash'))
    end

    it 'does not have a blank text description' do
      task = build(:task, text: '')

      expect(task).to(be_invalid)
    end

    it 'has a valid text length' do
      task = build(:task, text: 'F' * invalid_length_min)

      expect(task).to(be_invalid)
    end

    it 'has a sort order' do
      task = build(:task, sort_order: 2)

      expect(task.sort_order).to(eq(2))
    end

    it 'does not have a blank sort order' do
      task = build(:task, sort_order: nil)

      expect(task).to(be_invalid)
    end

    it 'has a valid sort order' do
      task = build(:task, sort_order: -1)

      expect(task).to(be_invalid)
    end

    it 'has many links' do
      first_task = create(:task)
      second_task = create(:task)
      link = create(:link, source: first_task, target: second_task)

      expect(first_task.links).to(include(link))
      expect(second_task.links).to(include(link))
    end

    describe '#as_json' do
      it 'has the required keys' do
        required_keys = %w(id text details parent progress start_date end_date type owner_id owner_name_en priority)
        task = build(:task)

        result = JSON.parse(task.to_json).keys

        expect(result).to(include(*required_keys))
      end
    end
  end
end
