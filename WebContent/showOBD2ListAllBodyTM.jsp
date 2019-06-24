<%@ page language="java" 
	contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="com.abrstech.obd2.log.*,java.text.Collator, java.text.DateFormat, java.text.SimpleDateFormat,java.util.Date, com.abrstech.obd2.security.*" 
%>
    
<%@ page errorPage="showError.jsp" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<title>Modify business form</title>

<script type="text/javascript" src="/ivweb/jscript/validateOBD2CodeDescription.js"></script>

</head>
<body>

<font face="Georgia, Arial, Garamond" size = "2">

<%

	DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	Date date = new Date();
	String SystemDT = dateFormat.format(date);

	Integer IVWEB_SEQNO = (Integer) session.getAttribute( "IVWEB_SEQNO" ); // retrieve IVWEB_VIN from HTTP Session
	
	String htmlbreak = "<br>";

	//String errorMsg = "<H3>No Trusted Mechanic has been selected yet ...</H3>";
	String addOBD2Code   = "[&nbsp;&nbsp;<A href=\"/ivweb/addOBD2CodeTM.jsp\">Add this Code</A>&nbsp;&nbsp;]";
	
	
	String sessiontimeout = "/ivweb/z_securityqueryTM.jsp";
	
	//checkAuth check = new checkAuth();

	String IsHuman = (String) session.getAttribute( "IVWEB_ISHUMAN" );
	
	String obd2code = (String) session.getAttribute( "SESSION_obd2code" );
	String car_years = (String) session.getAttribute( "SESSION_car-years" );
	String car_makes = (String) session.getAttribute( "SESSION_car-makes" );
	String car_models = (String)session.getAttribute( "SESSION_car-models" );
	String car_model_trims = (String) session.getAttribute( "SESSION_car-model-trims" );

	//if( !check.isLoggedIn( IsHuman ) ) {	// if not logged in, ask user to log in
	//	response.sendRedirect( sessiontimeout );
	//}
	
	// check for session timed out
	if( IVWEB_SEQNO == null ) {
		String errorMsg = "<H3>No Trusted Mechanic has been selected yet ...</H3>";
    	String redirectMsg = "<br>Redirecting to Select Vehicle ...";
    	
    	out.println( errorMsg );
	} else {
	
		
			
		if (obd2code != null) {
			obd2code = obd2code.trim();
		} else { // code is NULL
			obd2code = "";
			car_years = "";
			car_makes = "";
			car_models = "";
			car_model_trims = "";
		}
		
		if ( (obd2code != null) && (obd2code.length() == 5) ) {

%>

		[ &nbsp; <a href="/ivweb/showOBD2ListAllTM.jsp">List All Codes</a>  &nbsp; ] &nbsp; &nbsp;		
		[ &nbsp; <a href="/ivweb/showOBD2ListAllPowertrainTM.jsp">List Powertrain Codes</a>  &nbsp; ] &nbsp; &nbsp;
		[ &nbsp; <a href="/ivweb/showOBD2ListAllBodyTM.jsp">List Body Codes</a>  &nbsp; ] &nbsp; &nbsp;
		[ &nbsp; <a href="/ivweb/showOBD2ListAllChasisTM.jsp">List Chasis Codes</a>  &nbsp; ] &nbsp; &nbsp;
		[ &nbsp; <a href="/ivweb/showOBD2ListAllUtilityTM.jsp">List Utility Codes</a>  &nbsp; ] &nbsp; &nbsp;
		
		<table border="0">
  		<tr>
    		<td><h3><%=obd2code%></h3></td>
  		</tr>     
		</table> 
    
<sql:setDataSource dataSource="jdbc/abrstech_obd2db" />

<sql:query var="rs">    
	SELECT OBD2.obd2key, OBD2.code, OBD2.description   
	FROM   abrstech_obd2db.ref_obd2code_tbl as OBD2   
	WHERE LOCATE( 'B', OBD2.code ) = 1  
	ORDER BY OBD2.code 				
</sql:query>

<%
int i = 0; 
%>
<c:forEach var="row" items="${rs.rows}">
	 <%=++i%>. ${row.code} : &nbsp;	 
	 ${row.description} &nbsp;	       
    <br><br>
</c:forEach>

<%
 
      } // obd2 code null
%>

<br><br>


<%
	} // end if session did not timeout
%>


</font>

</body>
</html>