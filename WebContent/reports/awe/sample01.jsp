<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>AwesomeChartJS demo</title>

<style>
body {
	background: #fff;
	color: #333;
}

a,a:visited,a:link,a:active {
	color: #333;
}

a:hover {
	color: #00f;
}

.charts_container {
	width: 900px;
	height: 420px;
	margin: 10px auto;
}

.chart_container_centered {
	text-align: center;
	width: 900px;
	height: 420px;
	margin: 10px auto;
}

.chart_container {
	width: 400px;
	height: 400px;
	margin: 0px 25px;
	float: left;
}

.footer {
	font-size: small;
	text-align: right;
}
</style>

<script type="application/javascript" src="awesomechart.js"> </script>

</head>

<body>

        <div class="charts_container">
            <div class="chart_container">

                <canvas id="chartCanvas1" width="700" height="500">
                    Your web-browser does not support the HTML 5 canvas element.
                </canvas>
        </div>
         
        <p class="footer">Data source: <a href="http://gs.statcounter.com/#browser-ww-monthly-200912-201012-bar" target="_blank">StatCounter</a></p>
						

		<c:set var="b1" value="IE"/> 
        <c:set var="b2" value="Firefox"/>
        <c:set var="b3" value="Chrome"/>
        <c:set var="b4" value="Safari"/>
        <c:set var="b5" value="Opera"/>
        <c:set var="b6" value="Other"/>
            
		<script type="application/javascript">		    
		
            var chart1 = new AwesomeChart('chartCanvas1');
                                               
            var b1 = '<c:out value="${b1}"/>';
            var b2 = '<c:out value="${b2}"/>';
            var b3 = '<c:out value="${b3}"/>';
            var b4 = '<c:out value="${b4}"/>';
            var b5 = '<c:out value="${b5}"/>';
            var b6 = '<c:out value="${b6}"/>';

            chart1.title = "Worldwide browser market share: December 2010";
            chart1.data = [51.62,31.3,10.06,4.27,1.96,0.78];
            chart1.labels = [b1,b2,b3,b4,b5,b6];
            chart1.colors = ['#006CFF', '#FF6600', '#34A038', '#945D59', '#93BBF4', '#F493B8'];
            chart1.randomColors = true;
            chart1.draw();
			
        </script>
        
</body>
</html>