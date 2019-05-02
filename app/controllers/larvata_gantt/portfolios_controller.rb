require_dependency "larvata_gantt/application_controller"

module LarvataGantt
  class PortfoliosController < ApplicationController
    before_action :set_portfolio, only: [:show, :update, :destroy]

    def index
      respond_to do |format|
        format.html
        format.json do
          render json: { portfolios: Portfolio.fully_scoped.map { |portfolio| serialize(portfolio) } }
        end
      end
    end

    def create
      respond_to do |format|
        format.json do
          portfolio = Portfolio.create(portfolio_params)
          render json: { message: '成功儲存', portfolio: serialize(portfolio) }, status: 201
        end
      end
    end

    def show
      respond_to do |format|
        format.html { render :index }
        format.json { render json: @portfolio }
      end
    end

    def update
      respond_to do |format|
        format.json do
          @portfolio.update(portfolio_params)
          render json: { message: '成功更新', portfolio: serialize(@portfolio) }
        end
      end
    end

    # DELETE /portfolios/1
    def destroy
      @portfolio.destroy
      redirect_to portfolios_url, notice: 'Portfolio was successfully destroyed.'
    end

    private

    def set_portfolio
      @portfolio = Portfolio.find(params[:id])
    end

    def portfolio_params
      params.require(:portfolio).permit(:entity_id, :name)
    end

    def serialize(portfolio)
      {
        id: portfolio.id,
        name: portfolio.name,
        entity_name: portfolio.entity.name,
        entity_id: portfolio.entity.id,
        task_count: portfolio.tasks.size,
        start_date: portfolio.start_date,
      }
    end
  end
end
