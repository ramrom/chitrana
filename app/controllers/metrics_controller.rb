class MetricsController < ApplicationController
  def index
    render json: Metric.all.limit(10)
  end

  def get_data
    metric_response = Metric.get_data(metric_name: params.require(:metric_name))
    if metric_response[:error].present?
      render json: metric_response, status: :unprocessable_entity
    else
      render json: metric_response
    end
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
