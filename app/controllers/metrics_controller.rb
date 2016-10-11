class MetricsController < ApplicationController
  def index
    render json: Metric.all.limit(10)
  end

  def get_data
    metric_results = Metric.get_data(metric_name: params.require(:metric_name), opts: parse_opts)
    if metric_results[:error].present?
      render json: metric_results, status: :unprocessable_entity
    else
      render json: metric_results
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

  private

  def parse_opts
    {
      ignore_cache: params.permit(:ignore_cache) == 'true'
    }
  end
end
