require 'rails_helper'

module LarvataGantt
  RSpec.describe(TaskController, type: :request) do
    describe 'POST #create' do
      let(:headers) { { 'ACCEPT': 'application/json' } }

      it 'creates a task' do
        portfolio = create(:portfolio)
        params = { start_date: '2019-04-09', text: 'Buy toilet paper', end_date: '2019-04-14',
                   progress: 0, parent: 0, type: 'task', priority: 'High', larvata_gantt_portfolio_id: portfolio.id }

        post '/larvata_gantt/task', params: params, headers: headers
        body_content = JSON.parse(response.body)
        created_task = Task.where(portfolio: portfolio).last

        expect(response.status).to(eq(201))
        expect(body_content).to(eq('action' => 'inserted', 'tid' => created_task.id))
      end

      it 'creates a project' do
        portfolio = create(:portfolio)
        params = { start_date: '2019-04-09', text: 'The jets', end_date: '2019-04-10',
                   progress: 0, parent: 0, type: 'project', larvata_gantt_portfolio_id: portfolio.id }

        post '/larvata_gantt/task', params: params, headers: headers
        body_content = JSON.parse(response.body)
        created_task = Task.where(portfolio: portfolio).last

        expect(response.status).to(eq(201))
        expect(body_content).to(eq('action' => 'inserted', 'tid' => created_task.id))
      end

      it 'creates a meeting' do
        portfolio = create(:portfolio)
        params = { start_date: '2019-04-09', text: 'Meeting about nothing',
                   end_date: '2019-04-12', progress: 0, parent: 0, details: 'Blah blah blah',
                   type: 'meeting', larvata_gantt_portfolio_id: portfolio.id }

        post '/larvata_gantt/task', params: params, headers: headers
        body_content = JSON.parse(response.body)
        created_task = Task.where(portfolio: portfolio).last

        expect(response.status).to(eq(201))
        expect(body_content).to(eq('action' => 'inserted', 'tid' => created_task.id))
      end

      it 'creates a milestone' do
        portfolio = create(:portfolio)
        params = { start_date: '2019-04-12', text: '50% building milestone',
                   end_date: '2019-04-12', progress: 0, parent: 0, type: 'milestone',
                   larvata_gantt_portfolio_id: portfolio.id }

        post '/larvata_gantt/task', params: params, headers: headers
        body_content = JSON.parse(response.body)
        created_task = Task.where(portfolio: portfolio).last

        expect(response.status).to(eq(201))
        expect(body_content).to(eq('action' => 'inserted', 'tid' => created_task.id))
      end
    end

    describe 'PATCH #update' do
      it 'updates a task' do
        task = create(:task)
        params = { text: 'New task text', type: 'project', priority: 'low' }

        patch "/larvata_gantt/task/#{task.id}", params: params, headers: headers
        body_content = JSON.parse(response.body)

        expect(task.reload.text).to(eq(params[:text]))
        expect(response.status).to(eq(200))
        expect(response.content_type).to(eq('application/json'))
        expect(body_content['action']).to(eq('updated'))
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
