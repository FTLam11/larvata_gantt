require 'rails_helper'

module LarvataGantt
  RSpec.describe Portfolio, type: :model do
    it 'has a name' do
      portfolio = create(:larvata_gantt_portfolio, name: 'Diversify yo bonds')

      expect(portfolio.name).to eq('Diversify yo bonds')
    end
  end
end
