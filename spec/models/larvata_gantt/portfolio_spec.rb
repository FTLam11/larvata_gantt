require 'rails_helper'

module LarvataGantt
  RSpec.describe(Portfolio, type: :model) do
    it 'has a valid name' do
      portfolio = create(:larvata_gantt_portfolio, name: 'Diversify yo bonds')
      INVALID_LENGTH_MIN = 256

      expect(portfolio.name).to(eq('Diversify yo bonds'))
      expect { create(:larvata_gantt_portfolio, name: '') }.to(raise_error(ActiveRecord::RecordInvalid))
      expect { create(:larvata_gantt_portfolio, name: 'F' * INVALID_LENGTH_MIN) }.to(raise_error(ActiveRecord::RecordInvalid))
    end

    it 'has many tasks' do
      portfolio = create(:larvata_gantt_portfolio_with_tasks, tasks_count: 5)

      expect(portfolio.tasks.count).to(eq(5))
    end

    describe '#start_date' do
      context 'with no tasks' do
        it 'returns N/A' do
          portfolio = create(:larvata_gantt_portfolio)

          expect(portfolio.start_date).to(eq('N/A'))
        end
      end

      context 'with tasks that have no start_date' do
        it 'returns N/A' do
          portfolio = create(:larvata_gantt_portfolio_with_nil_start_date_tasks)

          expect(portfolio.start_date).to(eq('N/A'))
        end
      end

      context 'with tasks that all have start_dates' do
        it 'returns the earliest start_date' do
          portfolio = create(:larvata_gantt_portfolio_with_tasks)
          result = portfolio.tasks.order(:start_date).first.start_date.strftime('%F')

          expect(portfolio.start_date).to(eq(result))
        end
      end

      context 'with tasks that all have valid and nil start_dates' do
        it 'returns the earliest start_date' do
          portfolio = create(:larvata_gantt_portfolio) do |p|
            p.tasks.create(attributes_for(:larvata_gantt_project))
            p.tasks.create(attributes_for(:larvata_gantt_task))
          end

          result = portfolio.tasks.where.not(start_date: nil)
            .order(:start_date).first.start_date.strftime('%F')

          expect(portfolio.start_date).to(eq(result))
        end
      end
    end
  end
end
