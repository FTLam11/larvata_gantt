require 'rails_helper'

module LarvataGantt
  RSpec.describe(PortfoliosController, type: :request) do
    describe 'GET portfolios#index' do
      context 'when requesting html' do
        it 'renders the portfolio index' do
          create(:larvata_gantt_portfolio_with_tasks)

          get '/larvata_gantt/portfolios'

          expect(response).to render_template(:index)
          expect(response.status).to eq(200)
          expect(response.content_type).to eq('text/html')
        end
      end

    end
  end
end
