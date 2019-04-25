FactoryBot.define do
  factory :larvata_gantt_portfolio, class: 'LarvataGantt::Portfolio' do
    association :entity, factory: :larvata_gantt_entity
    status { 0 }
    name { 'New Gantt Engine' }
  end
end
