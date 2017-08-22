class HomeController < ApplicationController
  def index
  end

  def bootstrap
  end

  def metric_data
    metric = params.require(:metric)
    render json: Metric.get_data(metric)
  end

  def test_ajax
    render json: [{ time: 1, val: 2 }, { time: 2, val: 3}]
  end

  def d3
    render 'd3', locals: { a: 1 }
  end

  def d4
  end

  def dostuff
    if params.require(:act) == "light"
      result = `../haus/haus.py light`
      render text: result
    else
      puts params.count
      render text: "no valid action given\n"
    end
  end

  def erbtest
  end

  private


end
