<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ page errorPage="showError.jsp" %>

<html>

<head>
<title>Car Maintenance</title>
</head>

<body>

<font face="Georgia, Arial, Garamond" size = "2">

<% 

String IVWEB_VIN = (String) session.getAttribute( "IVWEB_VIN" ); // retrieve IVWEB_VIN from HTTP Session

String sessiontimeout = "/ivweb/z_securityquery.jsp";

// check for session timed out
if( IVWEB_VIN == null ) {
	response.sendRedirect( sessiontimeout );
}

String vin = IVWEB_VIN; 
out.println( "<H3>Notes History</H3>" );
out.println( "<br>" );

%>


<sql:setDataSource dataSource="jdbc/abrstech_obd2db" />

<sql:query var="rs1">    
	select AVG(reliabilitydependabilityRating) as reliable, AVG(comfortRating) as comfortable, AVG(performanceRating) as performance, AVG(looksRating) as appearance, AVG(valueRating) as value, AVG(overAllRating) as overall from abrstech_obd2db.car_assess_tbl where vin="<%=vin%>" 
</sql:query> 

<c:forEach var="row1" items="${rs1.rows}">

	<H3>Over All Rating: &nbsp; ${row1.overall} </H3> <br>
    Reliability/Dependability: &nbsp; ${row1.reliable} &nbsp; &nbsp;  
    Comfort: &nbsp; ${row1.comfortable} &nbsp; &nbsp;
    Performance: &nbsp; ${row1.performance} &nbsp; &nbsp;
    Appearance: &nbsp; ${row1.appearance} &nbsp; &nbsp;
    Value: &nbsp; ${row1.value} &nbsp; &nbsp;
    <br><br><br>
    
</c:forEach>


<sql:query var="rs2">    
	select * from abrstech_obd2db.car_assess_tbl where vin="<%=vin%>" order by datetime desc
</sql:query> 

<c:forEach var="row2" items="${rs2.rows}">

    Date/Time: &nbsp; ${row2.datetime} <br> 
    Fuel Efficiency: Mixed City/Highway: &nbsp; ${row2.cityhighwaympg} &nbsp; &nbsp; City: &nbsp; ${row2.citympg} &nbsp;&nbsp; Highway: &nbsp; ${row2.highwaympg} <br>
    
    &nbsp; &nbsp; Notes: ${row2.otherNotes} <br><br>
    
</c:forEach>

</font>

</body>
</html>