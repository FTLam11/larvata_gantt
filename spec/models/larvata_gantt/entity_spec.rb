require 'rails_helper'

module LarvataGantt
  RSpec.describe Entity, type: :model do
    it 'has a name' do
      entity = build(:larvata_gantt_entity, name: 'LARVATA')

      expect(entity.name).to eq('LARVATA')
    end
  end
end
