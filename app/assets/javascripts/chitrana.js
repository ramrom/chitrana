var chitrana = chitrana || {};

// gridlines in x axis function
//chitrana.make_x_gridlines = function(x) { return d3.axisBottom(x).ticks(5); }
function make_x_gridlines() { return d3.axisBottom(x).ticks(5); }

// gridlines in y axis function
function make_y_gridlines() { return d3.axisLeft(y).ticks(5) }

// draw a graph!
function drawGraph(parent_tag, name, data, size, opts) {
  if (size.width && size.height) {
    width = size.width; height = size.height;
  } else { width = 960; height = 500; }

  // set the dimensions and margins of the graph
  var margin = {top: 20, right: 20, bottom: 30, left: 50},
  //var margin = {top: 20, right: 20, bottom: 30, left: 50},
      width = width - margin.left - margin.right,
      height = height - margin.top - margin.bottom;

  //var svg = $('body').append("<svg id="+name+"></svg>")
  var svg = d3.select('#'+parent_tag).append("svg")
    .attr("id", name)
    //.style(box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
    //.attr('class', 'z-depth-5')  - bootstrap shadow
    .style('box-shadow', '10px 10px 5px black')
    .style('border-radius', '30px')
    .style('background-color', '#333333')
    .style('border','10px')
    .style('border-color','black')
    .style('border-style','double')
    .style('padding','10px')
    .style('margin','10px')
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
    .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

  // set the time format if specified otherwise use default
  var parseTime = d3.timeParse("%d-%m-%Y");
  if (opts && opts.time_format) { parseTime = d3.timeParse(opts.time_format); }

  data.forEach(function(d) { d.date = parseTime(d.date); d.value = +d.value; });

  // set the ranges
  var x = d3.scaleTime().range([0, width]);
  var y = d3.scaleLinear().range([height, 0]);

  // Scale the range of the data
  x.domain(d3.extent(data, function(d) { return d.date; }));
  y.domain([0, d3.max(data, function(d) { return d.value; })]);

  // define the line
  var valueline = d3.line()
    .x(function(d) { return x(d.date); })
    .y(function(d) { return y(d.value); });

  // add the valueline path.
  svg.append("path")
    .data([data])
    .style('stroke-width', 6)
    .style('fill', 'none')
    .style('stroke', 'steelblue')
    .attr("class", "line")
    .attr("d", valueline);

  function make_x_gridlines() { return d3.axisBottom(x).ticks(5); }
  function make_y_gridlines() { return d3.axisLeft(y).ticks(5) }

  // add the X gridlines
  var x_grid = svg.append("g")
    .attr("class", "grid")
    .attr("transform", "translate(0," + height + ")")
    .call(make_x_gridlines()
      .tickSize(-height)
      .tickFormat(""));

  //x_grid.select('path').style('stroke-width', 0);
  //x_grid.selectAll('line').style('stroke', 'lightgrey').style('stroke-opacity', 0.7).style('shape-rendering', 'crispEdges');
  
  // add the Y gridlines
  var y_grid = svg.append("g")
    .attr("class", "grid")
    .call(make_y_gridlines()
        .tickSize(-width)
        .tickFormat(""));

  $('#' + name + ' .grid line')
    .css({'stroke': '#666666', 'stroke-opacity': 0.7, 'shape-rendering': 'crispEdges'});
  $('#' + name + ' .grid path').css({'stroke-width': 0});

  // add the X Axis
  svg.append("g")
    .attr('class', 'axis')
    .style('stroke','#dddddd')
    .attr("transform", "translate(0," + height + ")")
    .call(d3.axisBottom(x));
  
  // add the Y Axis
  svg.append("g")
    .attr('class', 'axis')
    .style('stroke','#dddddd')
    .call(d3.axisLeft(y));

  // fill the area under the line
  var area = d3.area()
    //.style('fill', 'lightsteelblue')
    //.style('stroke-width', 0)
    .x(function(d) { return x(d.date); })
    .y0(height)
    .y1(function(d) { return y(d.value); });
}
