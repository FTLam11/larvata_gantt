FactoryBot.define do
  factory :larvata_gantt_link, class: LarvataGantt::Link, aliases: [:link] do
    association :source, factory: :project
    association :target, factory: :task
    typing { 1 }
    lag { 0 }
  end
end
