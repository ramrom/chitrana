class MetricsController < ApplicationController
  def index
    render json: Metric.all.limit(10)
  end

  def get_data
    render json: Metric.get_data(metric_name: params.require(:metric_name))
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
