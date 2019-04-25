FactoryBot.define do
  factory :larvata_gantt_portfolio, class: 'LarvataGantt::Portfolio' do
    entity
    status { 0 }
    name { 'New Gantt Engine' }
  end
end
