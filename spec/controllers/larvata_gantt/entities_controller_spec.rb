require 'rails_helper'

module LarvataGantt
  RSpec.describe(EntitiesController, type: :request) do
    describe 'GET entities#index' do
      context 'when requesting html' do
        it 'renders the entity index' do
          create(:entity_with_tasks)

          get entities_path

          expect(response).to(render_template(:index))
          expect(response.status).to(eq(200))
          expect(response.content_type).to(eq('text/html'))
        end
      end

      context 'when requesting json' do
        it 'responds with entity data' do
          create(:entity_with_tasks)
          response_keys = %w(id name)

          get entities_path, as: :json
          body_content_keys = body_content["entities"].first.keys

          expect(response.status).to(eq(200))
          expect(response.content_type).to(eq('application/json'))
          expect(body_content_keys).to(include(*response_keys))
        end
      end
    end

    describe 'GET #show' do
      context 'when requesting html' do
        it 'renders the entity index' do
          entity = create(:entity_with_tasks)

          get entity_path(entity)

          expect(response).to(render_template(:index))
          expect(response.status).to(eq(200))
          expect(response.content_type).to(eq('text/html'))
        end
      end

      context 'when requesting json' do
        it 'renders data for a single entity' do
          entity = create(:entity_with_tasks)
          response_keys = %w(id name data links)

          get entity_path(entity), as: :json
          body_content_keys = body_content.keys

          expect(response.status).to(eq(200))
          expect(response.content_type).to(eq('application/json'))
          expect(body_content_keys).to(include(*response_keys))
        end
      end
    end
  end
end
