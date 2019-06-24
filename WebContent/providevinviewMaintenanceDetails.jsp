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
out.println( "<H3>Maintenance History</H3>" );

%>


<sql:setDataSource dataSource="jdbc/abrstech_obd2db" />

<sql:query var="rs1">    
	select SUM(cost) as total_cost from abrstech_obd2db.car_mtnc_tbl where vin="<%=vin%>" 
</sql:query>

<c:forEach var="row1" items="${rs1.rows}">
    <H3>Total Cost of Maintenance Services to Date ($): &nbsp; ${row1.total_cost} </H3><br><br>    
</c:forEach>

<sql:query var="rs2">    
	select * from abrstech_obd2db.car_mtnc_tbl where vin="<%=vin%>" order by dateofservice desc
</sql:query> 

<c:forEach var="row2" items="${rs2.rows}">
    Date of Service: &nbsp; ${row2.dateofservice} &nbsp; &nbsp; Odometer: &nbsp; ${row2.odometer} &nbsp; &nbsp; Cost ($): &nbsp; ${row2.cost} <br>
    Maintenance Performed: ${row2.servicesperformed} <br><br>
</c:forEach>

</font>

</body>
</html>