<%@ page language="java" 
    import="com.abrstech.obd2.log.*,java.util.*,java.io.IOException"
	contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
%>

<%@ page errorPage="showError.jsp" %>
   
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>Flot Examples</title>
    <link href="layout.css" rel="stylesheet" type="text/css">
    <!--[if lte IE 8]><script language="javascript" type="text/javascript" src="../excanvas.min.js"></script><![endif]-->
    <script language="javascript" type="text/javascript" src="/ivweb/reports/flot/jquery.js"></script>
    <script language="javascript" type="text/javascript" src="/ivweb/reports/flot/jquery.flot.js"></script>
</head>

<body>

<%

	String IVWEB_VIN = (String) session.getAttribute( "IVWEB_VIN" ); // retrieve IVWEB_VIN from HTTP Session
	
	String sessiontimeout = "/ivweb/z_securityquery.jsp";
	
	// check for session timed out
	if( IVWEB_VIN == null ) {
		response.sendRedirect( sessiontimeout );
	}

	String htmlbreak = "<br>";
	Enumeration parameterList = request.getParameterNames();	
	String paramName = new String();
	String paramValue = new String();
	
	while( parameterList.hasMoreElements() ) {
	
		paramName = parameterList.nextElement().toString();
		paramValue = request.getParameter( paramName );				
		break; // get only first one
		
	}
	
	// build the flot 2-dimensional parameter string 
	// example:  [ [trip1, value1], [trip2, value2], [trip3, value3], [tripN, valueN] ];	
	StringTokenizer tokens = new StringTokenizer( paramValue, "|" );
	int tokenLength = tokens.countTokens();
	
	Float total = 0.0F;
	Float average = 0.0F;
	Float[] floatArray = new Float[ tokenLength ] ; // data values
	for( int i = 0 ; i < tokenLength ; i++ ) {
		floatArray[i] = new Float( tokens.nextToken() ) ;	
		total += floatArray[i];
	}
	average = total / tokenLength;
		
	//out.println( "<h3>VIN: " + IVWEB_VIN + "</h3>" );
	out.println( "<h3>Average: " + average.toString() + "</h3>" );
%>


<div id="placeholder" style="width:100%;height:400px;"></div>


<script type="text/javascript">

$(function () {
	
	var data = [];
	<% for ( int i = 0; i < tokenLength ; i++ ) { %>
		data[<%= i %>] = <%=floatArray[i]%>;
	<% } %>
	
	var d1 = [];
	for ( var i = 0; i < <%= tokenLength %> ; i++ ) {
        //d1.push( [i, Math.sin(i)] );
        d1.push( [ i, data[i] ] ); // pass an array [ x-axis, data value ]
	}
	
    $.plot($("#placeholder"), [ d1 ]);
    
 });
 </script>



<font face="Georgia, Arial, Garamond" size = "2">
<%	
	
	out.println( "Values: " + paramValue + htmlbreak );	
%>
</font>

</body>

</html>
