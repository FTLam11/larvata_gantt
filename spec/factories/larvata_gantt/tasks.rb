FactoryBot.define do
  sequence(:started_at) { |n| n.days.ago }

  factory :larvata_gantt_basic_task, class: LarvataGantt::BasicTask, aliases: [:basic_task] do
    portfolio
    owner { nil }
    sort_order { 1 }
    parent { nil }
    typing { 0 }
    priority { 'normal' }
    progress { 0 }
    end_date { nil }
    start_date { nil }
    text { 'Basic Task' }
  end

  factory :larvata_gantt_task, class: LarvataGantt::Task,
    parent: :basic_task, aliases: [:task] do
    end_date { 1.week.from_now }
    start_date { generate(:started_at) }
    text { 'A task' }
  end

  factory :larvata_gantt_project, class: LarvataGantt::Project,
    parent: :basic_task, aliases: [:project] do
    typing { 1 }
    text { 'Project Operation Diam La' }
  end

  factory :larvata_gantt_milestone, class: LarvataGantt::Milestone,
    parent: :basic_task, aliases: [:milestone] do
    typing { 2 }
    text { '50 percent check in' }
    end_date { 1.week.from_now }
    start_date { generate(:started_at) }
  end

  factory :larvata_gantt_meeting, class: LarvataGantt::Meeting,
    parent: :basic_task, aliases: [:meeting] do
    typing { 3 }
    text { 'Pointless meeting' }
    details { 'Blah blah blah' }
    end_date { 1.week.from_now }
    start_date { generate(:started_at) }
  end
end
