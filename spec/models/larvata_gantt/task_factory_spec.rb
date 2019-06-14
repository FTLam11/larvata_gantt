require 'rails_helper'

module LarvataGantt
  RSpec.describe(TaskFactory, type: :model) do
    describe '::build' do
      it 'delegates build instructions to Task' do
        allow(Task).to(receive(:new))
        attrs = attributes_for(:task).merge(type: 'task')

        TaskFactory.build(attrs)

        expect(Task).to(have_received(:new))
      end

      it 'delegates build instructions to Project' do
        allow(Project).to(receive(:new))
        attrs = attributes_for(:task).merge(type: 'project')

        TaskFactory.build(attrs)

        expect(Project).to(have_received(:new))
      end

      it 'delegates build instructions to Milestone' do
        allow(Milestone).to(receive(:new))
        attrs = attributes_for(:task).merge(type: 'milestone')

        TaskFactory.build(attrs)

        expect(Milestone).to(have_received(:new))
      end

      it 'delegates build instructions to Meeting' do
        allow(Meeting).to(receive(:new))
        attrs = attributes_for(:task).merge(type: 'meeting')

        TaskFactory.build(attrs)

        expect(Meeting).to(have_received(:new))
      end

      it 'assigns a typing validation error when given a bogus type' do
        attrs = attributes_for(:task).merge(type: 'crazy type')

        task = TaskFactory.build(attrs)

        expect(task.errors[:typing].first).to(eq('crazy type is not a valid typing'))
      end
    end

    describe '::update' do
      it 'delegates update instructions to BasicTask' do
        task = create(:task)
        new_attrs = { id: task.id, text: 'Dawg', type: 'task' }
        allow(BasicTask).to(receive(:update_attrs).with(task.id, TaskFactory.send(:build_attrs_for, new_attrs)))

        TaskFactory.update(new_attrs)

        expect(BasicTask).to(have_received(:update_attrs).with(task.id, TaskFactory.send(:build_attrs_for, new_attrs)))
      end

      it 'assigns a typing validation error when given a bogus type' do
        task = create(:task)
        new_attrs = { id: task.id, text: 'Dawg', type: 'crazy type' }

        task = TaskFactory.update(new_attrs)

        expect(task.errors[:typing].first).to(eq('crazy type is not a valid typing'))
      end
    end
  end
end
