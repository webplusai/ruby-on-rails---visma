
// Config options for flot graph
var monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];

var flotConfig = {
	yaxis: {
		min: 0,
	},
	xaxis: {
		
	},
	series: {
		lines: {
			show: true,
			fill: true,
			fillColor: { colors: [ { opacity: 0.4 }, { opacity: 0.1 } ] },
			lineWidth: 1.5
		},
		points: {
			show: true,
			radius: 2.5,
			lineWidth: 1.1,
			fill: true,
			fillColor: "#ffffff",
			symbol: "circle" 					// or callback
		},
		shadowSize: 0
	},
	grid: {
		hoverable: true,
		show: true,
		borderColor: "#efefef", 				// set if different from the grid color
		tickColor: "rgba(0,0,0,0.06)", 			// color for the ticks, e.g. "rgba(0,0,0,0.15)"
		labelMargin: 10, 						// in pixels
		axisMargin: 8, 							// in pixels
		borderWidth: 0, 						// in pixels
		minBorderMargin: 10, 					// in pixels, null means taken from points radius
		mouseActiveRadius: 5 					// how far the mouse can be away to activate an item
	},
	tooltip: true,
	tooltipOpts: {
		content: '%y',
		defaultTheme: false
	}
};