class MetricsController < ApplicationController
  def index
  end

  def metric_data
    metric = params.require(:metric)
    render json: Metric.get_data(metric)
  end

  def test_ajax
    render json: [{ time: 1, val: 2 }, { time: 2, val: 3}]
  end

  def show
  end

  def create
  end

  def update
  end
end
