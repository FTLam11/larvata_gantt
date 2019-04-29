require_dependency "larvata_gantt/application_controller"

module LarvataGantt
  class PortfoliosController < ApplicationController
    before_action :set_portfolio, only: [:show, :update, :destroy]

    def index
      respond_to do |format|
        format.html

    # GET /portfolios/1
    def show
      end
    end

    # POST /portfolios
    def create
      @portfolio = Portfolio.new(portfolio_params)

      if @portfolio.save
        redirect_to @portfolio, notice: 'Portfolio was successfully created.'
      else
        render :new
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
