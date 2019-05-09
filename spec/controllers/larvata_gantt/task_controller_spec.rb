require 'rails_helper'

module LarvataGantt
  RSpec.describe(TaskController, type: :request) do
    describe 'POST #create' do
      let(:headers) { { 'ACCEPT': 'application/json' } }

      it 'creates a task' do
        entity = create(:entity)
        params = { start_date: '2019-04-09', text: 'Buy toilet paper', end_date: '2019-04-14',
                   progress: 0, parent: 0, type: 'task', priority: 'High', entity_id: entity.id }

        post '/larvata_gantt/task', params: params, headers: headers
        body_content = JSON.parse(response.body)
        created_task = entity.tasks.last

        expect(response.status).to(eq(201))
        expect(body_content).to(eq('action' => 'inserted', 'tid' => created_task.id))
      end

      it 'creates a project' do
        entity = create(:entity)
        params = { text: 'The jets', progress: 0, parent: 0, type: 'project', entity_id: entity.id }

        post '/larvata_gantt/task', params: params, headers: headers
        body_content = JSON.parse(response.body)
        created_task = entity.tasks.last

        expect(response.status).to(eq(201))
        expect(body_content).to(eq('action' => 'inserted', 'tid' => created_task.id))
      end

      it 'creates a meeting' do
        entity = create(:entity)
        params = { start_date: '2019-04-09', text: 'Meeting about nothing', end_date: '2019-04-12', parent: 0,
                   details: 'Blah blah blah', type: 'meeting', entity_id: entity.id }

        post '/larvata_gantt/task', params: params, headers: headers
        body_content = JSON.parse(response.body)
        created_task = entity.tasks.last

        expect(response.status).to(eq(201))
        expect(body_content).to(eq('action' => 'inserted', 'tid' => created_task.id))
      end

      it 'creates a milestone' do
        entity = create(:entity)
        params = { start_date: '2019-04-12', text: '50% building milestone',
                   end_date: '2019-04-12', progress: 0, parent: 0, type: 'milestone',
                   entity_id: entity.id }

        post '/larvata_gantt/task', params: params, headers: headers
        body_content = JSON.parse(response.body)
        created_task = entity.tasks.last

        expect(response.status).to(eq(201))
        expect(body_content).to(eq('action' => 'inserted', 'tid' => created_task.id))
      end
    end

    describe 'PATCH #update' do
      it 'updates a task' do
        task = create(:task)
        params = { start_date: '2019-04-09', text: 'New task text', end_date: '2019-04-14',
                   progress: 0, parent: 0, type: 'task', priority: 'High' }

        patch "/larvata_gantt/task/#{task.id}", params: params, headers: headers
        body_content = JSON.parse(response.body)

        expect(task.reload.text).to(eq(params[:text]))
        expect(response.status).to(eq(200))
        expect(response.content_type).to(eq('application/json'))
        expect(body_content['action']).to(eq('updated'))
      end

      it 'updates a project' do
        project = create(:project)
        params = { text: 'The jets', progress: 0, parent: 0, type: 'project' }

        patch "/larvata_gantt/task/#{project.id}", params: params, headers: headers
        body_content = JSON.parse(response.body)

        expect(project.reload.text).to(eq(params[:text]))
        expect(response.status).to(eq(200))
        expect(response.content_type).to(eq('application/json'))
        expect(body_content['action']).to(eq('updated'))
      end

      it 'updates a meeting' do
        meeting = create(:meeting)
        params = { start_date: '2019-04-09', text: 'Meeting about nothing', end_date: '2019-04-12', parent: 0,
                   details: 'Blah blah blah', type: 'meeting' }

        patch "/larvata_gantt/task/#{meeting.id}", params: params, headers: headers
        body_content = JSON.parse(response.body)

        expect(meeting.reload.text).to(eq(params[:text]))
        expect(response.status).to(eq(200))
        expect(response.content_type).to(eq('application/json'))
        expect(body_content['action']).to(eq('updated'))
      end

      it 'updates a milestone' do
        milestone = create(:milestone)
        params = { start_date: '2019-04-12', text: '50% building milestone',
                   end_date: '2019-04-12', progress: 0, parent: 0, type: 'milestone' }

        patch "/larvata_gantt/task/#{milestone.id}", params: params, headers: headers
        body_content = JSON.parse(response.body)

        expect(milestone.reload.text).to(eq(params[:text]))
        expect(response.status).to(eq(200))
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

          patch "/larvata_gantt/task/#{current_task.id}", headers: headers, params: params, as: :json
          body_content = JSON.parse(response.body)

          expect(current_task.reload.sort_order).to(eq(1))
          expect(target_task.reload.sort_order).to(eq(2))
          expect(response.status).to(eq(200))
          expect(response.content_type).to(eq('application/json'))
          expect(body_content['action']).to(eq('updated'))
        end

        it 'can insert a task after a target task' do
          entity = create(:entity)
          current_task = create(:task, entity: entity, sort_order: 1)
          target_task = create(:task, entity: entity, sort_order: 2)
          params = { start_date: '2019-04-09', text: 'New task text', end_date: '2019-04-14',
                     progress: 0, parent: 0, type: 'task', priority: 'High', target: "next:#{target_task.id}" }

          patch "/larvata_gantt/task/#{current_task.id}", headers: headers, params: params, as: :json
          body_content = JSON.parse(response.body)

          expect(current_task.reload.sort_order).to(eq(3))
          expect(target_task.reload.sort_order).to(eq(2))
          expect(response.status).to(eq(200))
          expect(response.content_type).to(eq('application/json'))
          expect(body_content['action']).to(eq('updated'))
        end
      end
    end

    describe 'DELETE #destroy' do
      it 'destroys a task' do
        task = create(:task)

        delete "/larvata_gantt/task/#{task.id}", headers: headers
        body_content = JSON.parse(response.body)

        expect { task.reload }.to(raise_error(ActiveRecord::RecordNotFound))
        expect(response.status).to(eq(200))
        expect(body_content['action']).to(eq('deleted'))
      end
    end
  end
end
