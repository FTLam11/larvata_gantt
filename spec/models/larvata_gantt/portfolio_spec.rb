require 'rails_helper'

module LarvataGantt
  RSpec.describe Portfolio, type: :model do
    it 'has a valid name' do
      portfolio = create(:larvata_gantt_portfolio, name: 'Diversify yo bonds')
      INVALID_LENGTH_MIN = 256

      expect(portfolio.name).to eq('Diversify yo bonds')
      expect { create(:larvata_gantt_portfolio, name: '') }.to raise_error(ActiveRecord::RecordInvalid)
      expect { create(:larvata_gantt_portfolio, name: 'F' * INVALID_LENGTH_MIN) }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'has many tasks' do
      portfolio = create(:larvata_gantt_portfolio_with_tasks, tasks_count: 5)

      expect(portfolio.tasks.count).to eq(5)
    end
  end
end
