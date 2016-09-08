class HomeController < ApplicationController
  def index
  end

  def bootstrap
  end

  def chart_data
    render json: Chart.get_data
  end

  def d3
    render 'd3', locals: { a: 1 }
  end
end
