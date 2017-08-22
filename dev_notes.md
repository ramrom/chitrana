chart categories:
  - chart format
    - line chart, bar chart
  - real time chart
    - assumption is we are obviously measuring something that changes in time
    - we are measuring something that changes like 1 second - 1 minute timeframe essentially
    - we only query for new data points, this hopefully is more efficient code
  - composite charts
    - this is like 3 lines charts combined into the same chart

data sources:
  - e.g. a specific API (twitter API) or relational database (e.g. EIS or OLTP portfolio slave)
  - a source or data to query

chart:
  - area fills in graphs
  - x and y axis labels
  - graph label
  - atleast two themes, dark and light
  - a specific metric or data being displayed in a specific format
    - e.g. weather in chicago per day over for the last week, displayed as a line chart or bar chart
  - it has properties
    - textual: for line/bar: x-axis label, y-axis label, chart title, caption
    - graphical: line style (color, thickness, brightness), same for borders, gridlines, absolute size
  - can have multiple data sources?
  - mouse hover over line shows specific value in tooltip

chart on FE with d3js:
  - button to reload/re-render the chart
    - one that respects caching and one that forces cache invalidation
  - can show debug/stats like they query run time
  - shows a spinner icon or something when data (ajax call) is in process of being fetched
  - display/remove axis labels
  - display/remove grid lines for line and bar chart
  - BUG: on x-axis, the time/dates are ovelapping if there are a lot of data points

- Admin
  - globally accessible, so you can display easy in a panel
  - diags, should be able to see all charts and next call for ajax data refresh


TODO FOR SURE:
  - cache should use namespace in redis
  - check out new relic insights to see what i want to do
  - check out smallbusiness?(was that the name, it uses EIS) and see what feature are cool

Refs:
 - https://github.com/d3/d3-time-format
 - https://www.dashingd3js.com/dynamic-svg-coordinate-space
