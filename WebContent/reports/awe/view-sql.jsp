<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>

<title>Modified AwesomeChartJS demo</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="/ivweb/reports/awe/mystyle.css" />
<script type="application/javascript" src="/ivweb/reports/awe/awesomechart.js"> </script>

</head>


<body>


	<sql:setDataSource dataSource="jdbc/appservlogs" />

	<sql:query var="rs">    
		select count(*) as numctr from appservlogs.smaccesslog
		where sm_event = 'AuthAccept' and ( sm_timestamp >= ? and   sm_timestamp <= ? ) 
		<sql:param value="${param.fromdatetime}" />	
		<sql:param value="${param.todatetime}" />
	</sql:query>


	<c:forEach var="row" items="${rs.rows}">    	           
    	<c:set var="sqlv1" value="51.62"/>    	
    	<c:set var="sqlv2" value="31.3"/>
    	<c:set var="sqlv3" value="10.06"/>
    	<c:set var="sqlv4" value="4.27"/>
    	<c:set var="sqlv5" value="1.96"/>
    	<c:set var="sqlv6" value="0.78"/>
	</c:forEach>



    <div class="charts_container">

         <div class="chart_container">
         	<canvas id="chartCanvas1" width="700" height="500">
                 Your web-browser does not support the HTML 5 canvas element.
         	</canvas>
         </div>

    </div>
           
						
						
	<c:set var="t1" value="Worldwide Browser Market Share: December 2010"/>

	<c:set var="b1" value="IE"/> 
    <c:set var="b2" value="Firefox"/>
    <c:set var="b3" value="Chrome"/>
    <c:set var="b4" value="Safari"/>
    <c:set var="b5" value="Opera"/>
    <c:set var="b6" value="Other"/>
            
                       
    <c:set var="c1" value="#006CFF"/> 
    <c:set var="c2" value="#FF6600"/>
    <c:set var="c3" value="#34A038"/>
    <c:set var="c4" value="#945D59"/>
    <c:set var="c5" value="#93BBF4"/>
    <c:set var="c6" value="#F493B8"/>
        
        
            
	<script type="application/javascript">		    
		
            var chart1 = new AwesomeChart('chartCanvas1');
                                               
            var title = '<c:out value="${t1}"/>';
            
            var browser1= '<c:out value="${b1}"/>';
            var browser2 = '<c:out value="${b2}"/>';
            var browser3 = '<c:out value="${b3}"/>';
            var browser4 = '<c:out value="${b4}"/>';
            var browser5 = '<c:out value="${b5}"/>';
            var browser6 = '<c:out value="${b6}"/>';

            var value1 = '<c:out value="${sqlv1}"/>';  
            var value2 = '<c:out value="${sqlv2}"/>';
            var value3 = '<c:out value="${sqlv3}"/>';
            var value4 = '<c:out value="${sqlv4}"/>';
            var value5 = '<c:out value="${sqlv5}"/>';
            var value6 = '<c:out value="${sqlv6}"/>';
            
            var color1 = '<c:out value="${c1}"/>';  
            var color2 = '<c:out value="${c2}"/>';
            var color3 = '<c:out value="${c3}"/>';
            var color4 = '<c:out value="${c4}"/>';
            var color5 = '<c:out value="${c5}"/>';
            var color6 = '<c:out value="${c6}"/>';
            
            chart1.title = title;
            chart1.data = [value1,value2,value3,value4,value5,value6];
            chart1.labels = [browser1,browser2,browser3,browser4,browser5,browser6];
            chart1.colors = [color1, color2, color3, color4, color5, color6];
            chart1.randomColors = true;
            chart1.draw();
			
     </script>
     
        
                                
</body>
</html>