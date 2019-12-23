/**
 * Created by luohan on 2017/1/20.
 */
$(function () {
    var rem = document.body.clientWidth / 400;
    /**
     * Get the current time
     */
    function getNow() {
        var now = new Date();
        return {
            hours: now.getHours() + now.getMinutes() / 60,
            minutes: now.getMinutes() * 12 / 60 + now.getSeconds() * 12 / 3600,
            seconds: now.getSeconds() * 12 / 60
        };
    }
    /**
     * Pad numbers
     */
    function pad(number, length) {
        // Create an array of the remaining length + 1 and join it with 0's
        return new Array((length || 2) + 1 - String(number).length).join(0) + number;
    }
    var now = getNow();
    // Create the chart
    $('#container').highcharts({

            chart: {
                type: 'gauge',
                plotBackgroundColor: null,
                backgroundColor: null,
                plotBackgroundImage: null,
                plotBorderWidth: 0,
                plotShadow: false,
                height: document.body.clientWidth
            },
            credits: {
                enabled: false
            },
            title: {
                // text: 'The Highcharts clock'
                text: null
            },
            pane: {
                background: [{
                    // default background
                }, {
                    // reflex for supported browsers
                    backgroundColor: Highcharts.svg ? {
                        radialGradient: {
                            cx: 0.9,
                            cy: -0.6,
                            r: 0//1.9
                        },
                        stops: [
                            [0.5, 'rgba(255, 255, 255, 0.2)'],
                            [0.5, 'rgba(200, 200, 200, 0.2)']
                        ]
                    } : null
                }]
            },
            yAxis: {
                labels: {
                    distance: -24 * rem,
                    style: {
                        color:'#666',
                        fontSize:15 * rem + 'px',
                        fontWeight:'bold',
                    }
                },
                min: 0,
                max: 12,
                lineWidth: 0,
                showFirstLabel: false,
                minorTickInterval: 'auto',
                minorTickWidth: 1 * rem,
                minorTickLength: 5 * rem,
                minorTickPosition: 'inside',
                minorGridLineWidth: 0,
                minorTickColor: '#666',
                tickInterval: 1,
                tickWidth: 3 * rem,
                tickPosition: 'inside',
                tickLength: 10 * rem,
                tickColor: '#666',
                title: {
                    // text: 'Powered by<br/>LuohanCC',
                    text: null,
                    style: {
                        color: '#BBB',
                        fontWeight: 'normal',
                        fontSize: 8 * rem + 'px',
                        lineHeight: 10 * rem +'px'
                    },
                    y: 100
                }
            },

            tooltip: {
                enabled: false,
                animation: false,
                formatter: function () {
                    return this.series.chart.tooltipText;
                }
            },

            series: [{
                data: [{
                    id: 'hour',
                    y: now.hours,
                    dial: {
                        baseWidth: 6 * rem,
                        radius: '60%',
                        baseLength: '95%',
                        rearLength: 0,
                        backgroundColor: '#c03'
                    }
                }, {
                    id: 'minute',
                    y: now.minutes,
                    dial: {
                        baseWidth: 3 * rem,
                        baseLength: '95%',
                        rearLength: 0
                    }
                }, {
                    id: 'second',
                    y: now.seconds,
                    dial: {
                        baseWidth: 3 * rem,
                        radius: '100%',
                        rearLength: '20%',
                        baseLength: '10%'
                    }
                }],
                animation: false,
                dataLabels: {
                    enabled: false
                }
            }]
        },
        // Move
        function (chart) {
            setInterval(function () {
                now = getNow();
                var hour = chart.get('hour'),
                    minute = chart.get('minute'),
                    second = chart.get('second'),
                // run animation unless we're wrapping around from 59 to 0
                    /*
                    animation = now.seconds === 0 ?
                        false :
                    {
                        easing: 'easeOutElastic'
                    };
                    */
                    animation = false;
                // Cache the tooltip text
                chart.tooltipText =
                    pad(Math.floor(now.hours), 2) + ':' +
                    pad(Math.floor(now.minutes * 5), 2) + ':' +
                    pad(now.seconds * 5, 2);
                hour.update(now.hours, true, animation);
                minute.update(now.minutes, true, animation);
                second.update(now.seconds, true, animation);
            }, 1000);
        });
});
// Extend jQuery with some easing (copied from jQuery UI)
$.extend($.easing, {
    easeOutElastic: function (x, t, b, c, d) {
        var s=1.70158;
        var p=0;
        var a=c;
        if (t==0) return b;
        if ((t/=d)==1) return b+c;
        if (!p) p=d*.3;
        if (a < Math.abs(c)) {
            a=c; var s=p/4;
        }else
            var s = p/(2*Math.PI) * Math.asin (c/a);
        return a*Math.pow(2,-10*t) * Math.sin( (t*d-s)*(2*Math.PI)/p ) + c + b;
    }
});
