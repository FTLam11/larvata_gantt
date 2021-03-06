require 'rails_helper'

module LarvataGantt
  RSpec.describe(LinkController, type: :request) do
    describe 'POST #create' do
      context 'with valid source and target' do
        it 'creates a link' do
          project = create(:project)
          task = create(:task)
          params = { source: project.id, target: task.id, type: Link.typings[:finish_to_finish].to_s }

          post link_index_path, params: params
          created_link = Link.where(source: project, target: task, typing: params[:type]).last

          expect(response).to(have_http_status(201))
          expect(body_content).to(eq('action' => 'inserted', 'tid' => created_link.id))
        end
      end

      context 'with invalid source and target' do
        it 'does not create the link and responds with an error' do
          task = create(:task)
          params = { source: task.id, target: task.id, type: Link.typings[:finish_to_finish].to_s }
          link_count = Link.count

          post link_index_path, params: params

          expect(Link.count).to(eq(link_count))
          expect(response).to(have_http_status(400))
          expect(body_content['action']).to(eq('error'))
          expect(body_content['message']).to(include("Target can't be same as source"))
        end
      end
    end

    describe 'PATCH #update' do
      it 'updates a link' do
        link = create(:link)
        new_target = create(:task)
        params = { source: link.source.id, target: new_target.id, type: Link.typings[:finish_to_finish].to_s }

        patch link_path(link), params: params

        expect(link.reload.target.id).to(eq(new_target.id))
        expect(response).to(have_http_status(200))
        expect(body_content['action']).to(eq('updated'))
      end
    end

    describe 'DELETE #destroy' do
      it 'destroys a link' do
        link = create(:link)

        delete link_path(link)

        expect { link.reload }.to(raise_error(ActiveRecord::RecordNotFound))
        expect(response).to(have_http_status(200))
        expect(body_content['action']).to(eq('deleted'))
      end
    end
  end
end
