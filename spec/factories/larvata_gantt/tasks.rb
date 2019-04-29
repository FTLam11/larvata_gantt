FactoryBot.define do
  sequence :started_at do |n|
    n.days.ago
  end

  factory :larvata_gantt_task, class: 'LarvataGantt::Task' do
    portfolio
    owner { nil }
    sort_order { 1 }
    parent { nil }
    typing { 1 }
    priority { 1 }
    progress { 0 }
    end_date { 1.week.from_now }
    start_date { generate(:started_at) }
    text { 'First task' }
  end

  factory :larvata_gantt_project, class: 'LarvataGantt::Project' do
    portfolio
    owner { nil }
    sort_order { 1 }
    parent { nil }
    typing { 0 }
    priority { 1 }
    progress { 0 }
    end_date { nil }
    start_date { nil }
    text { 'Project Operation Diam La' }
  end
end
