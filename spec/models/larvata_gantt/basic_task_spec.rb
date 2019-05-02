require 'rails_helper'

module LarvataGantt
  RSpec.describe(BasicTask, type: :model) do
    it 'belongs to a portfolio' do
      task = build(:larvata_gantt_task)

      expect(task.portfolio).to_not(be(nil))
    end

    it 'may be owner-less' do
      task = build(:larvata_gantt_task)

      expect(task.owner).to(be(nil))
    end

    it 'may be belong to an owner' do
      owner = build(:owner)

      task = build(:larvata_gantt_task, owner: owner)

      expect(task.owner).to(be(owner))
    end

    it 'has a text description' do
      task = create(:task, text: 'Take out the trash')
      INVALID_LENGTH_MIN = 256

      expect(task.text).to(eq('Take out the trash'))
      expect { create(:task, text: '') }.to(raise_error(ActiveRecord::RecordInvalid))
      expect { create(:task, text: 'F' * INVALID_LENGTH_MIN) }.to(raise_error(ActiveRecord::RecordInvalid))
    end

    it 'has a sort order' do
      task = create(:task, sort_order: 2)

      expect(task.sort_order).to(eq(2))
      expect { create(:task, sort_order: nil) }.to(raise_error(ActiveRecord::RecordInvalid))
      expect { create(:task, sort_order: -1) }.to(raise_error(ActiveRecord::RecordInvalid))
    end
  end
end
