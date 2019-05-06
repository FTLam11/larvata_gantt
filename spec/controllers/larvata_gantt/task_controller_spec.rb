require 'rails_helper'

module LarvataGantt
  RSpec.describe(TaskController, type: :request) do
    describe 'POST #create' do
      let(:headers) { { 'ACCEPT': 'application/json' } }


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
