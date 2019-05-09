require 'rails_helper'

module LarvataGantt
  RSpec.describe(EntitiesController, type: :request) do
    let(:headers) { { 'ACCEPT': 'application/json' } }

    describe 'GET entities#index' do
      context 'when requesting html' do
        it 'renders the entity index' do
          create(:entity_with_tasks)

          get '/larvata_gantt/entities'

          expect(response).to(render_template(:index))
          expect(response.status).to(eq(200))
          expect(response.content_type).to(eq('text/html'))
        end
      end

      context 'when requesting json' do
        it 'responds with entity data' do
          create(:entity_with_tasks)
          response_keys = %w(id name)

          get '/larvata_gantt/entities', headers: headers
          body_content_keys = JSON.parse(response.body)["entities"].first.keys

          expect(response.status).to(eq(200))
          expect(response.content_type).to(eq('application/json'))
          expect(body_content_keys).to(include(*response_keys))
        end
      end
    end

    describe 'GET #show' do
      context 'when requesting html' do
        it 'renders the entity index' do
          create(:entity_with_tasks)

          get '/larvata_gantt/entities'

          expect(response).to(render_template(:index))
          expect(response.status).to(eq(200))
          expect(response.content_type).to(eq('text/html'))
        end
      end

      context 'when requesting json' do
        it 'renders data for a single entity' do
          entity = create(:entity_with_tasks)
          response_keys = %w(id name data links)

          get "/larvata_gantt/entities/#{entity.id}", headers: headers
          body_content_keys = JSON.parse(response.body).keys

          expect(response.status).to(eq(200))
          expect(response.content_type).to(eq('application/json'))
          expect(body_content_keys).to(include(*response_keys))
        end
      end
    end
  end
end
