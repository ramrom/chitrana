var chitrana = chitrana || {};

// gridlines in x axis function
//chitrana.make_x_gridlines = function(x) { return d3.axisBottom(x).ticks(5); }
function make_x_gridlines(x) { return d3.axisBottom(x).ticks(5); }

// gridlines in y axis function
function make_y_gridlines(y) { return d3.axisLeft(y).ticks(5) }

// draw a graph!
function drawGraph(parent_tag, name, data, full_size) {
  full_size = { width: 960, height: 500 }
  //full_size = { width: 500, height: 250 }

  // set the dimensions and margins of the graph
  var margin = {top: 20, right: 20, bottom: 30, left: 50},
      width = full_size.width - margin.left - margin.right,
      height = full_size.height - margin.top - margin.bottom;

  // define the line
  var valueline = d3.line()
    .x(function(d) { return x(d.date); })
    .y(function(d) { return y(d.close); });

  // append the svg obgect to the body of the page
  // appends a 'group' element to 'svg'
  // moves the 'group' element to the top left margin
  //var svg = $('body').append("<svg id="+name+"></svg>")
  var svg = d3.select("body").append("svg")
    .attr("id", name)
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
    .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

  // add the X gridlines
  //x_grid = svg.append("g")
  //  .attr("class", "grid")
  //  .attr("transform", "translate(0," + height + ")")
  //  .call(make_x_gridlines()
  //    .tickSize(-height)
  //    .tickFormat(""));

  ////x_grid.select('path').style('stroke-width', 0);
  ////x_grid.selectAll('line').style('stroke', 'lightgrey').style('stroke-opacity', 0.7).style('shape-rendering', 'crispEdges');
  //
  //// add the Y gridlines
  //y_grid = svg.append("g")
  //  .attr("class", "grid")
  //  .call(make_y_gridlines()
  //      .tickSize(-width)
  //      .tickFormat(""));

  $('#' + name + ' .grid line')
    .css({'stroke': 'lightgrey', 'stroke-opacity': 0.7, 'shape-rendering': 'crispEdges'});
  $('#' + name + ' .grid path').css({'stroke-width': 0});

  var parseTime = d3.timeParse("%d-%b-%y");
  data.forEach(function(d) { d.date = parseTime(d.date); d.close = +d.close; });

  // set the ranges
  var x = d3.scaleTime().range([0, width]);
  var y = d3.scaleLinear().range([height, 0]);

  // Scale the range of the data
  x.domain(d3.extent(data, function(d) { return d.date; }));
  y.domain([0, d3.max(data, function(d) { return d.close; })]);

  // add the valueline path.
  svg.append("path")
    .data([data])
    .style('stroke-width', 2)
    .style('fill', 'none')
    .style('stroke', 'steelblue')
    .attr("class", "line")
    .attr("d", valueline);
    //.style({ 'stroke-width': 0 })

  // add the X Axis
  svg.append("g")
    .attr("transform", "translate(0," + height + ")")
    .call(d3.axisBottom(x));
  
  // add the Y Axis
  svg.append("g")
    .call(d3.axisLeft(y));
}
