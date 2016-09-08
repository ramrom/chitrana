class User < ActiveRecord::Base
  def self.get_config
    {
      dashboard: {
        panes: {
          foo_pane: [
            { chart_name: 'foo_chart', refresh_interval: 60 },
            { chart_name: 'bar_chart', refresh_interval: 60 }
          ]
          bar_pane: [
            { chart_name: 'yo_chart', refresh_interval: 60 },
            { chart_name: 'wee_chart', refresh_interval: 60 }
          ]
        }
      }
    }
  end
end
