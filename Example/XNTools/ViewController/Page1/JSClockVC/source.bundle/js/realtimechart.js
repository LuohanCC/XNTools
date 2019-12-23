$(function () {
  var rem = document.body.clientWidth / 1000;
  Highcharts.setOptions({
                        global: {
                        useUTC: false
                        }
                        });
  function activeLastPointToolip(chart) {
  var points = chart.series[0].points;
  chart.tooltip.refresh(points[points.length - 1]);
  }
  
  $('#container').highcharts({
                             chart: {
                             type: 'spline',
                             width: document.body.clientWidth,
                             height: document.body.clientWidth,
                             animation: Highcharts.svg, // don't animate in old IE
                             marginRight: 10,
                             events: {
                             load: function () {
                             // set up the updating of the chart each second
                             var series = this.series[0],
                             chart = this;
                             setInterval(function () {
                                         var x = (new Date()).getTime(), // current time
                                         y = Math.random();
                                         series.addPoint([x, y], true, true);
                                         activeLastPointToolip(chart)
                                         }, 1000);
                             }
                             }
                             },
                             title: {
                             text: '实时更新的图表',
                             style: {
                             color: '#333333',
                             fontWeight: 'bold',
                             fontSize:'13px'
                             }
                             },
                             xAxis: {
                             labels: {
                             style: {
                             color: '#258',
                             fontSize:'24px'
                             }
                             },
                             type: 'datetime',
                             lineWidth: 1.5,
                             lineColor: '#606060',
                             tickColor: '#606060',
                             tickLength: 8,
                             tickWidth: 1,
                             tickPixelInterval: 170,
                             gridLineColor: '#000',
                             minorTickInterval: 'auto',
                             minorTickWidth: 0.5
                             },
                             yAxis: {
                             title: {
                             text: '大气强度',
                             style: {
                             color: '#333333',
                             fontWeight: 'bold',
                             fontSize:'24px'
                             }
                             },
                             labels: {
                             style: {
                             color: '#258',
                             fontSize:'24px'
                             }
                             },
                             plotLines: [{
                                         value: 0,
                                         width: 4,
                                         }],
                             lineWidth: 1.5, //轴宽
                             lineColor: '#606060', //轴的颜色
                             tickColor: '#606060', //刻度颜色
                             tickLength: 8, //刻度长
                             tickWidth: 1, //刻度宽
                             tickPixelInterval: 90,
                             //minorGridLineDashStyle: 'longdash', //次级网格样式
                             gridLineColor: '#cccccc', //次级网格线的颜色
                             minorTickInterval: 'auto', //次级网格线的间隔
                             minorTickWidth: 0.5, //次级网格线宽
                             minorGridLineColor: '#f0f0f0' //网格线颜色次级
                             },
                             
                             tooltip: {
                             borderColor: "#777",
                             shadow: false,
                             animation: false,
                             style: {
                             color: '#333333',
                             fontWeight: 'bold',
                             fontSize:'12px'
                             //width: '30px',
                             //height: '10px'
                             },
                             //crosshairs:[true, true],
                             formatter: function () {
                             return '<b>' + this.series.name + '</b><br/>' +
                             Highcharts.dateFormat('%Y-%m-%d %H:%M:%S', this.x) + '<br/>' +
                             Highcharts.numberFormat(this.y, 2);
                             }
                             },
                             legend: {
                             enabled: false  //设置图例不可见
                             },
                             exporting: {
                             enabled: false  //设置导出按钮不可用
                             },
                             series: [{
                                      name: 'Random data',
                                      color: '#229988',
                                      data: (function () {
                                             // generate an array of random data
                                             var data = [],
                                             time = (new Date()).getTime(),
                                             i;
                                             for (i = -19; i <= 0; i += 1) {
                                             data.push({
                                                       x: time + i * 1000,
                                                       y: Math.random()
                                                       });
                                             }
                                             return data;
                                             }())
                                      }]
                             }, function (c) {
                             activeLastPointToolip(c)
                             });
  });
