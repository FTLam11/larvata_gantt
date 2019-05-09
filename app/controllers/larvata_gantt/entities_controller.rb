require_dependency "larvata_gantt/application_controller"

module LarvataGantt
  class EntitiesController < ApplicationController
    def index
      respond_to do |format|
        format.html
        format.json do
          render json: { entities: LarvataGantt.entity_class.all.map { |entity| serialize(entity) } }
        end
      end
    end

    def show
      entity = LarvataGantt.entity_class.find(params[:id])

      respond_to do |format|
        format.html { render :index }
        format.json { render json: entity }
      end
    end

    private

    def serialize(entity)
      {
        id: entity.id,
        name: entity.name,
      }
    end
  end
end
