require 'rails_helper'

module LarvataGantt
  RSpec.describe Task, type: :model do
    it 'belongs to a portfolio' do
      task = build(:larvata_gantt_task)

      expect(task.portfolio).to_not be nil
    end

    it 'may be owner-less' do
      task = build(:larvata_gantt_task)

      expect(task.owner).to be nil
    end

    it 'may be belong to an owner' do
      owner = build(:owner)

      task = build(:larvata_gantt_task, owner: owner)

      expect(task.owner).to be(owner)
    end
  end
end
