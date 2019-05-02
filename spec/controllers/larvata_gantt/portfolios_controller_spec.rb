require 'rails_helper'

module LarvataGantt
  RSpec.describe(PortfoliosController, type: :request) do
    let(:response_keys) { %w(id name entity_name entity_id task_count start_date) }
    let(:headers) { { 'ACCEPT': 'application/json' } }

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

          get '/larvata_gantt/portfolios', headers: headers
          body_content_keys = JSON.parse(response.body)["portfolios"].first.keys

          expect(response.status).to(eq(200))
          expect(response.content_type).to(eq('application/json'))
          expect(body_content_keys).to(include(*response_keys))
        end
      end
    end

    describe 'POST #create' do
      it 'creates a portfolio' do
        entity = create(:entity)
        params = { portfolio: { entity_id: entity.id, name: entity.name } }

        post '/larvata_gantt/portfolios', params: params, headers: headers
        body_content_keys = JSON.parse(response.body)["portfolio"].keys

        expect(response.status).to(eq(201))
        expect(body_content_keys).to(include(*response_keys))
      end
    end

    describe 'GET #show' do
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
        it 'renders data for a single portfolio' do
          portfolio = create(:larvata_gantt_portfolio_with_tasks)
          response_keys = %w(id entity_id task_count completion_rate start_date data links)

          get "/larvata_gantt/portfolios/#{portfolio.id}", headers: headers
          body_content_keys = JSON.parse(response.body).keys

          expect(response.status).to(eq(200))
          expect(response.content_type).to(eq('application/json'))
          expect(body_content_keys).to(include(*response_keys))
        end
      end
    end

    describe 'PATCH #update' do
      it 'updates a portfolio' do
        portfolio = create(:larvata_gantt_portfolio_with_tasks)
        new_name = 'New portfolio name'
        params = { portfolio: { name: new_name } }

        patch "/larvata_gantt/portfolios/#{portfolio.id}", params: params, headers: headers
        body_content_keys = JSON.parse(response.body)["portfolio"].keys

        expect(portfolio.reload.name).to(eq(new_name))
        expect(response.status).to(eq(200))
        expect(response.content_type).to(eq('application/json'))
        expect(body_content_keys).to(include(*response_keys))
      end
    end

    describe 'DELETE #destroy' do
      it 'destroys a portfolio' do
        portfolio = create(:larvata_gantt_portfolio_with_tasks)

        delete "/larvata_gantt/portfolios/#{portfolio.id}", headers: headers

        expect { portfolio.reload }.to(raise_error(ActiveRecord::RecordNotFound))
        expect(response.status).to(eq(204))
      end
    end
  end
end
