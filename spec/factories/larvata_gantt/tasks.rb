FactoryBot.define do
  factory :larvata_gantt_task, class: 'Task' do
    portfolio { nil }
    owner { nil }
    sort_order { 1 }
    parent { "MyString" }
    typing { 1 }
    priority { 1 }
    progress { "9.99" }
    end_date { "2019-04-25 17:27:33" }
    start_date { "2019-04-25 17:27:33" }
    text { "MyString" }
  end
end
