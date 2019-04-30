FactoryBot.define do
  factory :larvata_gantt_link, class: LarvataGantt::Link, aliases: [:link] do
    source { nil }
    target { nil }
    typing { 1 }
    lag { 0 }
  end
end
