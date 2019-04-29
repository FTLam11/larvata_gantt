FactoryBot.define do
  factory :larvata_gantt_portfolio, class: 'LarvataGantt::Portfolio', aliases: [:portfolio] do
    entity
    name { 'New Gantt Engine' }

    factory :larvata_gantt_portfolio_with_tasks, class: 'LarvataGantt::Portfolio' do
      transient do
        tasks_count { 3 }
      end

      after(:create) do |portfolio, evaluator|
        create_list(:larvata_gantt_task, evaluator.tasks_count, portfolio: portfolio)
      end
    end
  end
end
