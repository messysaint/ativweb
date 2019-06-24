<!DOCTYPE html>
<html>
<head>
  <title>http://jsfiddle.net/RctL3/1/</title>
  
  <script type="text/javascript" src="/ivweb/dist/gauge.min.js"></script>
  <!--[if lt IE 9]><script type="text/javascript" src="/ivweb/assets/excanvas.compiled.js"></script><![endif]-->
  
</head>
<body>

<canvas id="foo">gauge</canvas>

	<script type="text/javascript">
		var opts = {
			lines : 20, // The number of lines to draw
			angle : 0.01, // The length of each line
			lineWidth : 0.70, // The line thickness
			pointer : {
				length : 0.7, // The radius of the inner circle
				strokeWidth : 0.035, // The rotation offset
				color : '#000000' // Fill color
			},
			colorStart : '#6FADCF', // Colors
			colorStop : '#8FC0DA', // just experiment with them
			strokeColor : '#E0E0E0', // to see which ones work best for you
			generateGradient : true
		};
		var target = document.getElementById('foo'); // your canvas element
		var gauge = new Gauge(target);

		gauge.setOptions(opts); // create sexy gauge!
		gauge.maxValue = 3000; // set max gauge value
		gauge.animationSpeed = 32; // set animation speed (32 is default value)
		gauge.set(1250); // set actual value
	</script>

</body>
</html>