require 'rails_helper'

module LarvataGantt
  RSpec.describe(BasicTask, type: :model) do
    let(:invalid_length_min) { 256 }

    it 'belongs to a portfolio' do
      task = build(:task)

      expect(task.portfolio).to_not(be(nil))
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
      task = create(:task, text: 'Take out the trash')

      expect(task.text).to(eq('Take out the trash'))
    end

    it 'does not have a blank text description' do
      expect { create(:task, text: '') }.to(raise_error(ActiveRecord::RecordInvalid))
    end

    it 'has a valid text length' do
      expect { create(:task, text: 'F' * invalid_length_min) }.to(raise_error(ActiveRecord::RecordInvalid))
    end

    it 'has a sort order' do
      task = create(:task, sort_order: 2)

      expect(task.sort_order).to(eq(2))
    end

    it 'does not have a blank sort order' do
      expect { create(:task, sort_order: nil) }.to(raise_error(ActiveRecord::RecordInvalid))
    end

    it 'has a valid sort order' do
      expect { create(:task, sort_order: -1) }.to(raise_error(ActiveRecord::RecordInvalid))
    end
  end
end
