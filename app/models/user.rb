class User < ActiveRecord::Base
  def self.get_config
    {
      user_name: 'bob',
      dashboard: {
        panels: {
          foo_panel: [
            { chart_name: 'foo_chart', refresh_interval: 60 },
            { chart_name: 'bar_chart', refresh_interval: 60 }
          ],
          bar_panel: [
            { chart_name: 'yo_chart', refresh_interval: 60 },
            { chart_name: 'wee_chart', refresh_interval: 60 }
          ]
        }
      }
    }
  end

  def validate_config
    # TODO: this method should validate the JSON object structure is correct
  end
end
