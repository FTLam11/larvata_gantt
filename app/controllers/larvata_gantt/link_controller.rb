require_dependency "larvata_gantt/application_controller"

module LarvataGantt
  class LinkController < ApplicationController
    before_action :set_link, only: [:update, :destroy]

    def create
      link = Link.new(source_id: link_params[:source],
                      target_id: link_params[:target],
                      typing: link_params[:type].to_i)

      if link.save
        render json: { action: "inserted", tid: link.id }, status: 201
      else
        render json: { action: "error", message: link.errors.full_messages }, status: 400
      end
    end

    def update
      respond_to do |format|
        format.json do
          if @link.update(source_id: link_params[:source],
                          target_id: link_params[:target],
                          typing: link_params[:type].to_i)
            render json: { action: "updated" }
          else
            render json: { action: "error", message: @link.errors.full_messages }, status: 400
          end
        end
      end
    end

    def destroy
      respond_to do |format|
        format.json do
          @link.destroy
          render json: { action: "deleted" }
        end
      end
    end

    private

    def link_params
      params.permit(:source, :target, :type)
    end

    def set_link
      @link = Link.find(params[:id])
    end
  end
end
