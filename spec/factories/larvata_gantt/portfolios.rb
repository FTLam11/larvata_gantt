FactoryBot.define do
  factory :larvata_gantt_portfolio, class: LarvataGantt::Portfolio, aliases: [:portfolio] do
    entity
    name { 'New Gantt Engine' }

    factory :larvata_gantt_portfolio_with_tasks, class: LarvataGantt::Portfolio do
      transient do
        tasks_count { 3 }
      end

      after(:create) do |portfolio, evaluator|
        create_list(:larvata_gantt_task, evaluator.tasks_count, portfolio: portfolio)
      end
    end

    factory :larvata_gantt_portfolio_with_nil_start_date_tasks, class: LarvataGantt::Portfolio do
      transient do
        tasks_count { 3 }
      end

      after(:create) do |portfolio, evaluator|
        create_list(:project, evaluator.tasks_count, portfolio: portfolio, start_date: nil)
      end
    end
  end
end
