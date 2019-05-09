FactoryBot.define do
  factory :entity do
    name { 'New Gantt Engine' }

    factory :entity_with_tasks do
      transient do
        tasks_count { 3 }
      end

      after(:create) do |entity, evaluator|
        create_list(:task, evaluator.tasks_count, entity: entity)
      end
    end

    factory :entity_with_nil_start_date_tasks do
      transient do
        tasks_count { 3 }
      end

      after(:create) do |entity, evaluator|
        create_list(:project, evaluator.tasks_count, entity: entity, start_date: nil)
      end
    end
  end
end
