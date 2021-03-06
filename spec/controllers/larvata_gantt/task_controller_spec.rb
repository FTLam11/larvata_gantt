require 'rails_helper'

module LarvataGantt
  RSpec.describe(TaskController, type: :request) do
    describe 'POST #create' do
      it 'creates a task' do
        entity = create(:entity)
        params = { start_date: '2019-04-09', text: 'Buy toilet paper', end_date: '2019-04-14',
                   progress: 0, parent: 0, type: 'task', priority: 'High', entity_id: entity.id }

        post task_index_path, params: params, as: :json
        created_task = entity.tasks.last

        expect(response).to(have_http_status(201))
        expect(body_content).to(eq('action' => 'inserted', 'tid' => created_task.id))
      end

      it 'creates a project' do
        entity = create(:entity)
        params = { text: 'The jets', progress: 0, parent: 0, type: 'project', entity_id: entity.id }

        post task_index_path, params: params, as: :json
        created_task = entity.tasks.last

        expect(response).to(have_http_status(201))
        expect(body_content).to(eq('action' => 'inserted', 'tid' => created_task.id))
      end

      it 'creates a meeting' do
        entity = create(:entity)
        params = { start_date: '2019-04-09', text: 'Meeting about nothing', end_date: '2019-04-12', parent: 0,
                   details: 'Blah blah blah', type: 'meeting', entity_id: entity.id }

        post task_index_path, params: params, as: :json
        created_task = entity.tasks.last

        expect(response).to(have_http_status(201))
        expect(body_content).to(eq('action' => 'inserted', 'tid' => created_task.id))
      end

      it 'creates a milestone' do
        entity = create(:entity)
        params = { start_date: '2019-04-12', text: '50% building milestone',
                   end_date: '2019-04-12', progress: 0, parent: 0, type: 'milestone',
                   entity_id: entity.id }

        post task_index_path, params: params, as: :json
        created_task = entity.tasks.last

        expect(response).to(have_http_status(201))
        expect(body_content).to(eq('action' => 'inserted', 'tid' => created_task.id))
      end
    end

    describe 'PATCH #update' do
      it 'updates a task' do
        task = create(:task)
        params = { start_date: '2019-04-09', text: 'New task text', end_date: '2019-04-14',
                   progress: 0, parent: 0, type: 'task', priority: 'High' }

        patch task_path(task), params: params, as: :json

        expect(task.reload.text).to(eq(params[:text]))
        expect(response).to(have_http_status(200))
        expect(response.content_type).to(eq('application/json'))
        expect(body_content['action']).to(eq('updated'))
      end

      it 'updates a project' do
        project = create(:project)
        params = { text: 'The jets', progress: 0, parent: 0, type: 'project' }

        patch task_path(project), params: params, as: :json

        expect(project.reload.text).to(eq(params[:text]))
        expect(response).to(have_http_status(200))
        expect(response.content_type).to(eq('application/json'))
        expect(body_content['action']).to(eq('updated'))
      end

      it 'updates a meeting' do
        meeting = create(:meeting)
        params = { start_date: '2019-04-09', text: 'Meeting about nothing', end_date: '2019-04-12', parent: 0,
                   details: 'Blah blah blah', type: 'meeting' }

        patch task_path(meeting), params: params, as: :json

        expect(meeting.reload.text).to(eq(params[:text]))
        expect(response).to(have_http_status(200))
        expect(response.content_type).to(eq('application/json'))
        expect(body_content['action']).to(eq('updated'))
      end

      it 'updates a milestone' do
        milestone = create(:milestone)
        params = { start_date: '2019-04-12', text: '50% building milestone',
                   end_date: '2019-04-12', progress: 0, parent: 0, type: 'milestone' }

        patch task_path(milestone), params: params, as: :json

        expect(milestone.reload.text).to(eq(params[:text]))
        expect(response).to(have_http_status(200))
        expect(response.content_type).to(eq('application/json'))
        expect(body_content['action']).to(eq('updated'))
      end

      context 'with task ordering' do
        it 'can insert a task before a target task' do
          entity = create(:entity)
          target_task = create(:task, entity: entity, sort_order: 1)
          current_task = create(:task, entity: entity, sort_order: 2)
          params = { start_date: '2019-04-09', text: 'New task text', end_date: '2019-04-14',
                     progress: 0, parent: 0, type: 'task', priority: 'High', target: target_task.id }

          patch task_path(current_task), params: params, as: :json

          expect(current_task.reload.sort_order).to(eq(1))
          expect(target_task.reload.sort_order).to(eq(2))
          expect(response).to(have_http_status(200))
          expect(response.content_type).to(eq('application/json'))
          expect(body_content['action']).to(eq('updated'))
        end

        it 'can insert a task after a target task' do
          entity = create(:entity)
          current_task = create(:task, entity: entity, sort_order: 1)
          target_task = create(:task, entity: entity, sort_order: 2)
          params = { start_date: '2019-04-09', text: 'New task text', end_date: '2019-04-14',
                     progress: 0, parent: 0, type: 'task', priority: 'High', target: "next:#{target_task.id}" }

          patch task_path(current_task), params: params, as: :json

          expect(current_task.reload.sort_order).to(eq(3))
          expect(target_task.reload.sort_order).to(eq(2))
          expect(response).to(have_http_status(200))
          expect(response.content_type).to(eq('application/json'))
          expect(body_content['action']).to(eq('updated'))
        end
      end
    end

    describe 'DELETE #destroy' do
      it 'destroys a task' do
        task = create(:task)

        delete task_path(task), as: :json

        expect { task.reload }.to(raise_error(ActiveRecord::RecordNotFound))
        expect(response).to(have_http_status(200))
        expect(body_content['action']).to(eq('deleted'))
      end
    end
  end
end
