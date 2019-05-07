require_dependency "larvata_gantt/application_controller"

module LarvataGantt
  class TaskController < ApplicationController
    before_action :set_task, only: [:destroy]

    def create
      task = TaskFactory.build(task_params)

      if task.save
        render json: { action: "inserted", tid: task.id }, status: 201
      else
        render json: { action: "error", message: task.errors.full_messages }, status: 400
      end
    end

    def update
      task = TaskFactory.update(task_params)

      if task.save
        BasicTask.reorder(task, task_params[:target])
        render json: { action: "updated" }
      else
        render json: { action: "error", message: @task.errors.full_messages }, status: 400
      end
    end

    def destroy
      @task.destroy
      render json: { action: "deleted" }
    end

    private

    def task_params
      params.permit(:id, :larvata_gantt_portfolio_id, :text, :start_date, :end_date,
        :priority, :progress, :parent, :type, :target, :details)
    end

    def set_task
      @task = BasicTask.find(params[:id])
    end
  end
end
