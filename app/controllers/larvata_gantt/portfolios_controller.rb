require_dependency "larvata_gantt/application_controller"

module LarvataGantt
  class PortfoliosController < ApplicationController
    before_action :set_portfolio, only: [:show, :update, :destroy]

    def index
      respond_to do |format|
        format.html
        format.json do
          portfolios = Portfolio.fully_scoped.map do |portfolio|
            {
              id: portfolio.id,
              name: portfolio.name,
              entity_name: portfolio.entity.name,
              entity_id: portfolio.entity.id,
              task_count: portfolio.tasks.size,
              start_date: portfolio.start_date,
            }
          end

          render json: { portfolios: portfolios }
        end
      end
    end

    def create
      respond_to do |format|
        format.json do
          portfolio = Portfolio.create(portfolio_params)
          render json: { message: '成功儲存', portfolio: {
            id: portfolio.id,
            name: portfolio.name,
            entity_name: portfolio.entity.name,
            entity_id: portfolio.entity.id,
            task_count: 0,
            start_date: 'N/A',
          } }, status: 201
        end
      end
    end

    def show
      respond_to do |format|
        format.html { render :index }
        format.json { render json: @portfolio }
      end
    end

    # PATCH/PUT /portfolios/1
    def update
      if @portfolio.update(portfolio_params)
        redirect_to @portfolio, notice: 'Portfolio was successfully updated.'
      else
        render :edit
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
  end
end
