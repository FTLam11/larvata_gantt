require 'rails_helper'

module LarvataGantt
  RSpec.describe(PortfoliosController, type: :request) do
    RESPONSE_KEYS = %w(id name entity entity_id task_count start_date)
    HEADERS = { 'ACCEPT': 'application/json' }

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

          get '/larvata_gantt/portfolios', headers: HEADERS
          body_content_keys = JSON.parse(response.body)["portfolios"].first.keys

          expect(response.status).to(eq(200))
          expect(response.content_type).to(eq('application/json'))
          expect(body_content_keys).to(include(*RESPONSE_KEYS))
        end
      end
    end

    describe 'POST #create' do
      it 'creates a portfolio' do
        entity = create(:entity)
        params = { portfolio: { entity_id: entity.id, name: entity.name } }

        post '/larvata_gantt/portfolios', params: params, headers: HEADERS
        body_content_keys = JSON.parse(response.body)["portfolio"].keys

        expect(response.status).to(eq(201))
        expect(body_content_keys).to(include(*RESPONSE_KEYS))
      end
    end
  end
end
