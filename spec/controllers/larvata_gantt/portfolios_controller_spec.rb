require 'rails_helper'

module LarvataGantt
  RSpec.describe(PortfoliosController, type: :request) do
    describe 'GET portfolios#index' do
      context 'when requesting html' do
        it 'renders the portfolio index' do
          create(:larvata_gantt_portfolio_with_tasks)

          get '/larvata_gantt/portfolios'

          expect(response).to(render_template(:index))
          expect(response.status).to(eq(200))
          expect(response.content_type).to(eq('text/html'))
        end
      end

      context 'when requesting json' do
        it 'responds with portfolio data' do
          create(:larvata_gantt_portfolio_with_tasks)
          headers = { 'ACCEPT': 'application/json' }
          response_keys = %w(id name entity entity_id task_count start_date)

          get '/larvata_gantt/portfolios', headers: headers
          body_content_keys = JSON.parse(response.body)["portfolios"].first.keys

          expect(response.status).to(eq(200))
          expect(response.content_type).to(eq('application/json'))
          expect(body_content_keys).to(include(*response_keys))
        end
      end
    end
  end
end
