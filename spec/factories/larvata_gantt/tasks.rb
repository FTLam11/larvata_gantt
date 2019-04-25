FactoryBot.define do
  factory :larvata_gantt_task, class: 'LarvataGantt::Task' do
    portfolio
    owner { nil }
    sort_order { 1 }
    parent { nil }
    typing { 1 }
    priority { 1 }
    progress { 0 }
    end_date { "2019-04-25 17:27:33" }
    start_date { "2019-04-25 17:27:33" }
    text { "First task" }
  end
end
